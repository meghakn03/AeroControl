#!/usr/bin/env python3
"""Exercise the deployed browser transport, including acknowledged commands."""
import argparse
import struct
import time
import urllib.request


def rpc(base, method, payload=b''):
    frame = b'\0' + struct.pack('>I', len(payload)) + payload
    request = urllib.request.Request(
        f'{base.rstrip("/")}/aerocontrol.v1.GroundControl/{method}',
        data=frame, headers={'Content-Type': 'application/grpc-web+proto', 'X-Grpc-Web': '1'})
    with urllib.request.urlopen(request, timeout=5) as response:
        data = response.read()
    messages = []
    trailers = b''
    while data:
        if len(data) < 5:
            raise RuntimeError('Truncated gRPC-Web frame')
        flag, size = data[0], struct.unpack('>I', data[1:5])[0]
        payload, data = data[5:5 + size], data[5 + size:]
        if len(payload) != size:
            raise RuntimeError('Truncated gRPC-Web payload')
        if flag & 128:
            trailers += payload
        else:
            messages.append(payload)
    if b'grpc-status:0' not in trailers.replace(b' ', b''):
        raise RuntimeError(f'gRPC failure: {trailers!r}')
    return messages


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--url', default='http://localhost:8088')
    args = parser.parse_args()
    assert rpc(args.url, 'GetSnapshot'), 'Missing snapshot'
    for command in [0, 2, 3, 5]:  # arm, mission, hold, land
        reply = rpc(args.url, 'ExecuteCommand', b'\x08' + bytes([command]))
        assert reply and reply[0].startswith(b'\x08\x01'), f'Command {command} rejected: {reply!r}'
        time.sleep(0.4)
    assert rpc(args.url, 'GetEvents'), 'Missing event log'
    print('PASS: gRPC-Web snapshot, arm, mission, hold, land, events')


if __name__ == '__main__':
    main()
