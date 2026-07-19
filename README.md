# AIエージェントDockerイメージ

AIコーディングエージェントのDockerイメージを管理するリポジトリです。

## 対応ツール一覧

| 対応ツール | イメージ名 | ガイド |
|-----------|-----------|--------|
| [OpenCode](https://opencode.ai/docs) | `agent/opencode` | [詳細](docs/guide/opencode.md) |
| [Codex CLI](https://github.com/openai/codex) | `agent/codex` | [詳細](docs/guide/codex.md) |
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | `agent/claude` | [詳細](docs/guide/claude.md) |
| [GitHub Copilot](https://docs.github.com/en/copilot) | `agent/copilot` | [詳細](docs/guide/copilot.md) |

## 前提条件

- [Docker](https://docs.docker.com/get-docker/)
- [GNU Make](https://www.gnu.org/software/make/)

## クイックスタート

```bash
git clone https://github.com/shoohein/agent-images
cd agent-images
make build-all
```

## イメージのビルド方法

```bash
# 全てのイメージをビルド
make build-all

# 全てのイメージをキャッシュ無視でビルド
make build-all-force
```

それぞれのイメージの詳細なビルド方法については、[`docs/guide/`](docs/guide/) を参照してください。

## 権限モデル

- エージェント本体は、`agent` ユーザー（非sudo）で実行されます。
- ベースイメージ内で `agent` ユーザーを作成し、すべてのエージェントイメージで共通して使用します。

## インストール済みのツール

### 基本ツール

- 実行環境: `nodejs`, `python3`
- 版管理・通信: `git`, `curl`
- 検索・整形・閲覧: `jq`, `ripgrep`, `fd`, `less`, `tree`, `yq`
- ビルド・圧縮・計測: `make`, `unzip`, `zip`, `time`

## ライセンス

[MIT](LICENSE)
