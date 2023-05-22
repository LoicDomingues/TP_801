#TODO Verify when lxc scripts are finished
#!/usr/bin/env python

import json
import os
import shutil
import socket
from datetime import datetime
from flask import Flask, render_template, request

# Interval between probes (in seconds)
INTERVAL = 60

# Directory to store probe data
DATA_DIR = "/var/probe_data"

# Directory to store HTML files
HTML_DIR = "/var/www/html"

app = Flask(__name__)

@app.route('/')
def index():
    # List of hosts with probe data
    hosts = os.listdir(DATA_DIR)
    probes = []
    for host in hosts:
        # Load probe data
        with open(os.path.join(DATA_DIR, host)) as f:
            data = json.load(f)
        data['hostname'] = host
        data['timestamp'] = datetime.fromtimestamp(data['timestamp']).strftime("%Y-%m-%d %H:%M:%S")
        probes.append(data)
    # Render index template
    return render_template('index.html', probes=probes)

@app.route('/<hostname>')
def detail(hostname):
    # Load probe data
    with open(os.path.join(DATA_DIR, hostname)) as f:
        data = json.load(f)
    data['hostname'] = hostname
    data['timestamp'] = datetime.fromtimestamp(data['timestamp']).strftime("%Y-%m-%d %H:%M:%S")
    # Render detail template
    return render_template('detail.html', data=data)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
