@echo off
rem Licensed to the Apache Software Foundation (ASF) under one or more
rem contributor license agreements.  See the NOTICE file distributed with
rem this work for additional information regarding copyright ownership.
rem The ASF licenses this file to You under the Apache License, Version 2.0
rem (the "License"); you may not use this file except in compliance with
rem the License.  You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.

rem ---------------------------------------------------------------------------
rem Start script for the CATALINA Server
rem ---------------------------------------------------------------------------

setlocal

rem Guess CATALINA_HOME if not defined
rem 把当前目录设置到变量CURRENT_DIR中
set "CURRENT_DIR=%cd%"
rem 如果CATALINA_HOME不为空跳转到gotHome
if not "%CATALINA_HOME%" == "" goto gotHome
rem CATALINA_HOME为空把当前目录设置到变量CATALINA_HOME中
set "CATALINA_HOME=%CURRENT_DIR%"
rem 如果catalina.bat存在则跳转到okHome
if exist "%CATALINA_HOME%\bin\catalina.bat" goto okHome
cd ..
set "CATALINA_HOME=%cd%"
cd "%CURRENT_DIR%"
:gotHome
if exist "%CATALINA_HOME%\bin\catalina.bat" goto okHome
echo The CATALINA_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
goto end
:okHome

rem 设置EXECUTABLE变量
set "EXECUTABLE=%CATALINA_HOME%\bin\catalina.bat"

rem Check that target executable exists
if exist "%EXECUTABLE%" goto okExec
echo Cannot find "%EXECUTABLE%"
echo This file is needed to run this program
goto end
:okExec

rem 把setArgs代码块的返回结果赋值给CMD_LINE_ARGS变量, 这个变量用于存储启动参数
rem Get remaining unshifted(不合适的) command line arguments and save them in the
set CMD_LINE_ARGS=
:setArgs
rem 首先会判断是否有参数, (if ""%1""==""""判断第一个参数是否为空), 如果没有参数则相当于参数项为空. 如果有参数则循环遍历所有的参数(每次拼接第一个参数)
if ""%1""=="""" goto doneSetArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
rem 更改批处理文件中批处理参数的位置,将参数后移一位
shift
goto setArgs
:doneSetArgs

rem 执行命令, 注意: 第一个参数为start
call "%EXECUTABLE%" start %CMD_LINE_ARGS%

:end
