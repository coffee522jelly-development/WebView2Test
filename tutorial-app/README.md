# SvelteKit + WebView2 Windows アプリ チュートリアル

このプロジェクトは、C++ (WebView2) をホストとし、UI に SvelteKit + Tailwind CSS + shadcn-svelte を使用した Windows デスクトップアプリケーションの構成例です。MFC のような標準的なコントロールをモダンな Web 技術で再現し、ネイティブ機能との連携を示します。

## プロジェクト構成

- `ui/`: SvelteKit フロントエンド (TypeScript + Tailwind + shadcn-svelte)
- `app/`: C++ (Win32 + WebView2) ホストアプリケーション
- `package.json`: 全体のビルドと依存関係を管理するルート設定

## 開発環境の準備

1. **Node.js**: フロントエンドのビルドに必要です。
2. **Visual Studio 2022**: C++ の開発環境 (Windows SDK 含む) が必要です。
3. **WebView2 SDK**: NuGet または vcpkg 経由で取得してください。
4. **CMake**: C++ のビルドシステムとして使用します。

## ビルドと実行方法（Visual Studio 使用時）

### 1. セットアップスクリプトの実行

ルートディレクトリにある **`setup_vs.bat`** をダブルクリックして実行してください。
このスクリプトは以下の作業を自動で行います：
- UI のライブラリインストール (`npm install`)
- UI のビルド (静的ファイルの生成)
- Visual Studio 用ソリューションファイル (`.sln`) の生成

### 2. Visual Studio でプロジェクトを開く

1. 生成された `app/build/WebView2Tutorial.sln` を Visual Studio 2022 で開きます。
2. ソリューションエクスプローラーで `WebView2Tutorial` プロジェクトを右クリックし、**「スタートアップ プロジェクトに設定」** を選択します。

### 3. WebView2 SDK のインストール

ビルドエラーが出る場合は、以下の手順で SDK を追加してください：
1. **[ツール] > [NuGet パッケージ マネージャー] > [ソリューションの NuGet パッケージの管理]** を開きます。
2. 「参照」タブで `Microsoft.Web.WebView2` を検索し、プロジェクトにインストールします。

### 4. ビルドと実行

`F5` キーを押して実行します。ビルドが成功すると、`app/build/Debug/` 内に **`WebView2Tutorial.exe`** が生成されます。

## ビルドと実行方法（コマンドライン使用時）

### 3. フロントエンドの開発（ホットリロード）

```bash
npm run ui:dev
```

UI が `http://localhost:5173` で起動します。`app/main.cpp` はデフォルトでこの開発用 URL を読み込むように設定されているため、開発中の変更が即座に反映されます。

## 実装されている機能

- **Static Text / Edit Control**: `Label` と `Input` コンポーネント。
- **Radio Buttons**: `RadioGroup` コンポーネント。
- **Combo Box**: `Select` コンポーネント。
- **List Control**: `Table` コンポーネント。
- **Clipboard**: `navigator.clipboard` とネイティブメッセージ経由の通知。
- **Drag & Drop**: HTML5 Drag and Drop API を使用したデータの受け渡し。
- **Native Bridge**: `window.chrome.webview.postMessage` を使用した C++ との双方向通信。

## 注意事項

- このサンプルはチュートリアル用です。本番環境では `adapter-static` を使用して生成された静的ファイルを C++ 側からリソースとして読み込む設定が推奨されます。
- `app/CMakeLists.txt` 内の WebView2 SDK へのパスは、ご自身の環境に合わせて適宜調整してください。

## トラブルシューティング

### 'cmake' が認識されない場合
`'cmake' は、内部コマンドまたは外部コマンド...として認識されていません` というエラーが出る場合は、CMake の実行パスがシステムの環境変数（PATH）に追加されていません。

1.  **PATH の確認**: CMake のインストール先（例: `C:\Program Files\CMake\bin`）をシステムの環境変数に追加してください。
2.  **再起動**: 設定後、コマンドプロンプトや VS Code を再起動して反映させてください。
3.  **開発者用プロンプト**: Visual Studio に付属する **「Developer Command Prompt for VS 2022」** または **「Developer PowerShell for VS 2022」** を使用すると、CMake やコンパイラの設定が自動で有効になるため、こちらでのビルドを推奨します。
