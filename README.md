# compose-selenium-python-template

Docker Compose + Python + Seleniumの環境構築テンプレート。

## 開発環境

- Docker Engine 24
- Docker Compose V2
- Python 3.11
- Poetry 1.7

## 実行手順

作業ディレクトリを作成します。所有者は、コンテナ内ユーザと同じUID 1000に変更します。

```shell
mkdir work
sudo chown -R 1000:1000 work
```

必要なDockerイメージを取得し、アプリケーションのDockerイメージをビルドします。

```shell
sudo docker compose pull
sudo docker compose build
```

Docker Composeサービスを起動します。

```shell
sudo docker compose up -d
```

実行すると、`work/screenshot.png`に`https://example.com`のスクリーンショットが出力されます。

## コードフォーマット

```shell
poetry run pysen run lint
poetry run pysen run format
```

## Pythonライブラリの管理

Pythonライブラリの管理に[Poetry](https://python-poetry.org/docs/#installation)を使っています。
