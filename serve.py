#!/usr/bin/env python3
from http.server import *

class Handler(SimpleHTTPRequestHandler):
    def guess_type(self, path):
        guess = SimpleHTTPRequestHandler.guess_type(self, path)
        if guess == 'text/html':
            return 'text/html; charset=utf-8'
        else:
            return guess

httpd = HTTPServer(('', 8000), Handler)
httpd.serve_forever()
