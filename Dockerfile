# ---- Estágio de Build ----
FROM python:3.11-slim as builder

WORKDIR /app

# Instalar dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar a aplicação
COPY main.py .

# ---- Estágio Final ----
FROM python:3.11-slim

WORKDIR /app

# Copiar dependências instaladas do estágio de build
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /app /app

# Expor a porta e definir o comando de execução
EXPOSE 80
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]