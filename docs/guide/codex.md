# Codex CLI Docker イメージ

Codex CLI をコンテナ内で実行するための Docker イメージです。
ベースイメージ (`agent/base`) の上に `@openai/codex` を npm グローバルインストールしています。

## 前提条件

- [Docker](https://docs.docker.com/get-docker/)
- [GNU Make](https://www.gnu.org/software/make/)

## ビルド方法

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```bash
# 最新版 (latest) のビルド
make build-codex-cli

# 特定のバージョンを指定してビルド
make build-codex-cli CODEX_CLI_VERSION=1.2.3

# キャッシュを無視してリビルド
make build-codex-cli FORCE=1
```

## 使い方

ビルドしたイメージを使って Codex CLI を起動する例です。

```bash
docker run --rm -it \
    -v $(pwd):/workspaces/main \
    -v ~/.codex:/home/agent/.codex \
    agent/codex
```

ホストの作業ディレクトリを `/workspaces/main` にマウントし、
設定を永続化するために `~/.codex` をマウントしています。

## イメージ情報

- **イメージ名**: `agent/codex`
- **ベースイメージ**: `agent/base`
- **エントリポイント**: `codex`
- **実行ユーザー**: `agent` (非特権)

### 永続化が必要なディレクトリ

| コンテナ内パス | 用途 |
|---------------|------|
| `/home/agent/.codex` | 設定とデータ |

## リンク

- [GitHub](https://github.com/openai/codex)
- [開発者ドキュメント](https://developers.openai.com/codex/cli)
