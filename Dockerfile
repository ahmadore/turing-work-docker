FROM python:3.13

WORKDIR /app/src

COPY . /app/src

RUN export AIOHTTP_NO_EXTENSIONS=1

RUN apt-get update && apt-get install -y  \
    build-essential gcc git \
    libffi-dev python3-dev && rm -rf /var/lib/apt/lists/*
    
RUN pip install --no-cache-dir pip-tool
RUN git submodule update --init
RUN pip install -r test-requirements.txt
RUN pip install --upgrade pip setuptools wheel Cython aiohttp
RUN pip install --upgrade pytest pytest-cov
RUN pip install --no-cache-dir -e .

CMD ["python", "-m", "pytest", "-v", "-rA"]
