@echo off
setlocal enabledelayedexpansion

::Bash script that navigates through each sub-directory, checks the current branch using git rev-parse --abbrev-ref HEAD, and then switches to main or master as necessary before performing a git pull.
::The name of the project is displayed before updating it.
::If an error occurs (during checkout or pull), a message is displayed and it waits for the user to press a key before continuing.
::After updating all projects, it waits for user input before exiting.
for /d %%f in (*) do (
    cd %%f
    if exist .git (
        echo.
        echo === Updating project: %%f ===
        for /f %%b in ('git rev-parse --abbrev-ref HEAD') do set current_branch=%%b
        if not "!current_branch!"=="main" if not "!current_branch!"=="master" (
            git show-ref --verify --quiet refs/heads/main
            if errorlevel 1 (
                git show-ref --verify --quiet refs/heads/master
                if errorlevel 1 (
                    echo Neither main nor master branch exists in repository %%f
                    echo Press any key to continue...
                    pause >nul
                ) else (
                    git checkout master || (
                        echo Failed to checkout master in %%f
                        echo Press any key to continue...
                        pause >nul
                    )
                )
            ) else (
                git checkout main || (
                    echo Failed to checkout main in %%f
                    echo Press any key to continue...
                    pause >nul
                )
            )
        )
        git pull || (
            echo Failed to pull in %%f
            echo Press any key to continue...
            pause >nul
        )
    )
    cd ..
)

echo.
echo All projects updated. Press any key to exit...
pause >nul