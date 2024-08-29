import unittest
import requests

class TestAPI(unittest.TestCase):
    def test_metrics(self):
        response = requests.get("http://localhost:5000/metrics")
        self.assertEqual(response.status_code, 200)

    def test_temperature(self):
        response = requests.get("http://localhost:5000/temperature")
        self.assertEqual(response.status_code, 200)
        self.assertIn("temperature", response.json())

if __name__ == '__main__':
    unittest.main()
