# compose-selenium-python-template

Docker Compose + Python + Seleniumの環境構築テンプレート。

## Pythonライブラリの管理

Pythonライブラリの管理に[Poetry](https://python-poetry.org/docs/#installation)を使っています。

```shell
poetry export --without-hashes -o requirements.txt
poetry export --without-hashes --with dev -o requirements-dev.txt
```
