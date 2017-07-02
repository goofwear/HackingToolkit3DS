@echo off
IF EXIST "%PROGRAMFILES(x86)%" (SET CtrTool=CtrTool64.exe) ELSE (SET CtrTool=CtrTool32.exe)
cls
echo.
set CiaName=%~n1
set CiaExt=%~x1
set CiaFull=%CiaName%%CiaExt%
set /p DecompressCode="Decompress the code.bin file for "%CiaFull%" (n/y)? : "
if /i "%DecompressCode%"=="Y" (SET ScriptCode=xutf) ELSE (SET ScriptCode=xtf)
cls
echo.
echo Please wait, extraction of "%CiaFull%" in progress...
echo.
md %1_Unpacked >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\%CtrTool%" --content=%1_Unpacked/DecryptedApp %1 >NUL 2>NUL
ren %1_Unpacked\DecryptedApp.0000.* DecryptedPartition0.bin >NUL 2>NUL
ren %1_Unpacked\DecryptedApp.0001.* DecryptedPartition1.bin >NUL 2>NUL
ren %1_Unpacked\DecryptedApp.0002.* DecryptedPartition2.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cxi %1_Unpacked/DecryptedPartition0.bin --header %1_Unpacked/HeaderNCCH0.bin --exh %1_Unpacked/DecryptedExHeader.bin --exefs %1_Unpacked/DecryptedExeFS.bin --romfs %1_Unpacked/DecryptedRomFS.bin --logo %1_Unpacked/LogoLZ.bin --plain %1_Unpacked/PlainRGN.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa %1_Unpacked/DecryptedPartition1.bin --header %1_Unpacked/HeaderNCCH1.bin --romfs %1_Unpacked/DecryptedManual.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf cfa %1_Unpacked/DecryptedPartition2.bin --header %1_Unpacked/HeaderNCCH2.bin --romfs %1_Unpacked/DecryptedDownloadPlay.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition0.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition1.bin >NUL 2>NUL
del %1_Unpacked\DecryptedPartition2.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -%ScriptCode% exefs %1_Unpacked/DecryptedExeFS.bin --exefs-dir %1_Unpacked/ExtractedExeFS --header %1_Unpacked/HeaderExeFS.bin >NUL 2>NUL
ren %1_Unpacked\ExtractedExeFS\banner.bnr banner.bin >NUL 2>NUL
ren %1_Unpacked\ExtractedExeFS\icon.icn icon.bin >NUL 2>NUL
copy %1_Unpacked\ExtractedExeFS\banner.bin %1_Unpacked\banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -x -t banner -f %1_Unpacked\banner.bin --banner-dir %1_Unpacked/ExtractedBanner\ >NUL 2>NUL
ren %1_Unpacked\ExtractedBanner\banner0.bcmdl banner.cgfx >NUL 2>NUL
del %1_Unpacked\banner.bin >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedRomFS.bin --romfs-dir %1_Unpacked/ExtractedRomFS >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedManual.bin --romfs-dir %1_Unpacked/ExtractedManual >NUL 2>NUL
"%PROGRAMFILES%\HackingToolkit3DS\3dstool.exe" -xtf romfs %1_Unpacked/DecryptedDownloadPlay.bin --romfs-dir %1_Unpacked/ExtractedDownloadPlay >NUL 2>NUL