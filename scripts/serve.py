#!/usr/bin/env python3
"""Serve a release Flutter build and proxy gRPC-Web to the local Rust service."""
import functools
import http.client
import http.server
import pathlib
import os

ROOT = pathlib.Path(__file__).resolve().parents[1] / 'frontend' / 'build' / 'web'


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        if not self.path.startswith('/aerocontrol.v1.GroundControl/'):
            self.send_error(404)
            return
        upstream = http.client.HTTPConnection('127.0.0.1', 50051, timeout=10)
        try:
            body = self.rfile.read(int(self.headers.get('Content-Length', '0')))
            headers = {key: value for key, value in self.headers.items()
                       if key.lower() not in ('host', 'connection', 'transfer-encoding')}
            upstream.request('POST', self.path, body=body, headers=headers)
            response = upstream.getresponse()
            self.send_response(response.status)
            for key, value in response.getheaders():
                if key.lower() not in ('connection', 'transfer-encoding', 'content-length'):
                    self.send_header(key, value)
            self.send_header('Connection', 'close')
            self.end_headers()
            while True:
                chunk = response.read1(65536)
                if not chunk:
                    break
                self.wfile.write(chunk)
                self.wfile.flush()
        except (BrokenPipeError, ConnectionResetError):
            pass
        except OSError as error:
            self.log_error('Backend unavailable: %s', error)
        finally:
            upstream.close()
            self.close_connection = True


if __name__ == '__main__':
    if not (ROOT / 'index.html').exists():
        raise SystemExit('Build first: cd frontend && flutter build web --dart-define=API_URL=/')
    port = int(os.environ.get('AEROCONTROL_WEB_PORT', '8088'))
    print(f'AeroControl: http://localhost:{port} (backend: localhost:50051)', flush=True)
    http.server.ThreadingHTTPServer(('127.0.0.1', port), functools.partial(Handler, directory=str(ROOT))).serve_forever()
