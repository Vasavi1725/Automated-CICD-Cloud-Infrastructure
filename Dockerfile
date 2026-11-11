FROM python:3.12-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.12-slim
WORKDIR /app
RUN useradd --create-home appuser
COPY --from=builder /install /usr/local
COPY app.py .
ENV APP_VERSION=container-demo
EXPOSE 5000
USER appuser
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
