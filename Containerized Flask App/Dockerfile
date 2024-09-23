FROM python:3.9-slim

RUN pip install flask flask-mysql

COPY . .

EXPOSE 6060

CMD ["flask", "run", "--host=0.0.0.0", "--port=6060"]