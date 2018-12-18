::Rotina_BackuppPublitech_MANUAL

@ECHO off & MODE 110,26 & COLOR 17 & TITLE Rotina_BackuppPublitech_MANUAL
FOR /F "tokens=1,2,3 delims=/ " %%a in ("%DATE%") do (
SET DIA=%%a
SET MES=%%b
SET ANO=%%c
)
FOR /F "tokens=1,2,3 delims=:, " %%a in ("%TIME%") do (
SET H=%%a
SET M=%%b
SET S=%%c
)
SET H=0%H%
SET H=%H:~-2%
SET DataHora=%ANO%-%MES%-%DIA%_%H%h%M%min

SET var="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

::SET cdLocal=%C1D%
SET past=%~dp0
SET cdLocal=%past:~0,-1%
%cdLocal:~0,2% & CD\"%cdLocal:~3,100%"

::Verifica se existe compactador 7z
set zip=0
IF EXIST "C:\Program Files\7-Zip\7z.exe" SET path=%PATH%;C:\Program Files\7-Zip& ECHO %DataHora%: Compactador 7z OK!>>"%cdLocal%\logBKPmanual.log"& set zip=1 & GOTO 7zVerificdo
IF EXIST "C:\Program Files (x86)\7-Zip\7z.exe" SET path=%PATH%;C:\Program Files (x86)\7-Zip& ECHO %DataHora%: Compactador 7z OK! (x86)>>"%cdLocal%\logBKPmanual.log"& set zip=1
:7zVerificdo
IF %zip%==0 (ECHO ERROR: Compactador 7Z nao encontrano, instale o 7z1602. & ECHO %DataHora%: ERROR: 7Z nao encontrano, instale o 7z1602!>>"%cdLocal%\logBKPmanual.log" & PING -n 6 127.0.0.1 >NUL & CLS)


CLS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                        
::   0000                                                                      
::   0000000                                                                   
::   0000000000                                                                
::   0000000                                                                   
::   0000                                                                      
::   00                                                                        
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::Verifica se existe config.ini
IF EXIST config.ini (GOTO ArquivoConfigOK)
::Cria config.ini
CLS & ECHO %DataHora%: Criando "config.ini"...>>"%cdLocal%\logBKPmanual.log"
ECHO Entidade............:Publitech>config.ini
ECHO Caminho.............:C:\Elotech\BackuppPublitech>>config.ini
ECHO CloudDrive..........:C:\Elotech\BackuppPublitech\DropBox>>config.ini
ECHO LimparMaisAntigosQue:20>>config.ini
ECHO  ::TipoBackup>>config.ini
ECHO BKP_Postgres........:S>>config.ini
ECHO BKP_Oracle..........:N>>config.ini
ECHO BKP_SQLServer.......:N>>config.ini
ECHO BKP_Saude...........:N>>config.ini
ECHO  ::Postgres>>config.ini
ECHO P_Base..............:dbteste>>config.ini
ECHO P_Host..............:localhost>>config.ini
ECHO P_Porta.............:5432>>config.ini
ECHO P_Usuario...........:postgres>>config.ini
ECHO P_Senha.............:w0k000gpds>>config.ini
ECHO P_SeparaEloarquivo..:N>>config.ini
ECHO  ::Oracle>>config.ini
ECHO O_Usuario...........:dbteste>>config.ini
ECHO O_Senha.............:e0m0e0pstt>>config.ini
ECHO O_Database..........:ORCL>>config.ini
ECHO O_Versao-10g-11g....:11g>>config.ini
ECHO O_SeparaEloarquivo..:N>>config.ini
ECHO  ::SQLServer>>config.ini
ECHO S_User..............:sa>>config.ini
ECHO S_Password..........:t0l0b0eroi>>config.ini
ECHO  ::Saude>>config.ini
ECHO SA_Base.............:dbteste>>config.ini
ECHO SA_Host.............:localhost>>config.ini
ECHO SA_Porta............:5432>>config.ini
ECHO SA_Usuario..........:postgres>>config.ini
ECHO SA_Senha............:w0k000gpds>>config.ini
ECHO  ::ConfigAgendamentoRotina>>config.ini
ECHO NomeRotina..........:Rotina_BackuppPublitech_Automatico.exe>>config.ini
ECHO HorarioBackup.......:18:00>>config.ini
ECHO CopiaOutroCaminho...:N>>config.ini

::ECHO CopiaNaRede_Endereco:\\192.168.1.1\BackuppPublitech>>config.ini

::Abre config.ino apos criar
START Config.ini
::Abre menu de aviso
CLS
@Echo.
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #        Criado arquivo "Config.ini"                                                        #
@ECHO. #        Altere a configuracao no arquivo para continuar.                                   #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #        1 - Continuar                                                                      #
@Echo. #        0 - SAIR                                                                           #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 10 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 GOTO ArquivoConfigOK
if %ERRORLEVEL%==2 EXIT
:ArquivoConfigOK
CLS

CD "%Caminho%"

IF EXIST "zBackupManual" (ren "zBackupManual" "zBackupManual")

%cdLocal:~0,2% & CD\"%cdLocal:~3,100%"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                        
::   0000                                                                      
::   0000000                                                                   
::   000000000                                                                 
::   0000000                                                                   
::   0000                                                                      
::   00                                                                        
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
CLS
ECHO Iniciando, aguarde... & PING -n 3 127.0.0.1 >NUL & CLS
::MODE 110,30

::SETa Entidade............:Publitech>config.ini
SETLOCAL
SET linha=1& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET Entidade=%conf:~0,30%
::ECHO Entidade: "%conf:~0,30%"

::SETa Caminho.............:C:\Elotech\BackuppPublitech>>config.ini
SETLOCAL
SET linha=2& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET Unidade=%conf:~0,1%
::ECHO Unidade: "%conf:~0,1%"

SETLOCAL
SET linha=2& SET conf=0
FOR /f "delims=: tokens=1,4" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET Pasta=%conf:~0,100%
::ECHO Pasta: "%conf:~0,100%"

SET Caminho=%Unidade%:%Pasta%
ECHO Caminho: "%Unidade%:%Pasta%"
ECHO.

::SETa P_Base..............:dbteste>>config.ini
SETLOCAL
SET linha=11& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET P_Base=%conf:~0,30%
ECHO P_Base: "%conf:~0,30%"

::SETa P_Host..............:localhost>>config.ini
SETLOCAL
SET linha=12& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET P_Host=%conf:~0,30%
ECHO P_Host: "%conf:~0,30%"

::SETa P_Porta.............:5432>>config.ini
SETLOCAL
SET linha=13& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET P_Porta=%conf:~0,30%
ECHO P_Porta: "%conf:~0,30%"

::SETa P_Usuario...........:postgres>>config.ini
SETLOCAL
SET linha=14& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET P_Usuario=%conf:~0,30%
ECHO P_Usuario: "%conf:~0,30%"

::SETa P_Senha.............:w0k000gpds>>config.ini
SETLOCAL
SET linha=15& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET P_Senha=%conf:~0,30%
ECHO P_Senha: "%conf:~0,30%"

::Descriptografia de senhas Postgres
SET var=%P_Senha%
SET decr=%var:~6,1%%var:~2,1%%var:~8,1%%var:~0,1%%var:~7,1%%var:~9,1%%var:~4,1%%var:~3,1%%var:~1,1%%var:~5,1%
SET l0=%decr:~0,1%& SET l1=%decr:~1,1%& SET l2=%decr:~2,1%& SET l3=%decr:~3,1%& SET l4=%decr:~4,1%& SET l5=%decr:~5,1%& SET l6=%decr:~6,1%& SET l7=%decr:~7,1%& SET l8=%decr:~8,1%& SET l9=%decr:~9,1%
IF "%l0%" NEQ "0" (SET decrptFinal=%decr:~0,1%)
IF "%l1%" NEQ "0" (SET decrptFinal=%decr:~0,2%)
IF "%l2%" NEQ "0" (SET decrptFinal=%decr:~0,3%)
IF "%l3%" NEQ "0" (SET decrptFinal=%decr:~0,4%)
IF "%l4%" NEQ "0" (SET decrptFinal=%decr:~0,5%)
IF "%l5%" NEQ "0" (SET decrptFinal=%decr:~0,6%)
IF "%l6%" NEQ "0" (SET decrptFinal=%decr:~0,7%)
IF "%l7%" NEQ "0" (SET decrptFinal=%decr:~0,8%)
IF "%l8%" NEQ "0" (SET decrptFinal=%decr:~0,9%)
IF "%l9%" NEQ "0" (SET decrptFinal=%decr:~0,10%)
SET PostgresDecrpt=%decrptFinal%
::ECHO PostgresDecrpt:"%PostgresDecrpt%"

::SETa P_SeparaEloarquivo..:N>>config.ini
SETLOCAL
SET linha=16& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET P_SeparaEloarquivo=%conf:~0,30%
ECHO P_SeparaEloarquivo: "%conf:~0,30%"
ECHO.

::SETa  ::Oracle>>config.ini
SETLOCAL
SET linha=17& SET conf=0

::SETa O_Usuario...........:dbteste>>config.ini
SETLOCAL
SET linha=18& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET O_Usuario=%conf:~0,30%
ECHO O_Usuario: "%conf:~0,30%"

::SETa O_Senha.............:e0m0e0pstt>>config.ini
SETLOCAL
SET linha=19& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET O_Senha=%conf:~0,30%
ECHO O_Senha: "%conf:~0,30%"

::Descriptografia de senhas Oracle
SET var=%O_Senha%
SET decr=%var:~6,1%%var:~2,1%%var:~8,1%%var:~0,1%%var:~7,1%%var:~9,1%%var:~4,1%%var:~3,1%%var:~1,1%%var:~5,1%
SET l0=%decr:~0,1%& SET l1=%decr:~1,1%& SET l2=%decr:~2,1%& SET l3=%decr:~3,1%& SET l4=%decr:~4,1%& SET l5=%decr:~5,1%& SET l6=%decr:~6,1%& SET l7=%decr:~7,1%& SET l8=%decr:~8,1%& SET l9=%decr:~9,1%
IF "%l0%" NEQ "0" (SET decrptFinal=%decr:~0,1%)
IF "%l1%" NEQ "0" (SET decrptFinal=%decr:~0,2%)
IF "%l2%" NEQ "0" (SET decrptFinal=%decr:~0,3%)
IF "%l3%" NEQ "0" (SET decrptFinal=%decr:~0,4%)
IF "%l4%" NEQ "0" (SET decrptFinal=%decr:~0,5%)
IF "%l5%" NEQ "0" (SET decrptFinal=%decr:~0,6%)
IF "%l6%" NEQ "0" (SET decrptFinal=%decr:~0,7%)
IF "%l7%" NEQ "0" (SET decrptFinal=%decr:~0,8%)
IF "%l8%" NEQ "0" (SET decrptFinal=%decr:~0,9%)
IF "%l9%" NEQ "0" (SET decrptFinal=%decr:~0,10%)
SET OracleDecrpt=%decrptFinal%
::ECHO OracleDecrpt: "%OracleDecrpt%"

::SETa O_Database..........:ORCL>>config.ini
SETLOCAL
SET linha=20& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET O_Database=%conf:~0,4%
ECHO O_Database: "%conf:~0,4%"

::SETa O_Versao-10g-11g....:11g>>config.ini
SETLOCAL
SET linha=21& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET O_Versao-10g-11g=%conf:~0,3%
ECHO O_Versao-10g-11g: "%conf:~0,3%"

::SETa O_SeparaEloarquivo..:N>>config.ini
SETLOCAL
SET linha=22& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET O_SeparaEloarquivo=%conf:~0,1%
ECHO O_SeparaEloarquivo: "%conf:~0,1%"
ECHO.

::SETa  ::SQLServer>>config.ini
SETLOCAL
SET linha=23& SET conf=0

::SETa S_User..............:sa>>config.ini
SETLOCAL
SET linha=24& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET S_User=%conf:~0,30%
ECHO S_User: "%conf:~0,30%"

::SETa S_Password..........:t0l0b0eroi>>config.ini
SETLOCAL
SET linha=25& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET S_Password=%conf:~0,30%
ECHO S_Password: "%conf:~0,30%"

::Descriptografia de senhas SQLServer
SET var=%S_Password%
SET decr=%var:~6,1%%var:~2,1%%var:~8,1%%var:~0,1%%var:~7,1%%var:~9,1%%var:~4,1%%var:~3,1%%var:~1,1%%var:~5,1%
SET l0=%decr:~0,1%& SET l1=%decr:~1,1%& SET l2=%decr:~2,1%& SET l3=%decr:~3,1%& SET l4=%decr:~4,1%& SET l5=%decr:~5,1%& SET l6=%decr:~6,1%& SET l7=%decr:~7,1%& SET l8=%decr:~8,1%& SET l9=%decr:~9,1%
IF "%l0%" NEQ "0" (SET decrptFinal=%decr:~0,1%)
IF "%l1%" NEQ "0" (SET decrptFinal=%decr:~0,2%)
IF "%l2%" NEQ "0" (SET decrptFinal=%decr:~0,3%)
IF "%l3%" NEQ "0" (SET decrptFinal=%decr:~0,4%)
IF "%l4%" NEQ "0" (SET decrptFinal=%decr:~0,5%)
IF "%l5%" NEQ "0" (SET decrptFinal=%decr:~0,6%)
IF "%l6%" NEQ "0" (SET decrptFinal=%decr:~0,7%)
IF "%l7%" NEQ "0" (SET decrptFinal=%decr:~0,8%)
IF "%l8%" NEQ "0" (SET decrptFinal=%decr:~0,9%)
IF "%l9%" NEQ "0" (SET decrptFinal=%decr:~0,10%)
SET SQLServerDecrpt=%decrptFinal%
::ECHO SQLServerDecrpt: "%SQLServerDecrpt%"
ECHO.

::SETa  ::Saude>>config.ini
SETLOCAL
SET linha=26& SET conf=0

::SETa SA_Base.............:dbteste>>config.ini
SETLOCAL
SET linha=27& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET SA_Base=%conf:~0,30%
ECHO SA_Base: "%conf:~0,30%"

::SETa SA_Host.............:localhost>>config.ini
SETLOCAL
SET linha=28& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET SA_Host=%conf:~0,30%
ECHO SA_Host: "%conf:~0,30%"

::SETa SA_Porta............:5432>>config.ini
SETLOCAL
SET linha=29& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET SA_Porta=%conf:~0,30%
ECHO SA_Porta: "%conf:~0,30%"

::SETa SA_Usuario..........:postgres>>config.ini
SETLOCAL
SET linha=30& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET SA_Usuario=%conf:~0,30%
ECHO SA_Usuario: "%conf:~0,30%"

::SETa SA_Senha............:w0k000gpds>>config.ini
SETLOCAL
SET linha=31& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET SA_Senha=%conf:~0,30%
ECHO SA_Senha: "%conf:~0,30%"

::Descriptografia de senhas Saude
SET var=%SA_Senha%
SET decr=%var:~6,1%%var:~2,1%%var:~8,1%%var:~0,1%%var:~7,1%%var:~9,1%%var:~4,1%%var:~3,1%%var:~1,1%%var:~5,1%
SET l0=%decr:~0,1%& SET l1=%decr:~1,1%& SET l2=%decr:~2,1%& SET l3=%decr:~3,1%& SET l4=%decr:~4,1%& SET l5=%decr:~5,1%& SET l6=%decr:~6,1%& SET l7=%decr:~7,1%& SET l8=%decr:~8,1%& SET l9=%decr:~9,1%
IF "%l0%" NEQ "0" (SET decrptFinal=%decr:~0,1%)
IF "%l1%" NEQ "0" (SET decrptFinal=%decr:~0,2%)
IF "%l2%" NEQ "0" (SET decrptFinal=%decr:~0,3%)
IF "%l3%" NEQ "0" (SET decrptFinal=%decr:~0,4%)
IF "%l4%" NEQ "0" (SET decrptFinal=%decr:~0,5%)
IF "%l5%" NEQ "0" (SET decrptFinal=%decr:~0,6%)
IF "%l6%" NEQ "0" (SET decrptFinal=%decr:~0,7%)
IF "%l7%" NEQ "0" (SET decrptFinal=%decr:~0,8%)
IF "%l8%" NEQ "0" (SET decrptFinal=%decr:~0,9%)
IF "%l9%" NEQ "0" (SET decrptFinal=%decr:~0,10%)
SET SaudeDecrpt=%decrptFinal%
::ECHO SaudeDecrpt: "%SaudeDecrpt%"

	::::SETa ConfigAgendamentoRotina
	::SETLOCAL
	::SET linha=32& SET conf=0
	::
	::::SETa NomeRotina..........:Rotina_BackuppPublitech_Automatico.exe>>config.ini
	::SETLOCAL
	::SET linha=33& SET conf=0
	::FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
	::SET NomeRotina=%conf:~0,38%
	::ECHO NomeRotina: "%conf:~0,38%"
	::
	::::SETa HorarioBackup.......:18:00>>config.ini
	::SETLOCAL
	::SET linha=34& SET conf=0
	::FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
	::SET HoraBackup=%conf:~0,2%
	::::ECHO HoraBackup: "%conf:~0,2%"
	::
	::SETLOCAL
	::SET linha=34& SET conf=0
	::FOR /f "delims=: tokens=1,4" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
	::SET MinutosBackup=%conf:~0,2%
	::::ECHO MinutosBackup: "%conf:~0,2%"
	::
	::SET HorarioBackup=%HoraBackup%:%MinutosBackup%
	::::ECHO HorarioBackup: "%HoraBackup%:%MinutosBackup%"
	::
	::::ECHO AgendarTarefaAuto...:S>>config.ini
	::SETLOCAL
	::SET linha=35& SET conf=0
	::FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
	::SET AgendarTarefaAuto=%conf:~0,1%
	::ECHO AgendarTarefaAuto: "%conf:~0,1%"

PING -n 6 127.0.0.1 >NUL & CLS
::MODE 110,25
CLS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                        
::   0000                                                                      
::   0000000                                                                   
::   000000000                                                                 
::   0000000                                                                   
::   0000                                                                      
::   00                                                                        
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

GOTO Validacao
:Validado

CD "%Caminho%"

IF EXIST "O1_BKP_Oracle(diario)" (ren "O1_BKP_Oracle(diario)" "Oracle(diario)")
IF EXIST "O2_BKP_Oracle(mensal)" (ren "O2_BKP_Oracle(mensal)" "Oracle(mensal)")
IF EXIST "P1_BKP_Postgres(diario)" (ren "P1_BKP_Postgres(diario)" "Postgres(diario)")
IF EXIST "P2_BKP_Postgres(mensal)" (ren "P2_BKP_Postgres(mensal)" "Postgres(mensal)")
IF EXIST "P0_BKP_Postgres(sexta)" (ren "P0_BKP_Postgres(sexta)" "Postgres(sexta)")
IF EXIST "SAUDE1_BKP_Postgres(diario)" (ren "SAUDE1_BKP_Postgres(diario)" "Saude(diario)")
IF EXIST "SAUDE2_BKP_Postgres(mensal)" (ren "SAUDE2_BKP_Postgres(mensal)" "Saude(mensal)")
IF EXIST "S1_BKP_SQLServer(diario)" (ren "S1_BKP_SQLServer(diario)" "SQLServer(diario)")
IF EXIST "S2_BKP_SQLServer(mensal)" (ren "S2_BKP_SQLServer(mensal)" "SQLServer(mensal)")
IF EXIST "z_BKP(Execucao_Manual)" (ren "z_BKP(Execucao_Manual)" "zBackupManual")

%cdLocal:~0,2% & CD\"%cdLocal:~3,100%"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                        
::   0000                                                                      
::   0000000                                                                   
::   000000000                                                                 
::   0000000                                                                   
::   0000                                                                      
::   00                                                                        
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


CLS
@Echo.
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #        Escolha o banco a ser feito o Backup                                               #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #        1 - PostgreSQL                                                                     #
@Echo. #        2 - Oracle                                                                         #
@Echo. #        3 - SQLServer                                                                      #
@Echo. #        4 - PostgreSQL_SAUDE                                                               #
@Echo. #        0 - SAIR                                                                           #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 12340 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 GOTO MENUPostgreSQL
if %ERRORLEVEL%==2 GOTO MENUOracle
if %ERRORLEVEL%==3 GOTO MENUSQLServer
if %ERRORLEVEL%==4 GOTO MENUPostgreSQL_SAUDE
if %ERRORLEVEL%==5 EXIT
CLS

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                                           ::
:::                                                                           ::
:::                                                                           ::
:::  :::::::  :::::::   ::::::  ::::::::  :::::::  ::::::::  :::::::  ::::::  ::
:::  ::  ::: :::   ::: :::   :    :::    :::   ::  :::  :::  :::     :::   :  ::
:::  ::  ::: :::   :::  :::::      ::    ::        ::::::::  :::::::  :::::   ::
:::  :::::   :::   :::     ::::   :::    ::   :::: ::: :::   ::          :::: ::
:::  ::       :::  ::: :::  :::   :::    :::   ::: :::  :::  :::     :::  ::: ::
:::  ::        ::::::   ::::::    :::     :::::::  :::  :::  :::::::  ::::::  ::
:::                                                                           ::
:::                                                                           ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:MENUPostgreSQL
CLS
@Echo.
@Echo. #############################################################################################
@Echo. #        PostgreSQL                                                                         #
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #        Escolha a SCHEMA a ser feito o Backup                                              #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #        1 - BKP Full                                                                       #
@Echo. #        2 - BKP Aise                                                                       #
@Echo. #        3 - BKP Apice                                                                      #
@Echo. #        4 - BKP Siscop                                                                     #
@Echo. #        5 - BKP SigeloAM                                                                   #
@Echo. #        6 - BKP Protocolo                                                                  #
@Echo. #        7 - BKP Eloarquivo                                                                 #
@Echo. #        8 - BKP Unico                                                                      #
@Echo. #        9 - BKP semEloarquivo                                                              #
@Echo. #        0 - SAIR                                                                           #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 1234567890 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 SET opcao=1& SET tipoBKP=Full& SET schema=-U postgres
if %ERRORLEVEL%==2 SET opcao=2& SET tipoBKP=Aise& SET schema=-n aise
if %ERRORLEVEL%==3 SET opcao=3& SET tipoBKP=Apice& SET schema=-n apice
if %ERRORLEVEL%==4 SET opcao=4& SET tipoBKP=Siscop& SET schema=-n siscop
if %ERRORLEVEL%==5 SET opcao=5& SET tipoBKP=SigeloAM& SET schema=-n sigeloam
if %ERRORLEVEL%==6 SET opcao=6& SET tipoBKP=Protocolo& SET schema=-n protocolo
if %ERRORLEVEL%==7 SET opcao=7& SET tipoBKP=Eloarquivo& SET schema=-n eloarquivo
if %ERRORLEVEL%==8 SET opcao=8& SET tipoBKP=Unico& SET schema=-n unico
if %ERRORLEVEL%==9 SET opcao=9& SET tipoBKP=semEloarquivo& SET schema=-N eloarquivo
if %ERRORLEVEL%==10 EXIT
CLS

::Teste postgres
::ECHO %opcao% %tipoBKP% %schema%
::pause

:BKP_Postgres

ECHO Executando BKP_Postgres...& PING -n 3 127.0.0.1 >NUL

::Verifica versão do postgres
SET versaoPostgres=0
IF EXIST "C:\Program Files (x86)\PostgreSQL\pg96\bin" (SET versaoPostgres="Program Files (x86)\PostgreSQL\pg96\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.0\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.0\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.1\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.1\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.2\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.2\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.3\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.3\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.4\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.4\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.5\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.5\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.6\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.6\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.7\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.7\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.8\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.8\bin")
IF EXIST "C:\Program Files\PostgreSQL\pg96\bin"       (SET versaoPostgres="Program Files\PostgreSQL\pg96\bin"     )
IF EXIST "C:\Program Files\PostgreSQL\9.0\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.0\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.1\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.1\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.2\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.2\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.3\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.3\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.4\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.4\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.5\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.5\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.6\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.6\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.7\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.7\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.8\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.8\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\pg96\bin"       (SET versaoPostgres="Program Files\PostgreSQL\pg96\bin"     )
IF EXIST "C:\PostgreSQL\pg96\bin"                     (SET versaoPostgres="PostgreSQL\pg96\bin"                   )
IF %versaoPostgres%==0 (ECHO PostgreSQL NAO ENCONTRADO!!!& PING -n 6 127.0.0.1 >NUL)
C: & CD\%versaoPostgres%
SET pguser=%P_Usuario%
SET pgpassword=%PostgresDecrpt%

CLS
SET SGBD=Postgres
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%P_Base%-%tipoBKP%_%DataHora%.backup
::Roda Backup
C: & CD\%versaoPostgres%
::pg_dump.exe -h %P_Host% -p %P_Porta% %schema% -F c -v -f "%Caminho%\zBackupManual\%NomeArquivo%" %P_Base%
pg_dump -Fc -b -v -h %P_Host% -p %P_Porta% %schema% -d %P_Base% -f "%Caminho%\zBackupManual\%NomeArquivo%"
PING -n 3 127.0.0.1 >NUL & CLS
%Unidade%: & CD %Pasta%
::Compacta no DIRet?rio especIFico e deleta antigo
FOR %%f in ("%Caminho%\zBackupManual\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::VerIFica backup
SET tamanho=0
IF Exist "%Caminho%\zBackupManual\%NomeArquivo%.zip" (FOR %%a in (DIR "%Caminho%\zBackupManual\%NomeArquivo%.zip") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%: Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\logBKPmanual.log" & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL)

CLS
@Echo.
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #     Concluido Backup, disponivel na pasta "zBackupManual"                        #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #     0 - SAIR e abrir pasta                                                                #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 0 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 explorer "%Caminho%\zBackupManual"& EXIT


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                                           ::
:::                                                                           ::
:::           ::::     ::::::      :::       :::    :::      :::::::          ::
:::          :::::::  :::::::::   :::::    :::::::  :::     ::::::::          ::
:::         :::   :::  ::   :::   :::::   :::   ::  :::      :::              ::
:::         ::    :::  :::::::   ::: ::   :::       :::      :::::::          ::
:::         ::    :::  ::::::    ::  :::  :::       :::      :::              ::
:::         :::   :::  ::  :::  ::::::::  :::   ::: :::      ::               ::
:::          :::::::   ::   ::: :::   :::  :::::::  :::::::  :::::::          ::
:::            :::     ::    :: ::     ::    :::     ::::::  :::::::          ::
:::                                                                           ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MENUOracle
CLS
@Echo.
@Echo. #############################################################################################
@Echo. #        Oracle                                                                             #
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #        Escolha a SCHEMA a ser feito o Backup                                              #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #        1 - BKP Full                                                                       #
@Echo. #        2 - BKP Aise                                                                       #
@Echo. #        3 - BKP Apice                                                                      #
@Echo. #        4 - BKP Siscop                                                                     #
@Echo. #        5 - BKP SigeloAM                                                                   #
@Echo. #        6 - BKP Protocolo                                                                  #
@Echo. #        7 - BKP Eloarquivo                                                                 #
@Echo. #        8 - BKP Unico                                                                      #
@Echo. #        9 - BKP Image                                                                      #
@Echo. #        0 - SAIR                                                                           #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 1234567890 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 SET opcao=1& SET tipoBKP=Full& SET SCHEMAS=FULL& SET owner=full=y
if %ERRORLEVEL%==2 SET opcao=2& SET tipoBKP=Aise& SET SCHEMAS=aise& SET owner=owner=aise
if %ERRORLEVEL%==3 SET opcao=3& SET tipoBKP=Apice& SET SCHEMAS=apice& SET owner=owner=apice
if %ERRORLEVEL%==4 SET opcao=4& SET tipoBKP=Siscop& SET SCHEMAS=siscop& SET owner=owner=siscop
if %ERRORLEVEL%==5 SET opcao=5& SET tipoBKP=SigeloAM& SET SCHEMAS=sigeloam& SET owner=owner=sigeloam
if %ERRORLEVEL%==6 SET opcao=6& SET tipoBKP=Protocolo& SET SCHEMAS=protocolo& SET owner=owner=protocolo
if %ERRORLEVEL%==7 SET opcao=7& SET tipoBKP=Eloarquivo& SET SCHEMAS=eloarquivo& SET owner=owner=eloarquivo
if %ERRORLEVEL%==8 SET opcao=8& SET tipoBKP=Unico& SET SCHEMAS=unico& SET owner=owner=unico
if %ERRORLEVEL%==9 SET opcao=9& SET tipoBKP=image& SET SCHEMAS=image& SET owner=owner=image
::if %ERRORLEVEL%==9 SET opcao=9& SET tipoBKP=semEloarquivo& SET SCHEMAS=-N eloarquivo
if %ERRORLEVEL%==10 EXIT
CLS

SET SGBD=Oracle
::SET NomeArquivo=BKP_%SGBD%-%Entidade%-%O_Usuario%-%tipoBKP%_%DataHora%.backup

IF %O_Versao-10g-11g% == 10g (GOTO BKP_Oracle10g)

BKP_Oracle11g
CLS
::version
SET version=11.2
::SET version=10.2


SET prox=ConcluiBKPORACLE
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%tipoBKP%-%version%_%DataHora%.dmp
::SET NomeArquivo=BKP_%SGBD%-%Entidade%-%tipoBKP%_%DataHora%.dmp
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%SCHEMAS% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%tipoBKP%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
GOTO ConcluiBKPORACLE

:BKP_Oracle10g
CLS
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%tipoBKP%_%DataHora%.dmp
::exp %O_Usuario%/%OracleDecrpt%@%O_Database% file="%Caminho%\zBackupManual\%NomeArquivo%" full=y rows=y statistics=none consistent=y
exp %O_Usuario%/%OracleDecrpt%@%O_Database% file="%Caminho%\zBackupManual\%NomeArquivo%" %owner% rows=y statistics=none consistent=y
PING -n 3 127.0.0.1 >NUL & CLS

IF NOT EXIST "%Caminho%\zBackupManual\%NomeArquivo%" (
    ECHO %DataHora%: Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\logBKPmanual.log"
    ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 3 127.0.0.1 >NUL
    CLS & GOTO %prox%)
::Compacta no DIRet?rio especIFico e deleta antigo
FOR %%f in ("%Caminho%\zBackupManual\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"

IF EXIST "%Caminho%\zBackupManual\%NomeArquivo%.zip" (MOVE /Y "%Caminho%\zBackupManual\%NomeArquivo%.zip" "%Caminho%\zBackupManual\%NomeArquivo%.zip")
CLS
::VerIFica backup
SET tamanho=0
IF Exist "%Caminho%\zBackupManual\%NomeArquivo%.zip" (FOR %%a in (DIR "%Caminho%\zBackupManual\%NomeArquivo%.zip") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%: Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\logBKPmanual.log" & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL)
GOTO fimbkporacle

:ConcluiBKPORACLE
IF NOT EXIST "%Caminho%\Oracle(diario)\%NomeArquivo%" (
    ECHO %DataHora%: Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\logBKPmanual.log"
    ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 3 127.0.0.1 >NUL
    CLS & GOTO %prox%)
::Compacta no DIRet?rio especIFico e deleta antigo
FOR %%f in ("%Caminho%\Oracle(diario)\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"

IF EXIST "%Caminho%\Oracle(diario)\%NomeArquivo%.zip" (MOVE /Y "%Caminho%\Oracle(diario)\%NomeArquivo%.zip" "%Caminho%\zBackupManual\%NomeArquivo%.zip")
CLS
::VerIFica backup
SET tamanho=0
IF Exist "%Caminho%\zBackupManual\%NomeArquivo%.zip" (FOR %%a in (DIR "%Caminho%\zBackupManual\%NomeArquivo%.zip") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%: Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\logBKPmanual.log" & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL)

:fimbkporacle
CLS
@Echo.
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #     Concluido Backup, disponivel na pasta "zBackupManual"                        #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #     0 - SAIR e abrir pasta                                                                #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 0 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 explorer "%Caminho%\zBackupManual"& EXIT

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                                           ::
:::                                                                           ::
:::             :::   ::::::::  :::::   ::     :: :::::::   :::::             ::
:::           ::::::: :::::::: :::::::: :::   ::: :::::::: ::::::::           ::
:::           :::     :::      :::  :::  :::  ::  :::      :::  :::           ::
:::            :::::  :::::::: :::::::    :: :::  :::::::  :::::::            ::
:::               ::: :::      ::: :::    :::::   :::      ::: :::            ::
:::           ::: ::: :::::::: :::  :::    ::::   :::::::  :::  :::           ::
:::            :::::  ::::::::  ::   :::    ::    :::::::: :::   ::           ::
:::                                                                           ::
:::                                                                           ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MENUSQLServer
CLS

ECHO Iniciando backup SQLServer... & PING -n 3 127.0.0.1 >NUL & CLS

SET SGBD=SQLServer-SMT
SET tipoBKP=Full
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%tipoBKP%_%DataHora%.bak
IF EXIST "%Caminho%\zBackupManual\BKP_SQLServer(Execucao_Manual).Sql" (DEL /F /Q "%Caminho%\zBackupManual\BKP_SQLServer(Execucao_Manual).Sql")

@ECHO declare @caminho varchar(max) SET @caminho = '%Caminho%\zBackupManual\%NomeArquivo%'>%Caminho%\zBackupManual\BKP_SQLServer(Execucao_Manual).Sql
@ECHO backup database smt to disk = @caminho>>%Caminho%\zBackupManual\BKP_SQLServer(Execucao_Manual).Sql
::SET NomeArquivo=BKP_SQLServer-SMT_%Entidade%_%DataHora%.bak
osql -U %S_User% -P %SQLServerDecrpt% -i %Caminho%\zBackupManual\BKP_SQLServer(Execucao_Manual).Sql
PING -n 3 127.0.0.1 >NUL & CLS
::Compacta no DIRet?rio especIFico e deleta antigo
FOR %%f in ("%Caminho%\zBackupManual\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::VerIFica backup
SET tamanho=0
IF Exist "%Caminho%\zBackupManual\%NomeArquivo%.zip" (FOR %%a in (DIR "%Caminho%\zBackupManual\%NomeArquivo%.zip") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%: Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\logBKPmanual.log" & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL)

CLS
@Echo.
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #     Concluido Backup, disponivel na pasta "zBackupManual"                        #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #     0 - SAIR e abrir pasta                                                                #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 0 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 explorer "%Caminho%\zBackupManual"& EXIT

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::                                                                          :::
:::                                                                          :::
:::             :::::      :::     :::   :::  ::::::    ::::::::             :::
:::            ::::::::   :::::    :::   :::  ::::::::  ::::::::             :::
:::            :::        :::::    :::   :::  :::  :::  :::                  :::
:::            ::::::     :: :::   :::   :::  :::   ::  ::::::::             :::
:::               :::::  :::  ::   :::   :::  :::   ::  :::                  :::
:::            ::   :::  ::::::::  :::   :::  :::  :::  :::                  :::
:::            :::::::: :::   :::   :::::::   ::::::::  ::::::::             :::
:::              ::::   ::     ::     :::     :::::     ::::::::             :::
:::                                                                          :::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:MENUPostgreSQL_SAUDE
CLS

ECHO Iniciando BKP_Postgres_SAUDE...& PING -n 3 127.0.0.1 >NUL

SET SGBD=Postgres
SET ftime=%time:~0,2%
SET ftime=0%ftime: =%
SET ftime=%ftime:~-2%
SET DataHora=%date:~6,4%-%date:~3,2%-%date:~0,2%_%ftime%h%time:~3,2%min
SET NomeArquivo=BKP_%SGBD%_SAUDE-%Entidade%-%SA_Base%_%DataHora%.backup
SET tipoBKP=Saude

::Verifica versão do postgres
SET versaoPostgres=0
IF EXIST "C:\Program Files (x86)\PostgreSQL\pg96\bin" (SET versaoPostgres="Program Files (x86)\PostgreSQL\pg96\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.0\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.0\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.1\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.1\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.2\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.2\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.3\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.3\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.4\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.4\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.5\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.5\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.6\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.6\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.7\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.7\bin")
IF EXIST "C:\Program Files (x86)\PostgreSQL\9.8\bin"  (SET versaoPostgres="Program Files (x86)\PostgreSQL\9.8\bin")
IF EXIST "C:\Program Files\PostgreSQL\pg96\bin"       (SET versaoPostgres="Program Files\PostgreSQL\pg96\bin"     )
IF EXIST "C:\Program Files\PostgreSQL\9.0\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.0\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.1\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.1\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.2\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.2\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.3\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.3\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.4\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.4\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.5\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.5\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.6\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.6\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.7\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.7\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\9.8\bin"        (SET versaoPostgres="Program Files\PostgreSQL\9.8\bin"      )
IF EXIST "C:\Program Files\PostgreSQL\pg96\bin"       (SET versaoPostgres="Program Files\PostgreSQL\pg96\bin"     )
IF EXIST "C:\PostgreSQL\pg96\bin"                     (SET versaoPostgres="PostgreSQL\pg96\bin"                   )
IF %versaoPostgres%==0 (ECHO PostgreSQL NAO ENCONTRADO!!!& PING -n 6 127.0.0.1 >NUL)
C: & CD\%versaoPostgres%
SET pguser=%P_Usuario%
SET pgpassword=%PostgresDecrpt%

CLS
::Roda Backup
C: & CD\%versaoPostgres%
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%SA_Base%-%tipoBKP%_%DataHora%.backup
SET pastaDiaria=Postgres(diario)
SET pastaMensal=Postgres(mensal)
::pg_dump.exe -h %SA_Host% -p %SA_Porta% -U postgres -F c -v -f "%Caminho%\zBackupManual\%NomeArquivo%" %SA_Base%
pg_dump -Fc -b -v -h %SA_Host% -p %SA_Porta% -U postgres -d %P_Base% -f "%Caminho%\zBackupManual\%NomeArquivo%"
PING -n 3 127.0.0.1 >NUL & CLS
%Unidade%: & CD %Pasta%
::Compacta no DIRet?rio especIFico e deleta antigo
FOR %%f in ("%Caminho%\zBackupManual\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::VerIFica backup
SET tamanho=0
IF Exist "%Caminho%\zBackupManual\%NomeArquivo%.zip" (FOR %%a in (DIR "%Caminho%\zBackupManual\%NomeArquivo%.zip") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%: Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\logBKPmanual.log" & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL)

CLS
@Echo.
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #     Concluido Backup, disponivel na pasta "zBackupManual"                        #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #     0 - SAIR e abrir pasta                                                                #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 0 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 explorer "%Caminho%\zBackupManual"& EXIT
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                           ::
::                               ##############                              ::
::                           #######################                         ::
::                       ###############################                     ::
::                     ###################################                   ::
::          ##        #####################################        ##        ::
::        ########    #####################################    ########      ::
::      ############  ################################ ####  ############    ::
::      ############# ##################################### #############    ::
::       ############ ## ############################### ## ############     ::
::                   # ###           #######          #### #                 ::
::                      ##            #####            ##                    ::
::                    ####          ### # ###         #####                  ::
::                     ##############   #   ##############                   ::
::                       ############   #   ############                     ::
::                         ### ################### ###                       ::
::                 ###########  ## ###########  #  ### ######                ::
::       #################   ### ##### # # ##### ###  ##################     ::
::       ###############      ##### # ##### # #####      ###############     ::
::         #########            #################            #########       ::
::         #######                 ###########                 #######       ::
::                                                                           ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Validacao

SET Unidade=%Caminho:~0,1%

SET VAR_Unidade=0
IF %Unidade% == C (SET VAR_Unidade=1)
IF %Unidade% == D (SET VAR_Unidade=1)
IF %Unidade% == E (SET VAR_Unidade=1)
IF %Unidade% == F (SET VAR_Unidade=1)
IF %Unidade% == G (SET VAR_Unidade=1)
IF %Unidade% == H (SET VAR_Unidade=1)
IF %Unidade% == I (SET VAR_Unidade=1)
IF %Unidade% == J (SET VAR_Unidade=1)
IF %Unidade% == K (SET VAR_Unidade=1)
IF %Unidade% == L (SET VAR_Unidade=1)
IF %Unidade% == M (SET VAR_Unidade=1)
IF %Unidade% == N (SET VAR_Unidade=1)
IF %Unidade% == O (SET VAR_Unidade=1)
IF %Unidade% == P (SET VAR_Unidade=1)
IF %Unidade% == Q (SET VAR_Unidade=1)
IF %Unidade% == R (SET VAR_Unidade=1)
IF %Unidade% == S (SET VAR_Unidade=1)
IF %Unidade% == T (SET VAR_Unidade=1)
IF %Unidade% == U (SET VAR_Unidade=1)
IF %Unidade% == V (SET VAR_Unidade=1)
IF %Unidade% == W (SET VAR_Unidade=1)
IF %Unidade% == X (SET VAR_Unidade=1)
IF %Unidade% == Y (SET VAR_Unidade=1)
IF %Unidade% == Z (SET VAR_Unidade=1)
IF %VAR_Unidade% == 0 (ECHO Erro na Variavel inFORmada "Unidade=%Unidade%", ex: C, D, E... & pause >NUL & Exit)

SET VAR_O_Versao-10g-11g=0
IF %O_Versao-10g-11g% == 10g (SET VAR_O_Versao-10g-11g=1)
IF %O_Versao-10g-11g% == 11g (SET VAR_O_Versao-10g-11g=1)
IF %VAR_O_Versao-10g-11g% == 0 (ECHO Erro na Variavel inFORmada "BKP_Oracle=%O_Versao-10g-11g%", ex: 10g ou 11g & pause >NUL & Exit)

::  ECHO %Publitech@Cloud%    ; - %VAR_Publitech@Cloud%    
::  ECHO %BKP_Postgres  %     ; - %VAR_BKP_Postgres  %     
::  ECHO %BKP_Oracle    %     ; - %VAR_BKP_Oracle    %     
::  ECHO %BKP_SQLServer %     ; - %VAR_BKP_SQLServer %     
::  ECHO %BKP_Saude     %     ; - %VAR_BKP_Saude     %     
::  ECHO %P_SeparaEloarquivo% ; - %VAR_P_SeparaEloarquivo% 
::  ECHO %O_Database%         ; - %VAR_O_Database%         
::  ECHO %O_Versao-10g-11g%   ; - %VAR_O_Versao-10g-11g%   
::  ECHO %O_SeparaEloarquivo% ; - %VAR_O_SeparaEloarquivo% 
CLS
GOTO Validado

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                           ::
::                               ##############                              ::
::                           #######################                         ::
::                       ###############################                     ::
::                     ###################################                   ::
::          ##        #####################################        ##        ::
::        ########    #####################################    ########      ::
::      ############  ################################ ####  ############    ::
::      ############# ##################################### #############    ::
::       ############ ## ############################### ## ############     ::
::                   # ###           #######          #### #                 ::
::                      ##            #####            ##                    ::
::                    ####          ### # ###         #####                  ::
::                     ##############   #   ##############                   ::
::                       ############   #   ############                     ::
::                         ### ################### ###                       ::
::                 ###########  ## ###########  #  ### ######                ::
::       #################   ### ##### # # ##### ###  ##################     ::
::       ###############      ##### # ##### # #####      ###############     ::
::         #########            #################            #########       ::
::         #######                 ###########                 #######       ::
::                                                                           ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::