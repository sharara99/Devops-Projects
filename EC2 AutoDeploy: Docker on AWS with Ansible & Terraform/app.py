import http.server
import socketserver
import requests

def get_instance_id():
    try:
        # Step 1: Get the session token
        token_url = "http://169.254.169.254/latest/api/token"
        token_headers = {"X-aws-ec2-metadata-token-ttl-seconds": "21600"}
        token_response = requests.put(token_url, headers=token_headers, timeout=2)
        token = token_response.text

        # Step 2: Use the token to get the instance ID
        instance_id_url = "http://169.254.169.254/latest/meta-data/instance-id"
        instance_id_headers = {"X-aws-ec2-metadata-token": token}
        instance_id_response = requests.get(instance_id_url, headers=instance_id_headers, timeout=2)
        return instance_id_response.text
    except requests.RequestException as e:
        return f"Unable to retrieve instance ID: {str(e)}"

class MyHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header("Content-type", "text/html")
            self.end_headers()
            instance_id = get_instance_id()
            self.wfile.write(
                f"""
                <html>
                <head>
                    <title>Welcome to EC2 AutoDeploy!</title>
                    <style>
                        body {{
                            font-family: Arial, sans-serif;
                            background-color: #e7f3fe;
                            margin: 0;
                            padding: 20px;
                            text-align: center;
                        }}
                        h1 {{
                            color: #2c3e50;
                        }}
                        p {{
                            font-size: 18px;
                            line-height: 1.6;
                            color: #34495e;
                        }}
                        .container {{
                            background-color: #fff;
                            padding: 30px;
                            border-radius: 10px;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                            display: inline-block;
                            margin-top: 30px;
                            max-width: 600px;
                        }}
                        .footer {{
                            margin-top: 20px;
                            font-size: 14px;
                            color: #7f8c8d;
                        }}
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h1>Welcome to EC2 AutoDeploy!</h1>
                        <p>Hi, I'm <strong>Mahmoud Sharara</strong>, and this is my automated application deployment solution hosted on AWS!</p>
                        <p>This web application is part of my project that efficiently provisions an <strong>AWS EC2 instance</strong> and deploys a <strong>Dockerized application</strong>.</p>
                        <p>By leveraging <strong>Terraform</strong>, I manage infrastructure as code, creating cloud resources with ease and repeatability.</p>
                        <p>Using <strong>Ansible</strong>, I automate the installation of Docker, build the application image from a specified Dockerfile, and run the container on the EC2 instance.</p>
                        <p>This setup ensures a scalable and reproducible environment for deploying applications, ideal for developers and DevOps engineers!</p>
                        <p>Current EC2 Instance ID: <strong>{instance_id}</strong></p>
                    </div>
                    <div class="footer">
                        <p>Thank you for visiting!</p>
                    </div>
                </body>
                </html>
                """.encode()
            )
        else:
            super().do_GET()

if __name__ == "__main__":
    PORT = 5000
    with socketserver.TCPServer(("", PORT), MyHandler) as httpd:
        print(f"Server running on port {PORT}")
        httpd.serve_forever()
