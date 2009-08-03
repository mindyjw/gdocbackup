; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "GDocBackup"
!define PRODUCT_VERSION "0.4.0"
!define PRODUCT_WEB_SITE "http://gs.fhtino.it/gdocbackup"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\GDocBackup.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"



; Welcome page
!insertmacro MUI_PAGE_WELCOME

; Warning page
!define MUI_WELCOMEPAGE_TITLE "WARNING"
!define MUI_WELCOMEPAGE_TEXT "GDocBackup uses the official Google Data APIs (.NET version) (http://code.google.com/p/google-gdata/). So the quality, accuracy and correctness of the exported files is out of the control of GDocBackup. If you encounter problems in the exported documents (i.e. the exported doc is not similar to the original on Google Docs), contact the Google Docs support forum:\r\n http://www.google.com/support/forum/p/Google+Docs "
!insertmacro MUI_PAGE_WELCOME

; License page
!insertmacro MUI_PAGE_LICENSE Apache_LICENSE-2.0.txt

; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\GDocBackup.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}_${PRODUCT_VERSION}_Setup.exe"
InstallDir "$PROGRAMFILES\GDocBackup"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "GDocBackup" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "CompiledBIN\Google.GData.Extensions.dll"
  File "CompiledBIN\Google.GData.Documents.dll"
  File "CompiledBIN\Google.GData.Client.dll"
  File "CompiledBIN\GDocBackupLib.dll"
  File "CompiledBIN\GDocBackup.exe"
  CreateDirectory "$SMPROGRAMS\GDocBackup"
  CreateShortCut "$SMPROGRAMS\GDocBackup\GDocBackup.lnk" "$INSTDIR\GDocBackup.exe"
  CreateShortCut "$DESKTOP\GDocBackup.lnk" "$INSTDIR\GDocBackup.exe"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\GDocBackup\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\GDocBackup\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\GDocBackup.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\GDocBackup.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\GDocBackup.exe"
  Delete "$INSTDIR\GDocBackupLib.dll"
  Delete "$INSTDIR\Google.GData.Client.dll"
  Delete "$INSTDIR\Google.GData.Documents.dll"
  Delete "$INSTDIR\Google.GData.Extensions.dll"

  Delete "$SMPROGRAMS\GDocBackup\Uninstall.lnk"
  Delete "$SMPROGRAMS\GDocBackup\Website.lnk"
  Delete "$DESKTOP\GDocBackup.lnk"
  Delete "$SMPROGRAMS\GDocBackup\GDocBackup.lnk"

  RMDir "$SMPROGRAMS\GDocBackup"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd