ARG PYTHON_VERSION=3.9.2
FROM python:$PYTHON_VERSION-slim-buster
ARG TARGETPLATFORM
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_VERSION=15.x
ARG CIRCLECI_VERSION=v0.1.15195
ARG POETRY_VERSION=1.1.5
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        bash-completion \
        build-essential \
        ca-certificates \
        curl \
        git \
        gnupg2 \
        libicu63 \
        lsb-release \
        software-properties-common \
        vim \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=${TARGETPLATFORM#"linux/"}] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | \
        tee /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
    && apt-add-repository https://cli.github.com/packages \
    && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce-cli gh nodejs \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/${CIRCLECI_VERSION}/install.sh | bash \
    && curl -sSL https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/local/bin/cc-test-reporter \
    && chmod +x /usr/local/bin/cc-test-reporter \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/${POETRY_VERSION}/get-poetry.py | python
ENV PATH="/root/.poetry/bin:${PATH}"
WORKDIR /code
