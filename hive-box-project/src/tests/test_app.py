import unittest
from app import app

class FlaskTestCase(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_version(self):
        result = self.app.get('/version')
        self.assertEqual(result.status_code, 200)
        self.assertIn(b'version', result.data)

    def test_temperature(self):
        result = self.app.get('/temperature')
        self.assertEqual(result.status_code, 200)
        self.assertIn(b'average_temperature', result.data)

if __name__ == '__main__':
    unittest.main()
