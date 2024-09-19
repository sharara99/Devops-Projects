import os
from flask import Flask, render_template

app = Flask(__name__)

color = "blue"

@app.route("/")
def main():
    print(color)
    return render_template('hello.html', color=color)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=6060)
