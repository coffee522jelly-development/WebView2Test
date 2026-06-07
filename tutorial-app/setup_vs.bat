@echo off
echo [1/3] フロントエンドの依存関係をインストール中...
call npm install --prefix ui

echo [2/3] UI をビルド中...
call npm run build --prefix ui

echo [3/3] Visual Studio ソリューションを生成中...
if not exist app\build mkdir app\build
cd app\build
cmake -G "Visual Studio 17 2022" -A x64 ..

echo.
echo ========================================================
echo セットアップが完了しました！
echo app/build/WebView2Tutorial.sln を Visual Studio で開いてください。
echo ========================================================
pause
