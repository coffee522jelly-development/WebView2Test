# SvelteKit + WebView2 Windows App Tutorial

このプロジェクトは、C++ (WebView2) をホストとし、UI に SvelteKit + Tailwind CSS + shadcn-svelte を使用した Windows デスクトップアプリケーションの構成例です。MFC のような標準的なコントロール（テキスト、エディット、ラジオ、コンボ、リスト）をモダンな Web 技術で再現し、ネイティブ機能（クリップボード、ドラッグ＆ドロップ）との連携を示します。

## プロジェクト構成

- `ui/`: SvelteKit フロントエンド（TypeScript + Tailwind + shadcn-svelte）
- `app/`: C++ (Win32 + WebView2) ホストアプリケーション

## 開発環境の準備

1. **Node.js**: UI のビルドに必要です。
2. **Visual Studio 2022**: C++ の開発環境と Windows SDK が必要です。
3. **WebView2 SDK**: NuGet または vcpkg 経由で取得してください。
4. **CMake**: C++ プロジェクトのビルドシステムとして使用します。

## ビルドと実行方法

### 1. UI (フロントエンド) の準備

```bash
cd ui
npm install
npm run dev
```

UI が `http://localhost:5173` で起動します。

### 2. C++ アプリケーション (ホスト) のビルド

Visual Studio または CMake を使用して `app/` ディレクトリをビルドします。

```bash
cd app
mkdir build
cd build
cmake ..
# 生成された .sln ファイルを Visual Studio で開き、ビルド・実行します
```

※ デフォルトでは `main.cpp` 内で `http://localhost:5173` をロードするように設定されています。

## 実装されている機能

- **Static Text / Edit Control**: `Label` と `Input` コンポーネント。
- **Radio Buttons**: `RadioGroup` コンポーネント。
- **Combo Box**: `Select` コンポーネント。
- **List Control**: `Table` コンポーネント。
- **Clipboard**: `navigator.clipboard` とネイティブメッセージ経由の通知。
- **Drag & Drop**: HTML5 Drag and Drop API を使用し、受け取ったデータをネイティブへ通知。
- **Native Bridge**: `window.chrome.webview.postMessage` を使用した双方向通信。

## 注意事項

- このサンプルはチュートリアル用であり、プロダクション環境では静的ファイルのホスティング（`adapter-static` の使用）や、WebView2 SDK のパス設定などを適切に行う必要があります。
