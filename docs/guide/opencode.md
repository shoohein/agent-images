# OpenCode Docker イメージ

OpenCode をコンテナ内で実行するための Docker イメージです。
ベースイメージ (`agent/base`) の上に `opencode-ai` を npm グローバルインストールしています。

## 前提条件

- [Docker](https://docs.docker.com/get-docker/)
- [GNU Make](https://www.gnu.org/software/make/)

## ビルド方法

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```bash
# 最新版 (latest) のビルド
make build-opencode

# 特定のバージョンを指定してビルド
make build-opencode OPENCODE_VERSION=1.2.3

# キャッシュを無視してリビルド
make build-opencode FORCE=1
```

## 使い方

ビルドしたイメージを使って OpenCode を起動する例です。

```bash
docker run --rm -it \
    -v $(pwd):/workspaces/main \
    -v ~/.config/opencode:/home/agent/.config/opencode \
    agent/opencode
```

ホストの作業ディレクトリを `/workspaces/main` にマウントし、
設定ファイルを永続化するために `~/.config/opencode` をマウントしています。

## イメージ情報

- **イメージ名**: `agent/opencode`
- **ベースイメージ**: `agent/base`
- **エントリポイント**: `opencode`
- **実行ユーザー**: `agent` (非特権)

### 永続化が必要なディレクトリ

OpenCode の設定やデータをコンテナの再作成後も引き継ぐには、
以下のディレクトリをボリュームまたはバインドマウントしてください。

| コンテナ内パス | 用途 |
|---------------|------|
| `/home/agent/.config/opencode` | 設定ファイル (`opencode.jsonc` など) |
| `/home/agent/.cache/opencode` | キャッシュ |
| `/home/agent/.local/share/opencode` | アプリケーションデータ |
| `/home/agent/.local/state/opencode` | 状態データ |

## リンク

- [GitHub](https://github.com/anomalyco/opencode)
- [公式ドキュメント](https://opencode.ai/docs)
