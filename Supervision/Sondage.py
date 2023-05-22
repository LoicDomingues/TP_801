#TODO Verify when lxc scripts are finished
#!/usr/bin/env python3

import psutil
import socket
import requests
import time

# Interval between probes (in seconds)
INTERVAL = 60

# C1 IP address and port
C1_IP = "10.0.0.1"
C1_PORT = 5000

def probe():
    while True:
        # Collect information
        uptime = int(time.time() - psutil.boot_time())
        mem = psutil.virtual_memory()
        cpu = psutil.cpu_percent(interval=1, percpu=True)
        disk_usage = {}
        for part in psutil.disk_partitions():
            disk_usage[part.mountpoint] = psutil.disk_usage(part.mountpoint)

        top_cpu = [p.info for p in psutil.process_iter(['pid', 'name', 'cpu_percent']) if p.cpu_percent() > 0]
        top_cpu = sorted(top_cpu, key=lambda p: p['cpu_percent'], reverse=True)[:3]

        top_mem = [p.info for p in psutil.process_iter(['pid', 'name', 'memory_percent']) if p.memory_percent() > 0]
        top_mem = sorted(top_mem, key=lambda p: p['memory_percent'], reverse=True)[:3]

        # Send information to C1
        data = {
            'hostname': socket.gethostname(),
            'uptime': uptime,
            'mem': mem._asdict(),
            'cpu': cpu,
            'disk_usage': disk_usage,
            'top_cpu': top_cpu,
            'top_mem': top_mem
        }
        response = requests.post(f"http://{C1_IP}:{C1_PORT}/probe", json=data)
        if response.status_code != 200:
            print(f"Failed to send probe data: {response.content}")
        
        time.sleep(INTERVAL)

if __name__ == '__main__':
    probe()