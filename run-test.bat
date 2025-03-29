@echo off
set VIRTUAL_ENV=.venv
echo VIRTUAL_ENV is set to %VIRTUAL_ENV%

:: Install uv latest version
pip install --upgrade uv -q

set PATH=%PATH%;%~dp0.venv\Lib\site-packages\torch\lib

:: If the exit code is 0, run the kohya_gui.py script with the command-line arguments
if %errorlevel% equ 0 (
    REM Check if the batch was started via double-click
    IF /i "%comspec% /c %~0 " equ "%cmdcmdline:"=%" (
        REM echo This script was started by double clicking.
        cmd /k uv run --link-mode=copy --index-strategy unsafe-best-match python -m scripts.inference_triposg --image-input "C:\Users\berna\Downloads\t.jpg" --num-inference-steps 75
    ) ELSE (
        REM echo This script was started from a command prompt.
        uv run --link-mode=copy --index-strategy unsafe-best-match python -m scripts.inference_triposg --image-input "C:\Users\berna\Downloads\t.jpg" --num-inference-steps 75
    )
)