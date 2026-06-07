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

## ビルドと実行方法

ルートディレクトリから `npm` を使用して、UI とアプリの両方をセットアップ・ビルドできます。

### 1. 初回セットアップ

```bash
npm run setup
```

### 2. アプリケーションのビルド

```bash
npm run build
```

これにより、`ui/` のビルド（静的ファイル生成）と、`app/build/` 内での C++ アプリケーションのコンパイルが順次行われます。ビルドが成功すると、`app/build/Debug/`（または `Release/`）ディレクトリ内に **`WebView2Tutorial.exe`** が生成されます。

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
