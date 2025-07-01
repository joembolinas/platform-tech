# FinMark Corporation: OSPF Configuration Templates

## 🔧 Cisco Packet Tracer OSPF Implementation

**Document Type:** Configuration Templates & Lab Guide  
**Project:** FinMark Corporation - OSPF Network Enhancement  
**Target Platform:** Cisco Packet Tracer Simulation  
**Document Version:** 1.0

---

## 🎯 Configuration Overview

This document provides step-by-step OSPF configuration templates for implementing dynamic routing in the FinMark Corporation network simulation. These configurations transform the existing static routing infrastructure into a resilient, self-healing OSPF network.

### **Implementation Strategy**
- **Parallel Deployment**: OSPF configured alongside existing static routes
- **Gradual Migration**: Phase-out static routes after OSPF validation
- **Zero Downtime**: Seamless transition with fallback procedures
- **Enhanced Monitoring**: Built-in verification and troubleshooting

---

## 🏗️ OSPF Network Topology

### **Area Design Summary**
```
OSPF Areas and Router Assignments:

Area 0 (Backbone) - 10.0.0.0/16
├── Core-Router-1 (1.1.1.1) - Primary ABR
├── Core-Router-2 (2.2.2.2) - Backup ABR
└── Inter-area Links

Area 1 (DMZ) - 10.1.0.0/16
├── DMZ-Router (3.3.3.3)
├── Web-Server-1 (10.1.50.10)
├── Web-Server-2 (10.1.50.11)
└── Load-Balancer (10.1.50.20)

Area 2 (Internal) - 10.2.0.0/16
├── Internal-Router (4.4.4.4)
├── Finance-VLAN (10.2.10.0/24)
├── HR-VLAN (10.2.20.0/24)
├── Operations-VLAN (10.2.30.0/24)
└── IT-VLAN (10.2.40.0/24)

Area 3 (Security) - 10.3.0.0/16
├── Security-Router (5.5.5.5)
├── Firewall-Primary (10.3.10.1)
├── IDS-IPS-System (10.3.20.1)
└── VPN-Gateway (10.3.30.1)
```

---

## ⚙️ Router Configuration Templates

### **1. Core Router 1 - Primary Backbone (FinMark-Core-Router-1)**

```cisco
!==================================================
! FinMark Core Router 1 - OSPF Primary ABR
! Router ID: 1.1.1.1
! Areas: 0 (Backbone)
!==================================================

! Basic Configuration
enable
configure terminal
hostname FinMark-Core-Router-1

! OSPF Process Configuration
router ospf 1
 router-id 1.1.1.1
 log-adjacency-changes detail
 passive-interface default
 no passive-interface GigabitEthernet0/1
 no passive-interface GigabitEthernet0/2
 no passive-interface GigabitEthernet1/0
 no passive-interface GigabitEthernet1/1

! Area 0 Networks (Backbone)
 network 10.0.0.0 0.0.0.255 area 0
 network 10.0.1.0 0.0.0.3 area 0
 network 10.0.2.0 0.0.0.3 area 0
 network 10.0.3.0 0.0.0.3 area 0

! Area Authentication
 area 0 authentication message-digest

! Default Route Origination
 default-information originate always

! Interface Configuration
! WAN Interface (Internet)
interface GigabitEthernet0/0
 description WAN Connection to Internet
 ip address dhcp
 no shutdown

! Backbone Link to Core Router 2
interface GigabitEthernet0/1
 description Backbone Link to Core-Router-2
 ip address 10.0.0.1 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 10
 ip ospf hello-interval 5
 ip ospf dead-interval 20
 no shutdown

! Link to DMZ Router (ABR to Area 1)
interface GigabitEthernet0/2
 description ABR Link to DMZ-Router (Area 1)
 ip address 10.0.1.1 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 100
 no shutdown

! Link to Internal Router (ABR to Area 2)
interface GigabitEthernet1/0
 description ABR Link to Internal-Router (Area 2)
 ip address 10.0.2.1 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 50
 no shutdown

! Link to Security Router (ABR to Area 3)
interface GigabitEthernet1/1
 description ABR Link to Security-Router (Area 3)
 ip address 10.0.3.1 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 75
 no shutdown

! Access Control Lists (Maintain existing security)
access-list 100 permit ospf any any
access-list 100 permit tcp 10.0.0.0 0.255.255.255 any eq 80
access-list 100 permit tcp 10.0.0.0 0.255.255.255 any eq 443
access-list 100 permit tcp 10.2.10.0 0.0.0.255 10.2.40.0 0.0.0.255 eq 1433
access-list 100 deny tcp any any eq 1433
access-list 100 permit udp any any eq 53
access-list 100 permit udp any any eq 123
access-list 100 permit icmp 10.0.0.0 0.255.255.255 any
access-list 100 deny icmp any any

! Apply ACL to WAN interface
interface GigabitEthernet0/0
 ip access-group 100 in

! Logging and Monitoring
logging buffered 16384
logging console warnings
logging 10.3.40.1

! Save Configuration
exit
copy running-config startup-config
```

### **2. Core Router 2 - Backup Backbone (FinMark-Core-Router-2)**

```cisco
!==================================================
! FinMark Core Router 2 - OSPF Backup ABR
! Router ID: 2.2.2.2
! Areas: 0 (Backbone)
!==================================================

enable
configure terminal
hostname FinMark-Core-Router-2

! OSPF Process Configuration
router ospf 1
 router-id 2.2.2.2
 log-adjacency-changes detail
 passive-interface default
 no passive-interface GigabitEthernet0/1
 no passive-interface GigabitEthernet0/2
 no passive-interface GigabitEthernet1/0

! Area 0 Networks (Backbone)
 network 10.0.0.0 0.0.0.255 area 0

! Area Authentication
 area 0 authentication message-digest

! Default Route Origination (Lower priority)
 default-information originate metric 50

! Interface Configuration
! Secondary WAN Interface
interface GigabitEthernet0/0
 description Secondary WAN Connection
 ip address dhcp
 no shutdown

! Backbone Link to Core Router 1
interface GigabitEthernet0/1
 description Backbone Link to Core-Router-1
 ip address 10.0.0.2 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 10
 ip ospf hello-interval 5
 ip ospf dead-interval 20
 no shutdown

! Backup Link to DMZ Router (Higher cost)
interface GigabitEthernet0/2
 description Backup Link to DMZ-Router
 ip address 10.0.1.5 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 200
 no shutdown

! Backup Link to Internal Router (Higher cost)
interface GigabitEthernet1/0
 description Backup Link to Internal-Router
 ip address 10.0.2.5 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 150
 no shutdown

! Logging
logging buffered 16384
logging 10.3.40.1

exit
copy running-config startup-config
```

### **3. DMZ Router - Area 1 (FinMark-DMZ-Router)**

```cisco
!==================================================
! FinMark DMZ Router - OSPF Area 1
! Router ID: 3.3.3.3
! Areas: 1 (DMZ Area)
!==================================================

enable
configure terminal
hostname FinMark-DMZ-Router

! OSPF Process Configuration
router ospf 1
 router-id 3.3.3.3
 log-adjacency-changes detail
 passive-interface default
 no passive-interface GigabitEthernet0/0
 no passive-interface GigabitEthernet0/2

! Area 1 Networks (DMZ)
 network 10.1.0.0 0.0.255.255 area 1
 network 10.0.1.0 0.0.0.3 area 0

! Area Configuration (Stub area for security)
 area 1 authentication message-digest
 area 1 stub

! Interface Configuration
! Link to Core Router 1 (Backbone connection)
interface GigabitEthernet0/0
 description Link to Core-Router-1 (Backbone)
 ip address 10.0.1.2 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 no shutdown

! DMZ Management Interface
interface GigabitEthernet0/1
 description DMZ Management Network
 ip address 10.1.0.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 no shutdown

! DMZ Services Network (Web Servers)
interface GigabitEthernet0/2
 description DMZ Services - Web Servers
 ip address 10.1.50.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 no shutdown

! Backup Link to Core Router 2
interface GigabitEthernet1/0
 description Backup Link to Core-Router-2
 ip address 10.0.1.6 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 200
 no shutdown

! DMZ-specific Access Control Lists
access-list 110 permit ospf any any
access-list 110 permit tcp any host 10.1.50.10 eq 80
access-list 110 permit tcp any host 10.1.50.10 eq 443
access-list 110 permit tcp any host 10.1.50.11 eq 80
access-list 110 permit tcp any host 10.1.50.11 eq 443
access-list 110 permit tcp any host 10.1.50.20 eq 80
access-list 110 deny tcp any 10.1.0.0 0.0.255.255
access-list 110 permit icmp any any

! Apply ACL
interface GigabitEthernet0/0
 ip access-group 110 in

exit
copy running-config startup-config
```

### **4. Internal Router - Area 2 (FinMark-Internal-Router)**

```cisco
!==================================================
! FinMark Internal Router - OSPF Area 2
! Router ID: 4.4.4.4
! Areas: 2 (Internal VLANs)
!==================================================

enable
configure terminal
hostname FinMark-Internal-Router

! VLAN Configuration
vlan 10
 name Finance-Department
vlan 20
 name HR-Department
vlan 30
 name Operations-Department
vlan 40
 name IT-Department

! OSPF Process Configuration
router ospf 1
 router-id 4.4.4.4
 log-adjacency-changes detail
 passive-interface default
 no passive-interface GigabitEthernet0/0
 no passive-interface GigabitEthernet1/0

! Area 2 Networks (Internal VLANs)
 network 10.2.0.0 0.0.255.255 area 2
 network 10.0.2.0 0.0.0.3 area 0

! Area Configuration
 area 2 authentication message-digest

! Interface Configuration
! Link to Core Router 1 (Backbone connection)
interface GigabitEthernet0/0
 description Link to Core-Router-1 (Backbone)
 ip address 10.0.2.2 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 no shutdown

! Backup Link to Core Router 2
interface GigabitEthernet1/0
 description Backup Link to Core-Router-2
 ip address 10.0.2.6 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 ip ospf cost 150
 no shutdown

! VLAN Interfaces
interface Vlan10
 description Finance Department
 ip address 10.2.10.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network broadcast
 no shutdown

interface Vlan20
 description HR Department
 ip address 10.2.20.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network broadcast
 no shutdown

interface Vlan30
 description Operations Department
 ip address 10.2.30.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network broadcast
 no shutdown

interface Vlan40
 description IT Department
 ip address 10.2.40.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network broadcast
 no shutdown

! Inter-VLAN Access Control
access-list 120 permit ospf any any
access-list 120 permit tcp 10.2.10.0 0.0.0.255 10.2.40.0 0.0.0.255 eq 1433
access-list 120 permit tcp 10.2.20.0 0.0.0.255 10.2.40.0 0.0.0.255 eq 1433
access-list 120 permit tcp 10.2.30.0 0.0.0.255 10.2.40.0 0.0.0.255 eq 1433
access-list 120 permit tcp 10.2.0.0 0.0.255.255 any eq 80
access-list 120 permit tcp 10.2.0.0 0.0.255.255 any eq 443
access-list 120 permit udp any any eq 53
access-list 120 permit icmp 10.2.0.0 0.0.255.255 any
access-list 120 deny ip any any

exit
copy running-config startup-config
```

### **5. Security Router - Area 3 (FinMark-Security-Router)**

```cisco
!==================================================
! FinMark Security Router - OSPF Area 3
! Router ID: 5.5.5.5
! Areas: 3 (Security Infrastructure)
!==================================================

enable
configure terminal
hostname FinMark-Security-Router

! OSPF Process Configuration
router ospf 1
 router-id 5.5.5.5
 log-adjacency-changes detail
 passive-interface default
 no passive-interface GigabitEthernet0/0

! Area 3 Networks (Security Infrastructure)
 network 10.3.0.0 0.0.255.255 area 3
 network 10.0.3.0 0.0.0.3 area 0

! Area Configuration
 area 3 authentication message-digest

! Interface Configuration
! Link to Core Router 1 (Backbone connection)
interface GigabitEthernet0/0
 description Link to Core-Router-1 (Backbone)
 ip address 10.0.3.2 255.255.255.252
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 ip ospf network point-to-point
 no shutdown

! Security Management Network
interface GigabitEthernet0/1
 description Security Management Network
 ip address 10.3.0.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 no shutdown

! Firewall Network
interface GigabitEthernet0/2
 description Firewall Infrastructure
 ip address 10.3.10.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 no shutdown

! IDS/IPS Network
interface GigabitEthernet1/0
 description IDS-IPS Systems
 ip address 10.3.20.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 no shutdown

! VPN Gateway Network
interface GigabitEthernet1/1
 description VPN Gateway
 ip address 10.3.30.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 no shutdown

! SIEM/Monitoring Network
interface GigabitEthernet2/0
 description SIEM and Monitoring
 ip address 10.3.40.1 255.255.255.0
 ip ospf message-digest-key 1 md5 FinMark2025OSPF
 no shutdown

exit
copy running-config startup-config
```

---

## 🧪 Configuration Verification Commands

### **OSPF Status Verification**
```cisco
! Check OSPF Process Status
show ip ospf

! Verify OSPF Neighbors
show ip ospf neighbor detail

! Check OSPF Database
show ip ospf database

! Verify OSPF Routes
show ip route ospf

! Check Interface OSPF Status
show ip ospf interface brief

! Verify Area Information
show ip ospf border-routers
```

### **Connectivity Testing**
```cisco
! Test Inter-Area Connectivity
ping 10.1.50.10 source 10.2.10.1
ping 10.2.20.5 source 10.1.50.1
ping 10.3.10.1 source 10.2.40.1

! Trace OSPF Paths
traceroute 10.1.50.10 source 10.2.10.1
traceroute 10.3.40.1 source 10.1.50.1
```

### **Failover Testing**
```cisco
! Test Primary Link Failure
interface gigabitethernet0/1
shutdown

! Verify Backup Path Activation
show ip route ospf
show ip ospf neighbor

! Restore Primary Link
interface gigabitethernet0/1
no shutdown

! Verify Path Restoration
show ip ospf neighbor detail
```

---

## 📊 Performance Monitoring

### **OSPF Metrics to Monitor**
```cisco
! Convergence Time Measurement
debug ip ospf events
debug ip ospf spf

! Neighbor State Changes
debug ip ospf adj

! LSA Propagation
debug ip ospf lsa-generation
debug ip ospf flood

! Interface Utilization
show interfaces summary
show ip ospf statistics
```

### **Health Check Script**
```cisco
! Daily OSPF Health Check
show ip ospf neighbor | include Full
show ip ospf database | include Age
show ip route summary
show ip ospf interface brief | include UP
```

---

## 🔧 Troubleshooting Guide

### **Common OSPF Issues**

#### **1. Neighbor Adjacency Problems**
```cisco
! Check for common issues
show ip ospf neighbor detail
show ip ospf interface

! Common solutions
- Verify IP connectivity
- Check OSPF timers (hello/dead)
- Verify area configuration
- Check authentication keys
```

#### **2. Routing Table Issues**
```cisco
! Diagnose routing problems
show ip route ospf
show ip ospf database
show ip ospf border-routers

! Common solutions
- Verify network statements
- Check area configurations
- Verify ABR connectivity
```

#### **3. Performance Issues**
```cisco
! Check OSPF performance
show ip ospf statistics
show ip ospf spf-log
show processes cpu | include OSPF

! Optimization techniques
- Adjust OSPF timers
- Implement area summarization
- Use stub areas where appropriate
```

---

## 📋 Implementation Checklist

### **Pre-Implementation**
- [ ] Backup all current router configurations
- [ ] Document existing static routes
- [ ] Verify physical connectivity for new links
- [ ] Prepare rollback procedures

### **Configuration Phase**
- [ ] Configure OSPF on Core Router 1
- [ ] Configure OSPF on Core Router 2
- [ ] Configure DMZ Router (Area 1)
- [ ] Configure Internal Router (Area 2)
- [ ] Configure Security Router (Area 3)
- [ ] Verify all neighbor adjacencies

### **Testing Phase**
- [ ] Test connectivity between all areas
- [ ] Verify failover scenarios
- [ ] Measure convergence times
- [ ] Validate routing table entries
- [ ] Test application performance

### **Migration Phase**
- [ ] Gradually remove static routes
- [ ] Monitor for routing loops
- [ ] Verify traffic flows
- [ ] Update monitoring systems
- [ ] Document final configuration

---

## 🎯 Expected Results

### **Performance Targets**
- **Convergence Time**: < 1 second for local failures
- **Neighbor Adjacency**: All neighbors in FULL state
- **Route Propagation**: Complete LSA database within 10 seconds
- **Application Performance**: No degradation in response times

### **Reliability Improvements**
- **Automatic Failover**: Sub-second recovery from link failures
- **Load Distribution**: Equal-cost multi-path routing
- **Network Resilience**: Multiple redundant paths
- **Scalability**: Easy addition of new areas and routers

This OSPF implementation transforms the FinMark network from a static, single-point-of-failure architecture to a dynamic, self-healing infrastructure capable of supporting the organization's growth and reliability requirements.