# Pi Coding Agent Docker イメージ

Pi Coding Agent をコンテナ内で実行するための Docker イメージです。
ベースイメージ (`agent/base`) の上に `@earendil-works/pi-coding-agent` を npm グローバルインストールしています。

## 前提条件

- [Docker](https://docs.docker.com/get-docker/)
- [GNU Make](https://www.gnu.org/software/make/)

## ビルド方法

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```bash
# 最新版 (latest) のビルド
make build-pi

# 特定のバージョンを指定してビルド
make build-pi PI_VERSION=1.2.3

# キャッシュを無視してリビルド
make build-pi FORCE=1
```

## 使い方

ビルドしたイメージを使って Pi Coding Agent を起動する例です。

```bash
docker run --rm -it \
    -e ANTHROPIC_API_KEY \
    -v $(pwd):/workspaces/main \
    -v ~/.pi/agent:/home/agent/.pi/agent \
    agent/pi
```

ホストの作業ディレクトリを `/workspaces/main` にマウントし、
設定・認証情報・セッションを永続化するために `~/.pi/agent` をマウントしています。

> [!NOTE]
> `~/.pi/agent` にはホストの認証情報 (`auth.json`) が含まれます。
> コンテナにホストの認証情報を渡したくない場合はマウントせず、
> 環境変数 (`ANTHROPIC_API_KEY` など) や名前付きボリュームを利用してください。

## イメージ情報

- **イメージ名**: `agent/pi`
- **ベースイメージ**: `agent/base`
- **エントリポイント**: `pi`
- **実行ユーザー**: `agent` (非特権)

### 永続化が必要なディレクトリ

Pi Coding Agent の設定やデータをコンテナの再作成後も引き継ぐには、
以下のディレクトリをボリュームまたはバインドマウントしてください。

| コンテナ内パス | 用途 |
|---------------|------|
| `/home/agent/.pi/agent` | エージェントディレクトリ (`settings.json`, `auth.json`, `sessions/`, `extensions/`, `themes/`, `prompts/` など) |

`PI_CODING_AGENT_DIR` を指定すると、エージェントディレクトリの場所を変更できます。

## リンク

- [GitHub](https://github.com/earendil-works/pi)
- [公式ドキュメント](https://github.com/earendil-works/pi/tree/main/packages/coding-agent/docs)
