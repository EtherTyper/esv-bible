#!/usr/bin/env python3
from http import server

class UnicodeHTTPRequestHandler(server.SimpleHTTPRequestHandler):
    def guess_type(self, path):
        guess = server.SimpleHTTPRequestHandler.guess_type(self, path)
        if guess == 'text/html':
            return 'text/html; charset=utf-8'
        else:
            return guess

httpd = server.HTTPServer(('', 8000), UnicodeHTTPRequestHandler)
httpd.serve_forever()
