Unicode True
!include "MUI2.nsh"
!include "FileFunc.nsh"

!define APP_NAME "Vehicle Control Scanner"
!define APP_EXE "vehicle-control-scanner.exe"
!define APP_VERSION "0.1.0"
!define PUBLISHER "OldFarmer96"
!define INSTALL_DIR "$PROGRAMFILES64\Vehicle Control Scanner"

Name "${APP_NAME}"
OutFile "..\dist\VehicleControlScanner-Setup-${APP_VERSION}.exe"
InstallDir "${INSTALL_DIR}"
RequestExecutionLevel admin

!define MUI_ABORTWARNING
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "Spanish"

Section "Install"
  SetShellVarContext all
  SetOutPath "$INSTDIR"
  File /r "..\dist\vehicle-control-scanner\*"

  CreateDirectory "$APPDATA\vehicle-control-scanner"
  CreateDirectory "$APPDATA\vehicle-control-scanner\data"
  CreateDirectory "$APPDATA\vehicle-control-scanner\backups"
  CreateDirectory "$APPDATA\vehicle-control-scanner\logs"

  IfFileExists "$APPDATA\vehicle-control-scanner\.env" doneEnv
  CopyFiles "$INSTDIR\.env.example" "$APPDATA\vehicle-control-scanner\.env"
doneEnv:

  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortcut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"
  CreateShortcut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}"

  WriteUninstaller "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Publisher" "${PUBLISHER}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoRepair" 1
SectionEnd

Section "Uninstall"
  SetShellVarContext all
  Delete "$DESKTOP\${APP_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk"
  RMDir "$SMPROGRAMS\${APP_NAME}"

  Delete "$INSTDIR\${APP_EXE}"
  Delete "$INSTDIR\Uninstall.exe"
  Delete "$INSTDIR\.env.example"
  RMDir /r "$INSTDIR\_internal"
  RMDir "$INSTDIR"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
SectionEnd
