# Network Server Monitoring Script

A bash script to check the status of all servers in the `172.16.17.x` subnet (where x = 0-255).

---

## **Features**
- Checks reachability of all 256 IP addresses in the `172.16.17.0/24` subnet
- Clear status messages for each server
- Fast execution with single-packet pings
- Simple color-free output for easy logging

---

## **Requirements**
- Bash shell
- ping utility
- Proper network permissions

---

## **Installation & Usage**

1. Save the script as `network_check.sh`:
```bash
#!/bin/bash

# Ping sweep for 172.16.17.x subnet
for x in {0..255}; do
    ip="172.16.17.$x"
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
        echo "Server $ip is up and running"
    else
        echo "Server $ip is unreachable"
    fi
done
```

2. Make executable:
```bash
chmod +x network_check.sh
```

3. Run the script:
```bash
./network_check.sh
```

---

## **Sample Output**
```
Server 172.16.17.1 is up and running
Server 172.16.17.2 is unreachable
Server 172.16.17.3 is up and running
...
```

---

## **Customization Options**

1. **Adjust Ping Timeout** (seconds):
```bash
-W 2  # Change from 1 second to 2
```

2. **Increase Ping Attempts**:
```bash
-c 2  # Send 2 packets instead of 1
```

3. **Scan Specific Range**:
```bash
{50..100}  # Only check x values from 50 to 100
```

---

## **Troubleshooting**

1. **No Output**:
   - Verify script has execute permissions
   - Check if `ping` command is available

2. **All Hosts Unreachable**:
   - Confirm network connectivity
   - Check firewall settings (ICMP may be blocked)

3. **Partial Results**:
   - Try increasing timeout value
   - Consider physical network topology

---

## **Important Notes**
- Some servers may block ICMP requests
- IP addresses `.0` and `.255` are valid checks in this implementation
- Script runtime is ~4-5 minutes (1 second per IP)
- For enterprise networks, consider specialized tools like `nmap`

---

## **Security Considerations**
- Requires no special privileges
- Generates minimal network traffic
- Avoid running in continuous loops

---

**Note**: For production environments, consider adding logging and alerting features.