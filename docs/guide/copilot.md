# GitHub Copilot Docker イメージ

GitHub Copilot CLI をコンテナ内で実行するための Docker イメージです。
ベースイメージ (`agent/base`) の上に `@github/copilot` を npm グローバルインストールしています。

## 前提条件

- [Docker](https://docs.docker.com/get-docker/)
- [GNU Make](https://www.gnu.org/software/make/)

## ビルド方法

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```bash
# 最新版 (latest) のビルド
make build-copilot

# 特定のバージョンを指定してビルド
make build-copilot COPILOT_VERSION=1.2.3

# キャッシュを無視してリビルド
make build-copilot FORCE=1
```

## 使い方

ビルドしたイメージを使って GitHub Copilot CLI を起動する例です。

```bash
docker run --rm -it \
    -v $(pwd):/workspaces/main \
    -v ~/.copilot:/home/agent/.copilot \
    agent/copilot
```

ホストの作業ディレクトリを `/workspaces/main` にマウントし、
設定を永続化するために `~/.copilot` をマウントしています。

## イメージ情報

- **イメージ名**: `agent/copilot`
- **ベースイメージ**: `agent/base`
- **エントリポイント**: `copilot`
- **実行ユーザー**: `agent` (非特権)

### 永続化が必要なディレクトリ

| コンテナ内パス | 用途 |
|---------------|------|
| `/home/agent/.copilot` | 設定とデータ |

## リンク

- [GitHub](https://github.com/github/copilot-cli)
- [公式ドキュメント](https://docs.github.com/en/copilot)
