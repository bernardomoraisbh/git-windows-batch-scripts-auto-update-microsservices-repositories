for /f %%f in ('dir /ad /b .\') do cd /d .\%%f & call git pull & cd ..
pause