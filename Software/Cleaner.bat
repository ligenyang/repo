@echo off
rem Created by Ligenyang on 2018/04/09.
echo Scavenging system garbage files, please waiting...
rem %systemdrive% C:
rem /f 强制删除只读文件
rem /s 从所有子目录删除指定文件
rem /q 安静模式，删除全局通配符时，不要求确认
del /f /s /q  %systemdrive%\*.tmp
del /f /s /q  %systemdrive%\*._mp
del /f /s /q  %systemdrive%\*.log
del /f /s /q  %systemdrive%\*.gid
del /f /s /q  %systemdrive%\*.chk
del /f /s /q  %systemdrive%\*.old
del /f /s /q  %systemdrive%\recycled\*.*
rem %windir% C:\Windows
del /f /s /q  %windir%\*.bak
del /f /s /q  %windir%\prefetch\*.*
rd /s /q %windir%\temp & md  %windir%\temp
rem %userprofile% C:\Users\Administrator
del /f /q  %userprofile%\cookies\*.*
del /f /q  %userprofile%\recent\*.*
del /f /s /q  "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q  "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q  "%userprofile%\recent\*.*"
echo Cleanup system LJ completion!
echo. & pause
