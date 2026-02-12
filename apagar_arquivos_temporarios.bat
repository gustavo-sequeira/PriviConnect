@echo off
echo ========================================
echo     LIMPADOR DE ARQUIVOS TEMPORARIOS
echo ========================================
echo.

set REMOVIDO=0

echo Procurando arquivos para remover (incluindo subpastas):
echo.

for /r %%F in (*.dcu *.dcp *.bpl *.identcache *.local) do (
    echo Removendo %%F
    del /q "%%F"
    set REMOVIDO=1
)

if %REMOVIDO%==0 (
    echo Nenhum arquivo encontrado para remover
)

echo.
echo ========================================
echo Processo finalizado
echo ========================================
echo.
pause
