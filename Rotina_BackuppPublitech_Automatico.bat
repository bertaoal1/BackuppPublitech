::Rotina_BackuppPublitech_Automatico
@ECHO off & MODE 110,28 & COLOR 17 & TITLE Rotina_BackuppPublitech_Automatico
::Seta variaveis para DataHora formatada
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
::Seta var crypt
SET var="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"


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


SET past=%~dp0
SET cdLocal=%past:~0,-1%
%cdLocal:~0,2% & CD\"%cdLocal:~3,100%"


CLS & ECHO %DataHora%: --------------------------------------->>"%cdLocal%\log.log"
CLS & ECHO %DataHora%: Iniciando Rotina de BackuppPublitech...>>"%cdLocal%\log.log"
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
::Verifica se existe compactador 7z
set zip=0
IF EXIST "C:\Program Files\7-Zip\7z.exe" SET path=%PATH%;C:\Program Files\7-Zip& ECHO %DataHora%: Compactador 7z OK!>>"%cdLocal%\log.log"& set zip=1 & GOTO 7zVerificdo 
IF EXIST "C:\Program Files (x86)\7-Zip\7z.exe" SET path=%PATH%;C:\Program Files (x86)\7-Zip& ECHO %DataHora%: Compactador 7z OK! (x86)>>"%cdLocal%\log.log"& set zip=1
:7zVerificdo
IF %zip%==0 (ECHO ERROR: Compactador 7Z nao encontrano, instale o 7z1602. & ECHO %DataHora%: ERROR: 7Z nao encontrano, instale o 7z1602!>>"%cdLocal%\log.log" & PING -n 6 127.0.0.1 >NUL & CLS)
::IF %zip%==1 (ECHO %DataHora%: Compactador 7z OK!>>"%cdLocal%\log.log")
::echo "%PATH:~-5%"
::IF "%PATH:~-5%" NEQ "7-Zip" (CLS & ECHO ERROR: 7Z nao encontrano nas Variaveis de Ambiente, instale o 7z1602 & PING -n 6 127.0.0.1 >NUL & EXIT)



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
::faz copia da rotina
::IF exist _BKPauto (FOR %%f in (Rotina_BackuppPublitech_Automatico.bat) do 7z a -tzip -mx=9 _BKPauto/BKPauto%DataHora%_"%%f""--%alteracaoversao%".zip "%%f")

::IF exist _BKPauto (SET /p alteracaoversao= Descreva a alteracao para o BKPauto:)
SET camExec=%0
SET nomeAutoBKP=%camExec:~-20,-1%
IF exist _BKPauto (7z a -tzip -mx=9 "_BKPauto/BKPauto%DataHora%_BKP...%nomeAutoBKP%.zip" %camExec%)
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
CLS & ECHO %DataHora%: Criando "config.ini"...>>"%cdLocal%\log.log"
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
ECHO P_SeparaEloarquivo..:S>>config.ini
ECHO  ::Oracle>>config.ini
ECHO O_Usuario...........:dbteste>>config.ini
ECHO O_Senha.............:e0m0e0pstt>>config.ini
ECHO O_Database..........:ORCL>>config.ini
ECHO O_Versao-10g-11g....:11g>>config.ini
ECHO O_SeparaEloarquivo..:S>>config.ini
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
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
CLS
ECHO Iniciando, aguarde... & PING -n 3 127.0.0.1 >NUL & CLS
::MODE 110,30

::SETa Entidade............:Publitech>config.ini
SETLOCAL
SET linha=1& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET Entidade=%conf:~0,30%
::ECHO Entidade: "%conf:~0,30%"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
IF %conf%==0 (CLS & ECHO %DataHora%: ERRO CRITICO AO SETAR VARIAVEIS! "conf=%conf%". Abortando execucao da rotina. & ECHO %DataHora%: ERRO CRITICO AO SETAR VARIAVEIS! "conf=%conf%". Abortando execucao da rotina.>>"%cdLocal%\log.log" & PING -n 3 127.0.0.1 >NUL & EXIT)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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

::SETa CloudDrive.............:S>>config.ini
SETLOCAL
SET linha=3& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET UnidadeCloud=%conf:~0,1%
::ECHO Unidade: "%conf:~0,1%"
SET CloudDrive=%UnidadeCloud%

SETLOCAL
SET linha=3& SET conf=0
FOR /f "delims=: tokens=1,4" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET pastaCloud=%conf:~0,100%
::ECHO Pasta: "%conf:~0,100%"

SET CaminhoCloud=%UnidadeCloud%:%pastaCloud%
ECHO CaminhoCloud: %UnidadeCloud%:%pastaCloud%

::SETLOCAL
::SET linha=3& SET conf=0
::FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
::SET CloudDrive=%conf:~0,1%
::ECHO CloudDrive: "%conf:~0,1%"


::SETa LimparMaisAntigosQue:20>>config.ini
SETLOCAL
SET linha=4& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET LimparMaisAntigosQue=%conf:~0,3%
ECHO LimparMaisAntigosQue: "%conf:~0,3%"

::SETa  ::TipoBackup>>config.ini
SET linha=5& SET conf=0

::SETa BKP_Postgres........:S>>config.ini
SETLOCAL
SET linha=6& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET BKP_Postgres=%conf:~0,1%
ECHO BKP_Postgres: "%conf:~0,1%"

::SETa BKP_Oracle..........:N>>config.ini
SETLOCAL
SET linha=7& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET BKP_Oracle=%conf:~0,1%
ECHO BKP_Oracle: "%conf:~0,1%"

::SETa BKP_SQLServer.......:N>>config.ini
SETLOCAL
SET linha=8& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET BKP_SQLServer=%conf:~0,1%
ECHO BKP_SQLServer: "%conf:~0,1%"

::SETa BKP_Saude...........:N>>config.ini
SETLOCAL
SET linha=9& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET BKP_Saude=%conf:~0,1%
ECHO BKP_Saude: "%conf:~0,1%"


::SETa  ::Postgres>>config.ini
SET linha=10& SET conf=0

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
::SET PostgresDecrpt=lockdbsystem
::ECHO PostgresDecrpt:"%PostgresDecrpt%"

::SETa P_SeparaEloarquivo..:N>>config.ini
SETLOCAL
SET linha=16& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET P_SeparaEloarquivo=%conf:~0,30%
ECHO P_SeparaEloarquivo: "%conf:~0,30%"

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
::SET OracleDecrpt=lockdbsystem
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
::SET SQLServerDecrpt=lockdbsystem
::ECHO SQLServerDecrpt: "%SQLServerDecrpt%"

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
::SET SaudeDecrpt=lockdbsystem


::ECHO CopiaNaRede.........:C:\bkp>>config.ini
::ECHO CopiaNaRede.........:\\192.168.1.1\bkp>>config.ini

SETLOCAL
SET linha=35& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET varCopia=%conf:~0,1%
ECHO CopiaNaRede: "%conf:~0,1%"


:FIMvar
PING -n 6 127.0.0.1 >NUL & CLS
::MODE 110,25
CLS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

GOTO Validacao
:Validado

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::CloudDrive..........:A:(N=nao, A=Amazon, D=DropBox, M=Mega)

IF %CloudDrive%==N (GOTO pulaCloudDrive)


::IF %CloudDrive%==A (SET AppCloud=Amazon Drive)
::IF %CloudDrive%==D (SET AppCloud=DropBox)
::IF %CloudDrive%==M (SET AppCloud=Mega)
::IF %CloudDrive%==S (SET AppCloud=DropBox)

echo "%CaminhoCloud%\CloudDrive"

::SET AppCloud=Amazon Drive

::Verifica se CloudDrive existe

IF NOT EXIST "%CaminhoCloud%\CloudDrive" (MD "%CaminhoCloud%\CloudDrive")



:pulaCloudDrive

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  ::::Verifica pasta \BackuppPublitech\zConfig
IF NOT EXIST "%Caminho%\zConfig" (MD "%Caminho%\zConfig")
  ::IF EXIST "%Caminho%\zConfig" (GO1TO zConfigOK)
  ::MD "%Caminho%\zConfig"
  ::CLS & ECHO %DataHora%: Criado pasta "zConfig.ini">>"%cdLocal%\log.log"
  ::@Echo.
  ::@Echo. #############################################################################################
  ::@Echo. #                                                                                           #
  ::@ECHO. #     Criado pasta \BackuppPublitech\zConfig                                                #
  ::@ECHO. #     Mova os arquivos "Config.ini" e o "Rotina_BackuppPublitech_Automatico para pasta"     #
  ::@Echo. #                                                                                           #
  ::@Echo. #                                                                                           #
  ::@Echo. #     1 - Continuar                                                                         #
  ::@Echo. #     0 - SAIR                                                                              #
  ::@Echo. #                                                                                           #
  ::@Echo. #                                                                                           #
  ::@Echo. #############################################################################################
  ::@Echo.
  ::choice /C 10 /M ". Escolha uma Opcao: "
  ::if %ERRORLEVEL%==1 GO1TO zConfigOK
  ::if %ERRORLEVEL%==2 EXIT
  :::zConfigOK
  ::CLS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Seta verificador delCloud, se CloudDrive j? foi excluido
SET delCloud=N
CLS


::Cria Link para download de Installers
IF EXIST "%Caminho%\zConfig\CloudDrive_Installers.url" (GOTO pulaAtalhoInstall)
DEL /F /Q "%Caminho%\zConfig\DropBox_Installers.url"
ECHO [InternetShortcut]>"%Caminho%\zConfig\CloudDrive_Installers.url"
ECHO URL=https://bit.ly/PubliInstall>>"%Caminho%\zConfig\CloudDrive_Installers.url"
:pulaAtalhoInstall
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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

::Inicio Backup postgres
:BKP_Postgres
IF %BKP_Postgres%==S (GOTO BKP_Postgres_S) ELSE (GOTO BKP_Oracle)
:BKP_Postgres_S
CLS & ECHO %DataHora%:    Inicio BKP postgres...>>"%cdLocal%\log.log"
::Verifica vers?o do postgres
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
::C:\PostgreSQL\data\pg96

::C:\PostgreSQL\pg96\bin
::C:\Program Files\PostgreSQL\pg96\bin


IF %versaoPostgres%==0 (ECHO PostgreSQL NAO ENCONTRADO!!!& PING -n 6 127.0.0.1 >NUL)
C: & CD\%versaoPostgres%
SET pguser=%P_Usuario%
SET pgpassword=%PostgresDecrpt%

  ::::Teste de vers?o do postgres
  ::::SET testeVersao=%versaoPostgres:~-8,3%
  ::IF [%versaoPostgres:~-8,3%]==[9.0] (ECHO %DataHora%:    ATENCAO: Versao do postgres muito antiga %testeVersao%, indicado atualiza??o!>>"%cdLocal%\log.log")
  ::IF [%versaoPostgres:~-8,3%]==[9.1] (ECHO %DataHora%:    ATENCAO: Versao do postgres muito antiga %testeVersao%, indicado atualiza??o!>>"%cdLocal%\log.log")
  ::IF [%versaoPostgres:~-8,3%]==[9.2] (ECHO %DataHora%:    ATENCAO: Versao do postgres muito antiga %testeVersao%, indicado atualiza??o!>>"%cdLocal%\log.log")
  ::IF [%versaoPostgres:~-8,3%]==[9.3] (ECHO %DataHora%:    ATENCAO: Versao do postgres muito antiga %testeVersao%, indicado atualiza??o!>>"%cdLocal%\log.log")
  ::pause
CLS
::Seta Variaveis
SET SGBD=Postgres
::Verifica P_SeparaEloarquivo


IF %P_SeparaEloarquivo%==N (GOTO P_BkpFULL) else (GOTO P_BkpSeparaEloarquivo)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Inicio Backup
:P_BkpFULL
ECHO Executando BKP_Postgres FULL DIARIO...& PING -n 3 127.0.0.1 >NUL
::Seta Variaveis
SET tipoBKP=Full
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%P_Base%-%tipoBKP%_%DataHora%.backup
SET pastaDiaria=Postgres(diario)
SET pastaMensal=Postgres(mensal)
SET prox=BKP_Oracle
::Cria pastas
IF NOT EXIST "%Caminho%\%pastaDiaria%" (MD "%Caminho%\%pastaDiaria%")
IF NOT EXIST "%Caminho%\%pastaMensal%" (MD "%Caminho%\%pastaMensal%")
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
C: & CD\%versaoPostgres%
::pg_dump.exe -h %P_Host% -p %P_Porta% -U postgres -F c -v -f "%Caminho%\%pastaDiaria%\%NomeArquivo%" %P_Base%
::pg_dump.exe -h %P_Host% -p %P_Porta% -U postgres -F c -v -f "%Caminho%\%pastaDiaria%\%NomeArquivo%" %P_Base%
::pg_dump -Fc -b -v -Z9 -h %P_Host% -p %P_Porta% -U postgres -d %P_Base% -f "%Caminho%\%pastaDiaria%\%NomeArquivo%"

pg_dump -Fc -b -v -h %P_Host% -p %P_Porta% -U postgres -d %P_Base% -f "%Caminho%\%pastaDiaria%\%NomeArquivo%" > mylogfile.log

PING -n 3 127.0.0.1 >NUL & CLS
%Unidade%: & CD %Pasta%
::Verifica backup ::echo tamanho=%tamanho% bkp & pause ::6586323 = 6,586mb
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Faz copia mensal
IF NOT exist "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%" (CLS & ECHO %DataHora%:        Iniciando copia mensal...>>"%cdLocal%\log.log" & MD "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%" & COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%\%NomeArquivo%.zip")
    ::::Faz copia para CloudDrive
    ::IF %CloudDrive%==S (CLS & ECHO %DataHora%:        Iniciando copia pasta nuvem...>>"%cdLocal%\log.log")
    ::IF %CloudDrive%==S (IF %delCloud% NEQ S (DEL /F /Q "%CaminhoCloud%\CloudDrive\*"& SET delCloud=S))
    ::IF %CloudDrive%==S (COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%CaminhoCloud%\CloudDrive")

::Faz copia para CloudDrive
IF %CloudDrive%==N (GOTO pulabkpnuvempost)
    ECHO %DataHora%:        Iniciando copia pasta nuvem...>>"%cdLocal%\log.log"
    IF NOT EXIST "%CaminhoCloud%\CloudDrive" (MD "%CaminhoCloud%\CloudDrive")
    IF %delCloud% NEQ S (DEL /F /Q "%CaminhoCloud%\CloudDrive\*")
    SET delCloud=S
    COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%CaminhoCloud%\CloudDrive"
:pulabkpnuvempost


::Limpa antigos
CLS & ECHO %DataHora%:        Limpando arquivos antigos, maior q %LimparMaisAntigosQue% dias.>>"%cdLocal%\log.log"
FORfiles -p "%Caminho%\%pastaDiaria%" -s -d -%LimparMaisAntigosQue% -m * -c "cmd /c del /f /q @path" & CLS
::Conclui Rotina
CLS & ECHO Backup %SGBD% Concluido! Continuando... & ECHO %DataHora%:    Fim BKP postgres Full...>>"%cdLocal%\log.log"
PING -n 6 127.0.0.1 >NUL & CLS
GOTO %prox%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:P_BkpSeparaEloarquivo
::Seta Variaveis
SET tipoBKP=Full
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%P_Base%-%tipoBKP%_%DataHora%.backup
SET pastaDiaria=Postgres(diario)
SET pastaMensal=Postgres(mensal)
SET pastaSexta=Postgres(sexta)
SET prox=BKP_Oracle
::Cria pastas
IF NOT EXIST "%Caminho%\%pastaDiaria%" (MD "%Caminho%\%pastaDiaria%")
IF NOT EXIST "%Caminho%\%pastaMensal%" (MD "%Caminho%\%pastaMensal%")
IF NOT EXIST "%Caminho%\%pastaSexta%" (MD "%Caminho%\%pastaSexta%")
::VerIFica o dia da semana
FOR /f "skip=1 tokens=1" %%a in ('wmic path win32_localtime get dayofweek ^| findstr /b /r "."') do SET /a dds=%%a +1
FOR /f "tokens=%dds%" %%a in ("Domingo Segunda Terca Quarta Quinta Sexta Sabado") do SET jour=%%a
::Se semana FOR igua a Sexta faz backup full, se n?o faz bakup semEloarquivo
IF %jour%==Sexta (ECHO Executando BKP_Postgres_Full & PING -n 6 127.0.0.1 >NUL & CLS) else (GOTO P_semEloarquivo)
::Roda Backup FULL SEXTA
ECHO Executando BKP_Postgres FULL SEXTA...& PING -n 3 127.0.0.1 >NUL
CLS & ECHO %DataHora%:        Iniciando BKP SEXTA nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
C: & CD\%versaoPostgres%
pg_dump -Fc -b -v -h %P_Host% -p %P_Porta% -U postgres -d %P_Base% -f "%Caminho%\%pastaSexta%\%NomeArquivo%"
PING -n 3 127.0.0.1 >NUL & CLS
%Unidade%: & CD %Pasta%
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaSexta%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaSexta%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Compacta no DIRet?rio especIFico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaSexta%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
  ::::Faz copia para CloudDrive
  ::IF %CloudDrive%==S (
  ::    IF %delCloud% NEQ S (DEL /F /Q "%CaminhoCloud%\CloudDrive\*"& SET delCloud=S)
  ::    COPY "%Caminho%\%pastaSexta%\%NomeArquivo%.zip" "%CaminhoCloud%\CloudDrive"
  ::    )
::Limpa antigos
CLS & ECHO %DataHora%:        Limpando arquivos antigos, maior q %LimparMaisAntigosQue% dias.>>"%cdLocal%\log.log"
FORfiles -p "%Caminho%\%pastaSexta%" -s -d -%LimparMaisAntigosQue% -m * -c "cmd /c del /f /q @path" & CLS
::Faz copia mensal
IF NOT exist "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%" (CLS & ECHO %DataHora%:        Iniciando copia mensal...>>"%cdLocal%\log.log" & MD "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%" & COPY "%Caminho%\%pastaSexta%\%NomeArquivo%.zip" "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%\%NomeArquivo%.zip")
::Conclui Rotina
GOTO P_semEloarquivo
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::               ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:P_semEloarquivo
ECHO Executando BKP_Postgres semEloarquivo...& PING -n 3 127.0.0.1 >NUL
SET tipoBKP=semEloarquivo
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%P_Base%-%tipoBKP%_%DataHora%.backup
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
C: & CD\%versaoPostgres%
pg_dump -Fc -b -v -h %P_Host% -p %P_Porta% -N eloarquivo -d %P_Base% -f "%Caminho%\%pastaDiaria%\%NomeArquivo%"
PING -n 3 127.0.0.1 >NUL & CLS
%Unidade%: & CD %Pasta%
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"

::Faz copia para CloudDrive
IF %CloudDrive%==N (GOTO pulabkpnuvempostsem)
    ECHO %DataHora%:        Iniciando copia pasta nuvem...>>"%cdLocal%\log.log"
    IF NOT EXIST "%CaminhoCloud%\CloudDrive" (MD "%CaminhoCloud%\CloudDrive")
    IF %delCloud% NEQ S (DEL /F /Q "%CaminhoCloud%\CloudDrive\*")
    SET delCloud=S
    COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%CaminhoCloud%\CloudDrive"
:pulabkpnuvempostsem

::Limpa antigos
CLS & ECHO %DataHora%:        Limpando arquivos antigos, maior q %LimparMaisAntigosQue% dias.>>"%cdLocal%\log.log"
FORfiles -p "%Caminho%\%pastaDiaria%" -s -d -%LimparMaisAntigosQue% -m * -c "cmd /c del /f /q @path" & CLS & CLS
::Faz copia mensal semEloarquivo
IF NOT exist "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%_semEloarquivo" (CLS & ECHO %DataHora%:        Iniciando copia mensal...>>"%cdLocal%\log.log" & MD "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%_semEloarquivo" & COPY "%Caminho%\%pastaSexta%\%NomeArquivo%.zip" "%Caminho%\%pastaMensal%\BKP_Postgres_%ANO%-%MES%_semEloarquivo\%NomeArquivo%.zip")
::Conclui Rotina
:FimBKPsemEloarquivo
CLS & ECHO Backup %SGBD% Concluido! Continuando...
CLS & ECHO %DataHora%:    Fim BKP postgres semEloarquivo...>>"%cdLocal%\log.log"
PING -n 6 127.0.0.1 >NUL & CLS
GOTO %prox%
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
:BKP_Oracle
IF %BKP_Oracle%==S (GOTO BKP_Oracle_S) ELSE (GOTO BKP_SQLServer)
::Inicio Backup oracle
:BKP_Oracle_S

::Verifica se existe SQL_CriardiretorioOracle.sql
SET pastaDiaria=Oracle(diario)
SET pastaMensal=Oracle(mensal)

IF EXIST "%Caminho%\%pastaMensal%\SQL_CriardiretorioOracle.sql" (GOTO oracleDiretoryOK)
CLS
::Cria SQL_CriardiretorioOracle.sql
IF NOT EXIST "%Caminho%\%pastaMensal%" (MD "%Caminho%\%pastaMensal%")
@ECHO SELECT * FROM dba_DIRectories;> "%Caminho%\%pastaMensal%\SQL_CriardiretorioOracle.sql"
@ECHO DROP DIRECTORY BKP_PUBLITECH;>>"%Caminho%\%pastaMensal%\SQL_CriardiretorioOracle.sql"
@ECHO CREATE OR REPLACE DIRECTORY BKP_PUBLITECH AS '%Caminho%\%pastaDiaria%';>>"%Caminho%\%pastaMensal%\SQL_CriardiretorioOracle.sql"
ECHO %DataHora%:    Arquivo "SQL_CriardiretorioOracle.sql" criado, execute no Oracle e rode a rotina novamente! Pasta do sql: "%Caminho%\%pastaMensal%">>"%cdLocal%\log.log"

::Abre menu de aviso
CLS & ECHO %DataHora%:    Criado "SQL_CriardiretorioOracle.sql" na pasta "%pastaMensal%"!...>>"%cdLocal%\log.log"
@Echo.
@Echo. #############################################################################################
@Echo. #                                                                                           #
@ECHO. #     Criado "SQL_CriardiretorioOracle.sql" na pasta "%pastaMensal%"!               #
@ECHO. #     Execute os comandos "SQL_CriardiretorioOracle.sql" antes de continuar...              #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #     1 - Continuar                                                                         #
@Echo. #     0 - SAIR                                                                              #
@Echo. #                                                                                           #
@Echo. #                                                                                           #
@Echo. #############################################################################################
@Echo.
choice /C 10 /M ". Escolha uma Opcao: "
if %ERRORLEVEL%==1 GOTO oracleDiretoryOK
if %ERRORLEVEL%==2 EXIT
:oracleDiretoryOK
CLS
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::Seta variaveis
SET O_BKPApice      =S
SET O_BKPSiscop     =S
SET O_BKPSigeloam   =S
SET O_BKPAise       =S
SET O_BKPProtocolo  =S
SET O_BKPEloarquivo =S
SET O_BKPIMAGE      =S
SET O_BKPUnico      =S
::version
SET version=11.2
::SET version=10.2

::Seta variaveis
SET SGBD=Oracle
::SET NomeArquivo=BKP_%SGBD%-%Entidade%-%O_Usuario%-%tipoBKP%_%DataHora%.backup
SET prox=BKP_Oracle
::Cria pastas
IF NOT EXIST "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%" (MD "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%")
IF NOT EXIST "%Caminho%\%pastaDiaria%" (MD "%Caminho%\%pastaDiaria%")
IF NOT EXIST "%Caminho%\%pastaMensal%" (MD "%Caminho%\%pastaMensal%")
IF NOT EXIST "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle" (MD "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle")
::Faz validacao
GOTO validaOracle
:validaOracleOK

ECHO Executando BKP_Oracle...& PING -n 3 127.0.0.1 >NUL
::Seta verificador de bkp oracle testeOra
SET testeOra=N
%Unidade%: & CD %Pasta%
::Verifica versao do oracle
IF %O_Versao-10g-11g% == 10g (GOTO BKP_Oracle10g)

CLS & ECHO %DataHora%:    Inicio BKP Oracle 11g...>>"%cdLocal%\log.log"


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:O_BKPIMAGE      
SET schema=IMAGE
SET prox=O_BKPSigeloam
IF %O_BKPIMAGE      % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%-%version%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
::EXPDP %usuario%/%senha%@%database% SCHEMAS=AISE2 version=11.2 DIRECTORY=BKP_SCHEMAS DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%tipoBKP%_%dataHora%.log

PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPSigeloam
SET schema=SIGELOAM
SET prox=O_BKPSiscop 
IF %O_BKPSigeloam   % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPSiscop
SET schema=SISCOP
SET prox=O_BKPProtocolo
IF %O_BKPSiscop     % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPProtocolo
SET schema=PROTOCOLO
SET prox=O_BKPApice
IF %O_BKPProtocolo  % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPApice
SET schema=APICE
SET prox=O_BKPAise
IF %O_BKPApice      % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPAise
SET schema=AISE
SET prox=O_BKPUnico
IF %O_BKPAise       % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPUnico
SET schema=UNICO
SET prox=O_BKPEloarquivo
IF %O_BKPUnico      % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Limpeza antes de iniciar o elorquivo

::Limpa antigos
CLS & ECHO %DataHora%:        Limpando arquivos antigos, maior q %LimparMaisAntigosQue% dias.>>"%cdLocal%\log.log"
FORfiles -p "%Caminho%\%pastaDiaria%" -s -d -%LimparMaisAntigosQue% -m * -c "cmd /c del /f /q @path" & CLS & CLS
::Move logs
IF NOT EXIST "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle" (MD "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle")
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"
::Exclui pastas vazias
CLS & ECHO %DataHora%:        Excluindo pastas vazias...>>"%cdLocal%\log.log"
%Unidade%: & CD %Pasta%
SET pastOra=%Caminho%\%pastaDiaria%
SET past=%Caminho%
%Unidade%: & CD\%pastOra%
FOR /f "tokens=*" %%d in ('DIR /ad/b/s ^| sort /R') do rd "%%d"
%Unidade%: & CD %Pasta%


CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPEloarquivo

::VerIFica o dia da semana
FOR /f "skip=1 tokens=1" %%a in ('wmic path win32_localtime get dayofweek ^| findstr /b /r "."') do SET /a dds=%%a +1
FOR /f "tokens=%dds%" %%a in ("Domingo Segunda Terca Quarta Quinta Sexta Sabado") do SET jour=%%a
::Se semana FOR igua a Sexta faz backup full, se n?o faz bakup semEloarquivo
IF %jour%==Sexta (ECHO Executando BKP_Postgres_Full & PING -n 6 127.0.0.1 >NUL & CLS) else (GOTO O_BKPconclui)

SET schema=ELOARQUIVO
SET prox=O_BKPconclui
IF %O_BKPEloarquivo % NEQ S (GOTO %prox%)
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%schema%_%DataHora%.bmp
::echo %schema%& pause
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
::CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
::FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:BKP_Oracle10g
CLS & ECHO %DataHora%:    Inicio BKP oracle 10g...>>"%cdLocal%\log.log"

SET tipoBKP=FULL
SET prox=O_BKPconclui
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%tipoBKP%_%DataHora%.bmp
::SET NomeArquivo=BKP_%SGBD%-%Entidade%-%tipoBKP%_%DataHora%.bmp
::EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=APICE DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%tipoBKP%_%DataHora%.log
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
exp %O_Usuario%/%OracleDecrpt%@%O_Database% file="%Caminho%\%pastaDiaria%\%NomeArquivo%" full=y rows=y statistics=none consistent=y
PING -n 3 127.0.0.1 >NUL & CLS
  ::EXPDP %O_Usuario%/%OracleDecrpt%@%O_Database% SCHEMAS=%schema% VERSION=%version% DIRECTORY=BKP_PUBLITECH DUMPFILE=%NomeArquivo% LOGFILE=LogBKP-%schema%_%DataHora%.log
  ::PING -n 3 127.0.0.1 >NUL & CLS
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Seta verificador
SET testeOra=S
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\<<<<%pastaDiar></%pastaDiar></%pastaDiar></%pastaDiar></%pastaDiar>ia%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Move para pasta \BKP_%SGBD%-%Entidade%_%DataHora%
MOVE /Y "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip"
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"

CLS
GOTO %prox%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:O_BKPconclui

::testa execus?o do backup oracle
IF %testeOra%==N (ECHO %DataHora%:    Erro ao fazer backup %SGBD%! Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %testeOra%==N (ECHO Erro ao fazer backup %SGBD%! Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
IF %testeOra%==N (GOTO BKP_SQLServer)
ECHO Finalizando BKP%SGBD%... & PING -n 3 127.0.0.1 >NUL
::Limpa antigos
CLS & ECHO %DataHora%:        Limpando arquivos antigos, maior q %LimparMaisAntigosQue% dias.>>"%cdLocal%\log.log"
FORfiles -p "%Caminho%\%pastaDiaria%" -s -d -%LimparMaisAntigosQue% -m * -c "cmd /c del /f /q @path" & CLS & CLS
::Move logs
IF NOT EXIST "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle" (MD "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle")
MOVE /Y "%Caminho%\%pastaDiaria%\*.log" "%Caminho%\%pastaDiaria%\_LOG_BKP_Oracle"
::Exclui pastas vazias
CLS & ECHO %DataHora%:        Excluindo pastas vazias...>>"%cdLocal%\log.log"
%Unidade%: & CD %Pasta%
SET pastOra=%Caminho%\%pastaDiaria%
SET past=%Caminho%
%Unidade%: & CD\%pastOra%
FOR /f "tokens=*" %%d in ('DIR /ad/b/s ^| sort /R') do rd "%%d"
%Unidade%: & CD %Pasta%

::Faz copia para CloudDrive
IF %CloudDrive%==N (GOTO pulabkpnuvemoracle)
    ECHO %DataHora%:        Iniciando copia pasta nuvem...>>"%cdLocal%\log.log"
    IF NOT EXIST "%CaminhoCloud%\CloudDrive" (MD "%CaminhoCloud%\CloudDrive")
    IF %delCloud% NEQ S (DEL /F /Q "%CaminhoCloud%\CloudDrive\*")
    SET delCloud=S
    IF %O_Versao-10g-11g%==10g (COPY "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip" "%CaminhoCloud%\CloudDrive")
    IF %O_Versao-10g-11g%==11g (COPY "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%" "%CaminhoCloud%\CloudDrive")
:pulabkpnuvemoracle

::Faz copia mensal
IF EXIST "%Caminho%\%pastaMensal%\BKP_Oracle_%ANO%-%MES%" (GOTO pulaMensalOracle)
    MD "%Caminho%\%pastaMensal%\BKP_Oracle_%ANO%-%MES%"
    IF %O_Versao-10g-11g%==10g (COPY "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%\%NomeArquivo%.zip" "%Caminho%\%pastaMensal%\BKP_Oracle_%ANO%-%MES%")
    IF %O_Versao-10g-11g%==11g (COPY "%Caminho%\%pastaDiaria%\BKP_%SGBD%-%Entidade%_%DataHora%" "%Caminho%\%pastaMensal%\BKP_Oracle_%ANO%-%MES%")
:pulaMensalOracle


::Conclui
CLS & ECHO Backup %SGBD% Concluido! Continuando...
CLS & ECHO %DataHora%:    Fim BKP oracle...>>"%cdLocal%\log.log"
PING -n 6 127.0.0.1 >NUL & CLS
GOTO BKP_SQLServer
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
::Inicio Backup SQLServer
:BKP_SQLServer
IF %BKP_SQLServer%==S (GOTO BKP_SQLServer_S) ELSE (GOTO BKP_Saude)
:BKP_SQLServer_S
ECHO Executando BKP_SQLServer...& PING -n 3 127.0.0.1 >NUL
CLS & ECHO %DataHora%:    Inicio BKP SQLServer...>>"%cdLocal%\log.log"
%Unidade%: & CD %Pasta%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Seta Variaveis
SET SGBD=SQLServer-SMT
SET tipoBKP=Full
SET NomeArquivo=BKP_%SGBD%-%Entidade%-%tipoBKP%_%DataHora%.bak
SET pastaDiaria=SQLServer(diario)
SET pastaMensal=SQLServer(mensal)
SET prox=BKP_Saude
::Cria pastas
IF NOT EXIST "%Caminho%\%pastaDiaria%" (MD "%Caminho%\%pastaDiaria%")
IF NOT EXIST "%Caminho%\%pastaMensal%" (MD "%Caminho%\%pastaMensal%")
::Cria BKP_SQLServer.Sql
@ECHO declare @caminho varchar(max) SET @caminho = '%Caminho%\%pastaDiaria%\%NomeArquivo%'>%Caminho%\%pastaMensal%\BKP_SQLServer.Sql
@ECHO backup database smt to disk = @caminho>>%Caminho%\%pastaMensal%\BKP_SQLServer.Sql
::Executa backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
osql -U %S_User% -P %SQLServerDecrpt% -i %Caminho%\%pastaMensal%\BKP_SQLServer.Sql
PING -n 3 127.0.0.1 >NUL & CLS
::VerIFica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Compacta no DIRet?rio especIFico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Faz copia mensal
IF NOT exist "%Caminho%\%pastaMensal%\BKP_SQLServer_%ANO%-%MES%" (MD "%Caminho%\%pastaMensal%\BKP_SQLServer_%ANO%-%MES%" & COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaMensal%\BKP_SQLServer_%ANO%-%MES%\%NomeArquivo%.zip")
::Faz copia para CloudDrive
IF %CloudDrive%==N (GOTO pulabkpnuvemserver)
    ECHO %DataHora%:        Iniciando copia pasta nuvem...>>"%cdLocal%\log.log"
    IF NOT EXIST "%CaminhoCloud%\CloudDrive" (MD "%CaminhoCloud%\CloudDrive")
    IF %delCloud% NEQ S (DEL /F /Q "%CaminhoCloud%\CloudDrive\*")
    SET delCloud=S
    COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%CaminhoCloud%\CloudDrive"
:pulabkpnuvemserver

::Limpa antigos
CLS & ECHO %DataHora%:        Limpando arquivos antigos, maior q %LimparMaisAntigosQue% dias.>>"%cdLocal%\log.log"
    FORfiles -p "%Caminho%\%pastaDiaria%" -s -d -%LimparMaisAntigosQue% -m * -c "cmd /c del /f /q @path" & CLS
::Conclui
CLS & ECHO Backup %SGBD% Concluido! Continuando...
CLS & ECHO %DataHora%:    Fim BKP SQLServer...>>"%cdLocal%\log.log"
PING -n 6 127.0.0.1 >NUL & CLS
GOTO %prox%
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
::Inicio Backup Saude
:BKP_Saude
IF %BKP_Saude%==S (GOTO BKP_Saude_S) ELSE (GOTO FIM)
:BKP_Saude_S
ECHO Executando BKP_Saude...& PING -n 3 127.0.0.1 >NUL
CLS & ECHO %DataHora%:    Inicio BKP saude...>>"%cdLocal%\log.log"
%Unidade%: & CD %Pasta%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Verifica vers?o do postgres
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
SET pguser=%SA_Usuario%
SET pgpassword=%SaudeDecrpt%

::Seta Variaveis
SET SGBD=Postgres
SET tipoBKP=SAUDE
SET NomeArquivo=BKP_%SGBD%-%tipoBKP%-%Entidade%-%SA_Base%_%DataHora%.backup
SET pastaDiaria=Saude(diario)
SET pastaMensal=Saude(mensal)
SET prox=FIM
::Cria pastas
IF NOT EXIST "%Caminho%\%pastaDiaria%" (MD "%Caminho%\%pastaDiaria%")
IF NOT EXIST "%Caminho%\%pastaMensal%" (MD "%Caminho%\%pastaMensal%")
::Roda Backup
CLS & ECHO %DataHora%:        Iniciando BKP nome "%NomeArquivo%"...>>"%cdLocal%\log.log"
C: & CD\%versaoPostgres%
pg_dump -Fc -b -v -h %SA_Host% -p %SA_Porta% -U postgres -d %SA_Base% -f "%Caminho%\%pastaDiaria%\%NomeArquivo%"
PING -n 3 127.0.0.1 >NUL & CLS
%Unidade%: & CD %Pasta%
::Verifica backup
SET tamanho=0
IF Exist "%Caminho%\%pastaDiaria%\%NomeArquivo%" (FOR %%a in (DIR "%Caminho%\%pastaDiaria%\%NomeArquivo%") do (SET /a tamanho=%%~za)) else (SET tamanho=0)
IF %tamanho% LSS 131072 (CLS & ECHO %DataHora%:            Erro BKP_%SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log")
IF %tamanho% LSS 131072 (CLS & ECHO Erro ao fazer backup %SGBD%-%tipoBKP%. Verifique as Configuracoes da rotina! & PING -n 6 127.0.0.1 >NUL & CLS)
::Compacta no Diretorio especifico e deleta antigo
CLS & ECHO %DataHora%:        Iniciando compactacao 7z...>>"%cdLocal%\log.log"
FOR %%f in ("%Caminho%\%pastaDiaria%\%NomeArquivo%") do 7z a -tzip -sdel -mx=9 "%%f".zip "%%f"
::Faz copia mensal
IF NOT exist "%Caminho%\%pastaMensal%\SAUDE2_BKP_Postgres_%ANO%-%MES%" (CLS & ECHO %DataHora%:        Iniciando copia mensal...>>"%cdLocal%\log.log" & MD "%Caminho%\%pastaMensal%\SAUDE2_BKP_Postgres_%ANO%-%MES%" & COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%Caminho%\%pastaMensal%\SAUDE2_BKP_Postgres_%ANO%-%MES%\%NomeArquivo%.zip")

::Faz copia para CloudDrive
IF %CloudDrive%==N (GOTO pulabkpnuvemsaude)
    ECHO %DataHora%:        Iniciando copia pasta nuvem...>>"%cdLocal%\log.log"
    IF NOT EXIST "%CaminhoCloud%\CloudDrive" (MD "%CaminhoCloud%\CloudDrive")
    IF %delCloud% NEQ S (DEL /F /Q "%CaminhoCloud%\CloudDrive\*")
    SET delCloud=S
    COPY "%Caminho%\%pastaDiaria%\%NomeArquivo%.zip" "%CaminhoCloud%\CloudDrive"
:pulabkpnuvemsaude


::Limpa antigos
CLS & ECHO %DataHora%:        Limpando arquivos antigos, maior q %LimparMaisAntigosQue% dias.>>"%cdLocal%\log.log"
FORfiles -p "%Caminho%\%pastaDiaria%" -s -d -%LimparMaisAntigosQue% -m * -c "cmd /c del /f /q @path" & CLS
::Conclui Rotina
CLS & ECHO Backup %SGBD% Concluido! Continuando...
CLS & ECHO %DataHora%:    Fim BKP saude...>>"%cdLocal%\log.log"
PING -n 6 127.0.0.1 >NUL & CLS
GOTO %prox%
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
:FIM
CLS

::espelha pasta em outro caminho

IF "%varCopia%"=="N" (GOTO FIMdoBKP)
IF "%varCopia%"=="C" (GOTO CopiaOutraPasta)
IF "%varCopia%"=="\" (GOTO CopiaRede)

CLS & ECHO %DataHora%:    Erro CopiaOutroCaminho, nao existe Var informada ex: N, C:\bkp ou \\192.168.1.1\bkp. Verifique as Configuracoes da rotina!>>"%cdLocal%\log.log"
CLS & ECHO Erro CopiaOutroCaminho, nao existe Var informada ex N, C:\bkp ou \\192.168.1.1\bkp. Verifique as Configuracoes da rotina!

GOTO FIMdoBKP

:CopiaOutraPasta
ECHO %DataHora%:    Inicia copia em outra pasta...>>"%cdLocal%\log.log"
SETLOCAL
SET linha=35& SET conf=0
FOR /f "delims=: tokens=1,4" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET Unidade=%varCopia%
SET Unidade=%varCopia%
SET CopiaCaminhoVar=%conf:~0,100%
ECHO CopiaCaminhoVar: "%conf:~0,100%"
SET CopiaCaminho=%Unidade%:%CopiaCaminhoVar%
ECHO %CopiaCaminho%

IF NOT EXIST "%CopiaCaminho%" (CLS & ECHO %DataHora%:    ERRO CopiaOutroCaminho, caminho "%CopiaCaminho%" para "%CopiaCaminho%" NAO EXISTE!>>"%cdLocal%\log.log" & GOTO FIMdoBKP)
IF NOT EXIST "%CopiaCaminho%" (MD "%CopiaCaminho%")
GOTO FazCopia

:CopiaRede
SETLOCAL
SET linha=35& SET conf=0
FOR /f "delims=: tokens=1,3" %%i in ('findstr /n . "Config.ini"') do IF %%i EQU %linha% SET conf=%%j
SET CopiaCaminho=%conf:~0,100%
ECHO CopiaCaminho: "%conf:~0,100%"

IF NOT EXIST "%CopiaCaminho%" (CLS & ECHO %DataHora%:    ERRO Copia em Rede, caminho "%CopiaCaminho%" para "%CopiaCaminho%" NAO EXISTE!>>"%cdLocal%\log.log")
IF NOT EXIST "%CopiaCaminho%" (MD "%CopiaCaminho%")
IF NOT EXIST "%CopiaCaminho%" (CLS & ECHO %DataHora%:    ERRO Copia em Rede, caminho "%CopiaCaminho%" para "%CopiaCaminho%" NAO FOI POSSIVEL SER CRIADO!>>"%cdLocal%\log.log")
IF NOT EXIST "%CopiaCaminho%" (CLS & ECHO ERRO Copia em Rede, caminho "%CopiaCaminho%" para "%CopiaCaminho%" NAO FOI POSSIVEL SER CRIADO! & PING -n 6 127.0.0.1 >NUL & GOTO FIMdoBKP)


:FazCopia
ECHO %DataHora%: CopiaOutroCaminho no caminho "%CopiaCaminho%".>>"%Caminho%\LogCopia.txt"
robocopy "%Caminho%" "%CopiaCaminho%" /MIR
ECHO %DataHora%:    Feito CopiaOutroCaminho em "%Caminho%" para "%CopiaCaminho%">>"%cdLocal%\log.log"

GOTO FIMdoBKP


:FIMdoBKP
CLS
ECHO FIM da Rotina! & PING -n 6 127.0.0.1 >NUL
CLS & ECHO %DataHora%: FIM Rotina de BackuppPublitech!>>"%cdLocal%\log.log"
EXIT
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
IF %VAR_Unidade% == 0 (ECHO Erro na Variavel informada "Unidade=%Unidade%", ex: C, D, E... & pause >NUL & Exit)

::SET VARCloudDrive=0
::IF %CloudDrive% == S (SET VARCloudDrive=1)
::IF %CloudDrive% == N (SET VARCloudDrive=1)
::IF %CloudDrive% == A (SET VARCloudDrive=1)
::IF %CloudDrive% == D (SET VARCloudDrive=1)
::IF %CloudDrive% == M (SET VARCloudDrive=1)
::IF %VARCloudDrive% == 0 (ECHO Erro na Variavel informada "CloudDrive=%CloudDrive%", ex: S ou N & pause >NUL & Exit)

SET VAR_BKP_Postgres  =0
IF %BKP_Postgres% == S (SET VAR_BKP_Postgres  =1)
IF %BKP_Postgres% == N (SET VAR_BKP_Postgres  =1)
IF %VAR_BKP_Postgres  % == 0 (ECHO Erro na Variavel informada "BKP_Postgres=%BKP_Postgres%", ex: S ou N & pause >NUL & Exit)

SET VAR_BKP_Oracle=0
IF %BKP_Oracle% == S (SET VAR_BKP_Oracle=1)
IF %BKP_Oracle% == N (SET VAR_BKP_Oracle=1)
IF %VAR_BKP_Oracle% == 0 (ECHO Erro na Variavel informada "BKP_Oracle=%BKP_Oracle%", ex: S ou N & pause >NUL & Exit)

SET VAR_BKP_SQLServer =0
IF %BKP_SQLServer% == S (SET VAR_BKP_SQLServer =1)
IF %BKP_SQLServer% == N (SET VAR_BKP_SQLServer =1)
IF %VAR_BKP_SQLServer % == 0 (ECHO Erro na Variavel informada "BKP_SQLServer=%BKP_SQLServer%", ex: S ou N & pause >NUL & Exit)

SET VAR_BKP_Saude     =0
IF %BKP_Saude% == S (SET VAR_BKP_Saude     =1)
IF %BKP_Saude% == N (SET VAR_BKP_Saude     =1)
IF %VAR_BKP_Saude     % == 0 (ECHO Erro na Variavel informada "BKP_Saude=%BKP_Saude%", ex: S ou N & pause >NUL & Exit)

SET VAR_P_SeparaEloarquivo=0
IF %P_SeparaEloarquivo% == S (SET VAR_P_SeparaEloarquivo=1)
IF %P_SeparaEloarquivo% == N (SET VAR_P_SeparaEloarquivo=1)
IF %VAR_P_SeparaEloarquivo% == 0 (ECHO Erro na Variavel informada "P_SeparaEloarquivo=%P_SeparaEloarquivo%", ex: S ou N & pause >NUL & Exit)

SET VAR_O_Versao-10g-11g=0
IF %O_Versao-10g-11g% == 10g (SET VAR_O_Versao-10g-11g=1)
IF %O_Versao-10g-11g% == 11g (SET VAR_O_Versao-10g-11g=1)
IF %VAR_O_Versao-10g-11g% == 0 (ECHO Erro na Variavel informada "O_Versao-10g-11g=%O_Versao-10g-11g%", ex: 10g ou 11g & pause >NUL & Exit)

SET VAR_O_SeparaEloarquivo=0
IF %O_SeparaEloarquivo% == S (SET VAR_O_SeparaEloarquivo=1)
IF %O_SeparaEloarquivo% == N (SET VAR_O_SeparaEloarquivo=1)
IF %VAR_O_SeparaEloarquivo% == 0 (ECHO Erro na Variavel informada "O_SeparaEloarquivo=%O_SeparaEloarquivo%", ex: S ou N & pause >NUL & Exit)

CLS
GOTO Validado
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::   00                                                                                                
::   0000                                                                                              
::   0000000                                                                                           
::   000000000                                                                                         
::   0000000                                                                                           
::   0000                                                                                              
::   00                                                                                                
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:validaOracle
SET VAR_O_BKPApice      =0
IF %O_BKPApice      % == S (SET VAR_O_BKPApice      =1)
IF %O_BKPApice      % == N (SET VAR_O_BKPApice      =1)
IF %VAR_O_BKPApice      % == 0 (ECHO Erro na Variavel informada "O_BKPApice=%O_BKPApice      %", ex: S ou N & pause >NUL & Exit)

SET VAR_O_BKPSiscop     =0
IF %O_BKPSiscop     % == S (SET VAR_O_BKPSiscop     =1)
IF %O_BKPSiscop     % == N (SET VAR_O_BKPSiscop     =1)
IF %VAR_O_BKPSiscop     % == 0 (ECHO Erro na Variavel informada "O_BKPSiscop=%O_BKPSiscop     %", ex: S ou N & pause >NUL & Exit)

SET VAR_O_BKPSigeloam   =0
IF %O_BKPSigeloam   % == S (SET VAR_O_BKPSigeloam   =1)
IF %O_BKPSigeloam   % == N (SET VAR_O_BKPSigeloam   =1)
IF %VAR_O_BKPSigeloam   % == 0 (ECHO Erro na Variavel informada "O_BKPSigeloam=%O_BKPSigeloam   %", ex: S ou N & pause >NUL & Exit)

SET VAR_O_BKPAise       =0
IF %O_BKPAise       % == S (SET VAR_O_BKPAise       =1)
IF %O_BKPAise       % == N (SET VAR_O_BKPAise       =1)
IF %VAR_O_BKPAise       % == 0 (ECHO Erro na Variavel informada "O_BKPAise=%O_BKPAise       %", ex: S ou N & pause >NUL & Exit)

SET VAR_O_BKPProtocolo  =0
IF %O_BKPProtocolo  % == S (SET VAR_O_BKPProtocolo  =1)
IF %O_BKPProtocolo  % == N (SET VAR_O_BKPProtocolo  =1)
IF %VAR_O_BKPProtocolo  % == 0 (ECHO Erro na Variavel informada "O_BKPProtocolo=%O_BKPProtocolo  %", ex: S ou N & pause >NUL & Exit)

SET VAR_O_BKPEloarquivo =0
IF %O_BKPEloarquivo % == S (SET VAR_O_BKPEloarquivo =1)
IF %O_BKPEloarquivo % == N (SET VAR_O_BKPEloarquivo =1)
IF %VAR_O_BKPEloarquivo % == 0 (ECHO Erro na Variavel informada "O_BKPEloarquivo=%O_BKPEloarquivo %", ex: S ou N & pause >NUL & Exit)

SET VAR_O_BKPUnico      =0
IF %O_BKPUnico      % == S (SET VAR_O_BKPUnico      =1)
IF %O_BKPUnico      % == N (SET VAR_O_BKPUnico      =1)
IF %VAR_O_BKPUnico      % == 0 (ECHO Erro na Variavel informada "O_BKPUnico=%O_BKPUnico      %", ex: S ou N & pause >NUL & Exit)

CLS
GOTO validaOracleOK

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
