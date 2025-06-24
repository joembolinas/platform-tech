# Project Bedrock - Module 2 Network Traffic Simulation

## Overview
This simulation demonstrates the high-availability and performance infrastructure proposed in Module 2 of Project Bedrock for FinMark Corporation.

## Simulation Components

### 1. Load Balancer (HAProxy)
- Distributes traffic across multiple web servers
- Health checks and failover capabilities
- Round-robin and least-connections algorithms

### 2. Quality of Service (QoS)
- Traffic prioritization for critical services
- Bandwidth limiting for non-essential traffic
- Real-time monitoring and adjustment

### 3. Performance Monitoring
- Real-time latency and throughput measurement
- SIEM monitoring simulation
- Dashboard load time optimization

## Tools Used
- **HAProxy**: Load balancing
- **iperf3**: Traffic generation and testing
- **tc (Traffic Control)**: QoS implementation
- **Wireshark**: Packet analysis
- **iftop/nload**: Bandwidth monitoring
- **Apache/Nginx**: Backend servers

## Simulation Scenarios
1. **Flash Sale Traffic Surge**: Simulate 3,000 concurrent users
2. **Server Failover**: Test high-availability during server failure
3. **QoS Priority**: Demonstrate critical traffic prioritization
4. **Performance Validation**: Achieve sub-3-second response times

## Expected Outcomes
- Dashboard load time: 20s → <3s
- System uptime: 99.9%+
- Successful handling of 3,000+ concurrent users
- Automatic failover in <5 seconds

# Project Bedrock - Module 2 Network Simulation

This directory contains comprehensive simulation tools for validating the **Module 2: High-Availability & Performance** infrastructure improvements proposed for FinMark Corporation.

## Overview

The simulation environment demonstrates how the proposed infrastructure addresses FinMark's critical business requirements:
- **Scalability**: Support for 3,000+ concurrent users
- **Performance**: Sub-3-second response times
- **Security**: SIEM integration and real-time monitoring
- **Stability**: 99.9% uptime with automatic failover

## Simulation Components

### 1. Core Configuration Files

**`haproxy.cfg`**
- Production-ready HAProxy configuration
- Load balancing across multiple servers (192.168.1.100-102)
- Health checks and automatic failover
- QoS policies for different traffic types
- Statistics dashboard on port 8404

### 2. Traffic Simulation Scripts

**`traffic-simulation.sh`**
- Comprehensive traffic testing using Apache Bench (ab)
- Simulates baseline, flash sale, and QoS scenarios
- Tests load balancing distribution
- Monitors network interfaces with iftop
- Applies traffic control (tc) for QoS demonstration
- Generates detailed performance reports

**`performance-monitor.sh`** ⭐ NEW
- Real-time system and network performance monitoring
- SIEM monitoring simulation with security alerts
- Tests FinMark service endpoints for compliance
- Monitors CPU, memory, latency, and network statistics
- Generates comprehensive performance reports
- Validates against FinMark's 3-second response requirement

**`module2-validation.sh`** ⭐ NEW
- Complete validation test suite for Module 2
- Infrastructure readiness testing
- Load balancing and high-availability validation
- Performance and scalability testing under various loads
- Security and monitoring capability testing
- Failover and recovery scenario testing
- Generates comprehensive compliance reports

### 3. Packet Analysis Tools

**`wireshark-analysis.sh`**
- Automated packet capture using tcpdump/tshark
- Custom Wireshark filters for FinMark traffic analysis
- Traffic generation for analysis purposes
- Protocol distribution analysis
- Automated report generation with statistics

## Quick Start Guide

### Prerequisites

Install required tools:
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install apache2-utils haproxy tcpdump wireshark-cli bc netcat-openbsd

# CentOS/RHEL
sudo yum install httpd-tools haproxy tcpdump wireshark-cli bc nmap-ncat
```

### Basic Usage

1. **Performance Monitoring** (5-minute monitoring session):
```bash
chmod +x performance-monitor.sh
./performance-monitor.sh
```

2. **Complete Module 2 Validation**:
```bash
chmod +x module2-validation.sh
./module2-validation.sh
```

3. **Traffic Simulation**:
```bash
chmod +x traffic-simulation.sh
./traffic-simulation.sh
```

4. **Packet Analysis**:
```bash
chmod +x wireshark-analysis.sh
sudo ./wireshark-analysis.sh
```

## Simulation Scenarios

### 1. Business Requirements Validation
- **Concurrent Users**: Tests with 10, 50, 100, 200, and 500+ users
- **Response Time**: Validates <3-second requirement under all loads
- **Uptime**: Simulates failover scenarios to test 99.9% availability
- **Scalability**: Demonstrates horizontal scaling capabilities

### 2. Real-World Traffic Patterns
- **Baseline Traffic**: Normal business hours (50-100 concurrent users)
- **Peak Hours**: End-of-day trading (200-300 concurrent users)
- **Flash Sales**: Special promotions (500+ concurrent users)
- **Market Events**: High-volume trading periods

### 3. Security and Monitoring
- **SIEM Integration**: Real-time security event monitoring
- **Performance Alerting**: CPU, memory, and latency thresholds
- **Service Health Checks**: Endpoint availability monitoring
- **Audit Trail**: Comprehensive logging for compliance

### 4. Disaster Recovery
- **Server Failure**: Primary server outage simulation
- **Network Partition**: Communication failure between sites
- **Database Failover**: Backend system recovery testing
- **Load Balancer Failure**: Redundancy validation

## Expected Results

### Performance Benchmarks
- **Response Time**: <3 seconds for 95% of requests
- **Throughput**: 1000+ requests per second sustained
- **Concurrent Users**: 3000+ simultaneous connections
- **CPU Utilization**: <80% under peak load
- **Memory Usage**: <85% utilization
- **Network Latency**: <100ms for critical services

### FinMark Compliance Metrics
- ✅ **Scalability**: Handles 3,000+ concurrent users
- ✅ **Performance**: Sub-3-second response times maintained
- ✅ **Availability**: 99.9% uptime target achievable
- ✅ **Security**: SIEM monitoring and alerting functional
- ✅ **Recovery**: Automatic failover in <30 seconds

## Output Files and Reports

### Performance Monitoring Outputs
- `performance_monitor.log`: System metrics over time
- `network_monitor.log`: Network interface statistics  
- `alerts.log`: Performance and security alerts
- `finmark_performance_report_*.txt`: Comprehensive analysis

### Validation Test Outputs
- `test_results_*/test_summary.log`: Overall test results
- `test_results_*/performance_test.csv`: Performance data
- `test_results_*/load_balancing_test.csv`: Load distribution data
- `test_results_*/security_test.csv`: Security test results
- `test_results_*/failover_test.csv`: Failover scenario data
- `test_results_*/finmark_module2_validation_report.txt`: Complete compliance report

### Traffic Simulation Outputs
- `traffic_simulation_*.log`: Detailed test execution logs
- `performance_baseline_*.csv`: Baseline performance data
- `load_balancing_results_*.csv`: Load distribution analysis
- `qos_test_results_*.csv`: Quality of Service validation

### Packet Analysis Outputs
- `finmark_capture_*.pcap`: Network packet captures
- `wireshark_analysis_report_*.txt`: Traffic analysis reports
- `protocol_distribution_*.csv`: Network protocol statistics

## Advanced Configuration

### Custom Load Testing
Modify scenarios in `module2-validation.sh`:
```bash
# Adjust test parameters
LOAD_TEST_USERS=100      # Concurrent users for load testing
STRESS_TEST_USERS=500    # Users for stress testing
TARGET_RESPONSE_TIME=3   # 3 seconds max response time
```

### Performance Monitoring Thresholds
Customize alerts in `performance-monitor.sh`:
```bash
ALERT_THRESHOLD_CPU=80        # CPU usage alert at 80%
ALERT_THRESHOLD_MEMORY=85     # Memory usage alert at 85%
ALERT_THRESHOLD_LATENCY=100   # Latency alert at 100ms
```

### HAProxy Configuration
Customize load balancing in `haproxy.cfg`:
- Server weights and priorities
- Health check intervals
- Session persistence settings
- SSL/TLS configurations

## Integration with FinMark Systems

### Service Endpoints
The simulation tests these FinMark service endpoints:
- `http://192.168.1.100:80/health` - Primary web server
- `https://192.168.1.100:443/api/health` - Secure API endpoint
- `http://192.168.1.100:8080/dashboard/health` - Management dashboard
- `http://192.168.1.101:8080/health` - Secondary server
- `http://192.168.1.102:8080/health` - Tertiary server

### SIEM Integration Points
- Security event logging
- Performance metric collection
- Alert escalation procedures
- Compliance audit trails

## Troubleshooting

### Common Issues
1. **Permission Errors**: Run packet capture scripts with sudo
2. **Missing Tools**: Install all prerequisites before running
3. **Network Connectivity**: Ensure test endpoints are accessible
4. **Resource Constraints**: Monitor system resources during testing

### Debug Mode
Enable verbose logging:
```bash
export DEBUG=1
./module2-validation.sh
```

## Learning Objectives Alignment

This simulation environment directly addresses the Module 2 learning objectives:

1. **High-Availability Architecture**: Demonstrates load balancing and failover
2. **Performance Optimization**: Validates response time and throughput requirements
3. **Monitoring & Alerting**: Shows SIEM integration and real-time monitoring
4. **Scalability Planning**: Tests infrastructure under various load conditions
5. **Business Impact Analysis**: Validates against FinMark's specific requirements

## Conclusion

This comprehensive simulation environment provides practical validation of the Module 2 infrastructure improvements proposed for FinMark Corporation. The tools and scripts demonstrate that the proposed solution meets all business requirements for scalability, performance, security, and stability.

The simulation results can be used to:
- Validate architectural decisions
- Support business case development  
- Guide production deployment planning
- Establish baseline performance metrics
- Demonstrate ROI for infrastructure investment
