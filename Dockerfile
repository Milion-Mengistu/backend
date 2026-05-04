FROM node:20-bookworm-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_LINK_MODE=copy

WORKDIR /opt/render/project/src

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        make \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/python3 /usr/local/bin/python \
    && python --version \
    && npm --version \
    && pip3 install --no-cache-dir uv

COPY package.json package-lock.json pyproject.toml uv.lock Makefile README.md ./
COPY analytics ./analytics
COPY tools ./tools
COPY tests ./tests

RUN make render-build

ENV APP_ENV=production \
    HOST=0.0.0.0 \
    PORT=10000

CMD ["make", "render-start"]
