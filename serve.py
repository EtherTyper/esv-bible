#!/usr/bin/env python3
import tarfile
from urllib.parse import unquote_plus
from http import HTTPStatus
from http.server import HTTPServer, SimpleHTTPRequestHandler

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        self.tarball = tarfile.open('./esv-bible.tar.gz')
        super().__init__(*args, **kwargs)

    def do_GET(self):
        path = unquote_plus(self.path[1:])

        try:
            if path[-1] == '/':
                content = 'Directory listing'
            else:
                content = self.tarball.extractfile(path).read().decode("utf-8")

            self.send_response(HTTPStatus.OK)
        except KeyError:
            content = "Invalid path."

            self.send_response(HTTPStatus.NOT_FOUND)

        self.send_header("Content-type", 'text/html; charset=utf-8')
        self.end_headers()
        self.wfile.write(bytes(content, "utf-8"))

httpd = HTTPServer(('', 8000), Handler)
httpd.serve_forever()
