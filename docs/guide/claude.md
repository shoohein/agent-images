# Claude Code Docker イメージ

Claude Code をコンテナ内で実行するための Docker イメージです。
ベースイメージ (`agent/base`) の上に `@anthropic-ai/claude-code` を npm グローバルインストールしています。

## 前提条件

- [Docker](https://docs.docker.com/get-docker/)
- [GNU Make](https://www.gnu.org/software/make/)

## ビルド方法

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```bash
# 最新版 (latest) のビルド
make build-claude-code

# 特定のバージョンを指定してビルド
make build-claude-code CLAUDE_CODE_VERSION=1.2.3

# キャッシュを無視してリビルド
make build-claude-code FORCE=1
```

## 使い方

ビルドしたイメージを使って Claude Code を起動する例です。

```bash
docker run --rm -it \
    -v $(pwd):/workspaces/main \
    -v ~/.claude.json:/home/agent/.claude.json \
    -v ~/.claude:/home/agent/.claude \
    agent/claude
```

ホストの作業ディレクトリを `/workspaces/main` にマウントし、
設定を永続化するために `~/.claude.json` と `~/.claude` をマウントしています。

## イメージ情報

- **イメージ名**: `agent/claude`
- **ベースイメージ**: `agent/base`
- **エントリポイント**: `claude`
- **実行ユーザー**: `agent` (非特権)

### 永続化が必要なディレクトリ

| コンテナ内パス | 用途 |
|---------------|------|
| `/home/agent/.claude` | 設定とデータ |
| `/home/agent/.claude.json` | 設定ファイル |

## リンク

- [GitHub](https://github.com/anthropics/claude-code)
- [公式ドキュメント](https://docs.anthropic.com/en/docs/claude-code)
