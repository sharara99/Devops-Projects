from flask import Flask, jsonify
import prometheus_client

app = Flask(__name__)

# Example Prometheus metrics
temperature_gauge = prometheus_client.Gauge('temperature', 'Current temperature')

@app.route('/metrics')
def metrics():
    # Add example metric data
    temperature_gauge.set(25)  # Replace with real data
    return prometheus_client.generate_latest().decode('utf-8'), 200, {'Content-Type': prometheus_client.CONTENT_TYPE_LATEST}

@app.route('/temperature')
def temperature():
    # Placeholder for temperature logic
    avg_temp = 25  # Replace with real data
    status = "Good" if 11 <= avg_temp <= 36 else "Too Hot" if avg_temp > 37 else "Too Cold"
    return jsonify({"temperature": avg_temp, "status": status})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
