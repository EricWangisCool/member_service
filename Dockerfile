# 使用官方輕量級 Python 映像檔
FROM python:3.10-slim

# 設定工作目錄
WORKDIR /app

# 設定環境變數，防止 Python 產生 pyc 檔案，並讓 log 即時輸出
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 複製 requirements.txt 並安裝相依套件
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# 複製專案所有檔案到工作目錄
COPY . /app/

# 暴露 Port 5001 (與 app.py 設定相同)
EXPOSE 5001

# 使用 gunicorn 啟動 Flask 應用程式，並綁定到 0.0.0.0:5001
# 注意：這能確保在容器化環境中對外提供服務
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "--access-logfile", "-", "--error-logfile", "-", "app:app"]
