#!/usr/bin/env python

import redis
import websocket
import json
import sys
import time

ip=sys.argv[1]

ws_arg=sys.argv[2]

r = redis.StrictRedis(host=ip, port=6379, db=0)

print "try connect redis ( %s )" % ip

count = 0

print "try websocket %s connect " % ws_arg

ws = websocket.create_connection(ws_arg)

print "connected to websocket %s" % ws_arg

try:
    print "proxy running"

    while(count < 1):
        print "try recive"
        result =  ws.recv()
        print "received %s " % result
        try:
            result_decode = json.loads(result)
            r.set(result_decode['c'],result_decode['v'])
        except ValueError:
            print "ValueError"
        time.sleep(50.0 / 1000.0)

except KeyboardInterrupt:
    ws.close()
finally:
    print "proxy close"

