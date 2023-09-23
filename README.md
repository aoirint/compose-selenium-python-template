# compose-selenium-python-template

Docker Compose + Python + Seleniumの環境構築テンプレート。

## 動作環境

- Python 3.11
- Poetry 1.6

## Pythonライブラリの管理

Pythonライブラリの管理に[Poetry](https://python-poetry.org/docs/#installation)を使っています。

ライブラリを変更した場合、以下のコマンドでrequirements.txtを更新します。

```shell
poetry export --without-hashes -o requirements.txt
poetry export --without-hashes --with dev -o requirements-dev.txt
```
