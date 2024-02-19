# syntax=docker/dockerfile:1.6
FROM python:3.11

ARG DEBIAN_FRONTEND=noninteractive
ARG PIP_NO_CACHE_DIR=1
ENV PYTHONUNBUFFERED=1
ENV PATH=/code/compose_selenium_python_template/.venv/bin:/home/user/.local/bin:${PATH}

RUN <<EOF
    set -eu

    apt-get update
    apt-get install -y \
        gosu \
        wait-for-it

    apt-get clean
    rm -rf /var/lib/apt/lists/*
EOF

ARG CONTAINER_UID=1000
ARG CONTAINER_GID=1000
RUN <<EOF
    set -eu

    groupadd --non-unique --gid "${CONTAINER_GID}" user
    useradd --non-unique --uid "${CONTAINER_UID}" --gid "${CONTAINER_GID}" --create-home user
EOF

ARG POETRY_VERSION=1.7.1
RUN <<EOF
    set -eu

    gosu user pip install "poetry==${POETRY_VERSION}"

    gosu user poetry config virtualenvs.in-project true

    mkdir -p /home/user/.cache/pypoetry/{cache,artifacts}
    chown -R "${CONTAINER_UID}:${CONTAINER_GID}" /home/user/.cache
EOF

RUN <<EOF
    set -eu

    mkdir -p /code/compose_selenium_python_template
    chown -R "${CONTAINER_UID}:${CONTAINER_GID}" /code/compose_selenium_python_template
EOF

ADD --chown="${CONTAINER_UID}:${CONTAINER_GID}" ./pyproject.toml ./poetry.lock /code/compose_selenium_python_template/
RUN --mount=type=cache,uid="${CONTAINER_UID}",gid="${CONTAINER_GID}",target=/home/user/.cache/pypoetry/cache \
    --mount=type=cache,uid="${CONTAINER_UID}",gid="${CONTAINER_GID}",target=/home/user/.cache/pypoetry/artifacts <<EOF
    set -eu

    cd /code/compose_selenium_python_template
    gosu user poetry install --no-root --only main
EOF

ADD --chown="${CONTAINER_UID}:${CONTAINER_GID}" ./compose_selenium_python_template /code/compose_selenium_python_template/compose_selenium_python_template
ADD --chown="${CONTAINER_UID}:${CONTAINER_GID}" ./README.md /code/compose_selenium_python_template/
RUN --mount=type=cache,uid="${CONTAINER_UID}",gid="${CONTAINER_GID}",target=/home/user/.cache/pypoetry/cache \
    --mount=type=cache,uid="${CONTAINER_UID}",gid="${CONTAINER_GID}",target=/home/user/.cache/pypoetry/artifacts <<EOF
    set -eu

    cd /code/compose_selenium_python_template
    gosu user poetry install --only main
EOF

RUN <<EOF
    set -eu

    mkdir -p /work
    chown -R "${CONTAINER_UID}:${CONTAINER_GID}" /work
EOF

WORKDIR /work
ENTRYPOINT [ "wait-for-it", "selenium:4444", "--", "gosu", "user", "python", "-m", "compose_selenium_python_template" ]
