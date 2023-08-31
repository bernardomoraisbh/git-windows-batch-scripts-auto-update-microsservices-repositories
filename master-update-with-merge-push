@echo off
setlocal enabledelayedexpansion

for /d %%f in (*) do (
    cd %%f

    if exist .git (
        echo.
        echo === Updating project: %%f ===

        for /f %%b in ('git rev-parse --abbrev-ref HEAD') do set original_branch=%%b
        echo Original branch: !original_branch!

        set target_branch=
        
        if not "!original_branch!"=="main" if not "!original_branch!"=="master" (
            git show-ref --verify --quiet refs/heads/main
            if errorlevel 1 (
                git show-ref --verify --quiet refs/heads/master
                if errorlevel 1 (
                    echo Neither main nor master branch exists in repository %%f
                    echo Press any key to continue...
                    pause >nul
                ) else (
                    echo Switching to master branch...
                    git checkout master
                    if errorlevel 1 (
                        echo Failed to checkout master in %%f
                        echo Press any key to continue...
                        pause >nul
                    ) else (
                        set target_branch=master
                    )
                )
            ) else (
                echo Switching to main branch...
                git checkout main
                if errorlevel 1 (
                    echo Failed to checkout main in %%f
                    echo Press any key to continue...
                    pause >nul
                ) else (
                    set target_branch=main
                )
            )
            
            if defined target_branch (
                echo Pulling latest from !target_branch!...
                git pull
                if errorlevel 1 (
                    echo Failed to pull in %%f
                    echo Press any key to continue...
                    pause >nul
                ) else (
                    echo Switching back to !original_branch!...
                    git checkout !original_branch!
                    if errorlevel 1 (
                        echo Failed to checkout back to !original_branch! in %%f
                        echo Press any key to continue...
                        pause >nul
                    ) else (
                        echo Merging !target_branch! into !original_branch!...
                        git merge !target_branch!
                        if errorlevel 1 (
                            echo Failed to merge !target_branch! into !original_branch! in %%f
                            echo Press any key to continue...
                            pause >nul
                        ) else (
							echo Pushing !original_branch! into remote repository...
							git push
							if errorlevel 1 (
								echo Failed to push !original_branch! into remote repository
								echo Press any key to continue...
								pause >nul
							)
						)
                    )
                )
            )

        ) else (
            echo Pulling latest from !original_branch!...
            git pull
            if errorlevel 1 (
                echo Failed to pull in %%f
                echo Press any key to continue...
                pause >nul
            )
        )
    )
    cd ..
)

echo.
echo All projects updated. Press any key to exit...
pause >nul
