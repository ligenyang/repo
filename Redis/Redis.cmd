@echo off
cd %~dp0
echo redis-server.exe redis.windows.conf
redis-server.exe redis.windows.conf
pause
