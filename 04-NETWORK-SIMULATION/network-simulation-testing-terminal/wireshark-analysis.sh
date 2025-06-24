#!/bin/bash

# Project Bedrock - Wireshark Packet Analysis Script
# Module 2: Network Traffic Analysis for FinMark Corporation

echo "=========================================="
echo "Project Bedrock - Packet Capture Analysis"
echo "Module 2: Performance and Security Monitoring"
echo "=========================================="

# Configuration
INTERFACE="eth0"
CAPTURE_DURATION=60
CAPTURE_FILE="finmark_traffic_$(date +%Y%m%d_%H%M%S).pcap"
ANALYSIS_REPORT="traffic_analysis_report.txt"

echo "Starting packet capture for FinMark network analysis..."
echo "Interface: ${INTERFACE}"
echo "Duration: ${CAPTURE_DURATION} seconds"
echo "Output file: ${CAPTURE_FILE}"
echo ""

# Function to start packet capture
start_capture() {
    echo "=== STARTING PACKET CAPTURE ==="
    echo "Capturing network traffic during simulation..."
    
    # Capture packets with filters for FinMark services
    sudo tcpdump -i ${INTERFACE} -s 65535 -w ${CAPTURE_FILE} \
        '(port 80 or port 443 or port 8080) and (host 192.168.1.100 or host 192.168.1.101 or host 192.168.1.102)' &
    
    TCPDUMP_PID=$!
    echo "Packet capture started (PID: ${TCPDUMP_PID})"
    echo "Monitoring ports: 80 (HTTP), 443 (HTTPS), 8080 (Dashboard)"
    echo ""
    
    # Wait for specified duration
    sleep ${CAPTURE_DURATION}
    
    # Stop capture
    sudo kill ${TCPDUMP_PID}
    echo "Packet capture completed: ${CAPTURE_FILE}"
    echo ""
}

# Function to analyze captured packets
analyze_traffic() {
    echo "=== TRAFFIC ANALYSIS ==="
    echo "Analyzing captured packets for performance metrics..."
    
    # Create analysis report
    cat > ${ANALYSIS_REPORT} << EOF
Project Bedrock - Traffic Analysis Report
Generated: $(date)
Capture File: ${CAPTURE_FILE}
Analysis Period: ${CAPTURE_DURATION} seconds

EOF
    
    # Use tshark for automated analysis
    if command -v tshark &> /dev/null; then
        echo "Using tshark for detailed packet analysis..."
        
        # Total packet count
        TOTAL_PACKETS=$(tshark -r ${CAPTURE_FILE} -q -z io,stat,0 2>/dev/null | grep "Interval" -A 1 | tail -1 | awk '{print $2}')
        echo "Total packets captured: ${TOTAL_PACKETS}" | tee -a ${ANALYSIS_REPORT}
        
        # HTTP vs HTTPS traffic distribution
        HTTP_PACKETS=$(tshark -r ${CAPTURE_FILE} -Y "tcp.port == 80" -q -z io,stat,0 2>/dev/null | grep "Interval" -A 1 | tail -1 | awk '{print $2}')
        HTTPS_PACKETS=$(tshark -r ${CAPTURE_FILE} -Y "tcp.port == 443" -q -z io,stat,0 2>/dev/null | grep "Interval" -A 1 | tail -1 | awk '{print $2}')
        
        echo "" | tee -a ${ANALYSIS_REPORT}
        echo "Protocol Distribution:" | tee -a ${ANALYSIS_REPORT}
        echo "- HTTP (port 80): ${HTTP_PACKETS} packets" | tee -a ${ANALYSIS_REPORT}
        echo "- HTTPS (port 443): ${HTTPS_PACKETS} packets" | tee -a ${ANALYSIS_REPORT}
        
        # Calculate security ratio
        if [ ! -z "$HTTP_PACKETS" ] && [ ! -z "$HTTPS_PACKETS" ] && [ "$TOTAL_PACKETS" -gt 0 ]; then
            HTTPS_RATIO=$(echo "scale=1; ${HTTPS_PACKETS} / ${TOTAL_PACKETS} * 100" | bc)
            echo "- HTTPS Security Ratio: ${HTTPS_RATIO}%" | tee -a ${ANALYSIS_REPORT}
        fi
        
        # Top talkers analysis
        echo "" | tee -a ${ANALYSIS_REPORT}
        echo "Top Source IPs:" | tee -a ${ANALYSIS_REPORT}
        tshark -r ${CAPTURE_FILE} -q -z ip_hosts,tree 2>/dev/null | head -10 | tee -a ${ANALYSIS_REPORT}
        
        # Response time analysis (TCP conversations)
        echo "" | tee -a ${ANALYSIS_REPORT}
        echo "TCP Conversation Analysis:" | tee -a ${ANALYSIS_REPORT}
        tshark -r ${CAPTURE_FILE} -q -z conv,tcp 2>/dev/null | head -10 | tee -a ${ANALYSIS_REPORT}
        
        # Error detection
        echo "" | tee -a ${ANALYSIS_REPORT}
        echo "Error Analysis:" | tee -a ${ANALYSIS_REPORT}
        
        # TCP retransmissions
        RETRANS_COUNT=$(tshark -r ${CAPTURE_FILE} -Y "tcp.analysis.retransmission" -q -z io,stat,0 2>/dev/null | grep "Interval" -A 1 | tail -1 | awk '{print $2}')
        echo "- TCP Retransmissions: ${RETRANS_COUNT}" | tee -a ${ANALYSIS_REPORT}
        
        # TCP resets
        RESET_COUNT=$(tshark -r ${CAPTURE_FILE} -Y "tcp.flags.reset == 1" -q -z io,stat,0 2>/dev/null | grep "Interval" -A 1 | tail -1 | awk '{print $2}')
        echo "- TCP Resets: ${RESET_COUNT}" | tee -a ${ANALYSIS_REPORT}
        
        # Calculate packet loss rate
        if [ ! -z "$RETRANS_COUNT" ] && [ ! -z "$TOTAL_PACKETS" ] && [ "$TOTAL_PACKETS" -gt 0 ]; then
            LOSS_RATE=$(echo "scale=3; ${RETRANS_COUNT} / ${TOTAL_PACKETS} * 100" | bc)
            echo "- Estimated Packet Loss Rate: ${LOSS_RATE}%" | tee -a ${ANALYSIS_REPORT}
        fi
        
    else
        echo "tshark not available. Using basic tcpdump analysis..."
        
        # Basic packet count
        TOTAL_PACKETS=$(tcpdump -r ${CAPTURE_FILE} 2>/dev/null | wc -l)
        echo "Total packets: ${TOTAL_PACKETS}" | tee -a ${ANALYSIS_REPORT}
    fi
    
    echo "" | tee -a ${ANALYSIS_REPORT}
    echo "Performance Assessment:" | tee -a ${ANALYSIS_REPORT}
    
    # Performance thresholds based on FinMark requirements
    if [ ! -z "$RETRANS_COUNT" ]; then
        if [ "$RETRANS_COUNT" -lt 10 ]; then
            echo "✓ Network stability: EXCELLENT (Low retransmissions)" | tee -a ${ANALYSIS_REPORT}
        elif [ "$RETRANS_COUNT" -lt 50 ]; then
            echo "⚠ Network stability: GOOD (Moderate retransmissions)" | tee -a ${ANALYSIS_REPORT}
        else
            echo "✗ Network stability: NEEDS ATTENTION (High retransmissions)" | tee -a ${ANALYSIS_REPORT}
        fi
    fi
    
    if [ ! -z "$HTTPS_RATIO" ]; then
        HTTPS_RATIO_INT=$(echo "$HTTPS_RATIO" | cut -d. -f1)
        if [ "$HTTPS_RATIO_INT" -gt 80 ]; then
            echo "✓ Security compliance: EXCELLENT (${HTTPS_RATIO}% HTTPS)" | tee -a ${ANALYSIS_REPORT}
        elif [ "$HTTPS_RATIO_INT" -gt 60 ]; then
            echo "⚠ Security compliance: GOOD (${HTTPS_RATIO}% HTTPS)" | tee -a ${ANALYSIS_REPORT}
        else
            echo "✗ Security compliance: NEEDS IMPROVEMENT (${HTTPS_RATIO}% HTTPS)" | tee -a ${ANALYSIS_REPORT}
        fi
    fi
    
    echo "" | tee -a ${ANALYSIS_REPORT}
}

# Function to create Wireshark display filters for FinMark analysis
create_wireshark_filters() {
    echo "=== WIRESHARK DISPLAY FILTERS ==="
    echo "Creating custom filters for FinMark traffic analysis..."
    
    cat > wireshark_filters.txt << EOF
# Project Bedrock - Wireshark Display Filters for FinMark Corporation
# Use these filters in Wireshark GUI for detailed analysis

# 1. Checkout Traffic Analysis (Critical Service)
tcp.port == 443 and http.request.uri contains "checkout"

# 2. Dashboard Performance Analysis
tcp.port == 8080 and http.request.uri contains "dashboard"

# 3. Load Balancer Traffic Distribution
ip.addr == 192.168.1.100 and (tcp.port == 80 or tcp.port == 443)

# 4. Performance Issues Detection
tcp.analysis.retransmission or tcp.analysis.duplicate_ack or tcp.analysis.lost_segment

# 5. Security Analysis - Unencrypted Traffic
tcp.port == 80 and http.request

# 6. High Response Time Detection
http.time > 3.0

# 7. Error Response Analysis
http.response.code >= 400

# 8. QoS Traffic Classification
# High Priority (Checkout)
tcp.port == 443 and http.request.uri contains "checkout"

# Medium Priority (Dashboard)
tcp.port == 8080

# Low Priority (Static Content)
tcp.port == 80 and (http.request.uri contains "static" or http.request.uri contains "images")

# 9. Concurrent User Analysis
tcp.flags.syn == 1 and tcp.flags.ack == 0

# 10. Session Analysis
tcp.stream eq [stream_number]
EOF
    
    echo "Wireshark filters created: wireshark_filters.txt"
    echo "Use these filters to analyze specific traffic patterns"
    echo ""
}

# Function to simulate traffic for analysis
simulate_traffic_for_analysis() {
    echo "=== GENERATING TRAFFIC FOR ANALYSIS ==="
    echo "Creating representative traffic patterns..."
    
    # Simulate different types of traffic patterns
    
    # 1. Normal checkout traffic
    echo "Simulating checkout transactions..."
    for i in {1..20}; do
        curl -s -X POST "https://192.168.1.100/api/checkout" \
             -H "Content-Type: application/json" \
             -d '{"user_id":"'$i'","amount":29.99}' &
        sleep 0.1
    done
    
    # 2. Dashboard access
    echo "Simulating dashboard access..."
    for i in {1..15}; do
        curl -s "http://192.168.1.100:8080/dashboard" &
        sleep 0.2
    done
    
    # 3. Static content requests
    echo "Simulating static content downloads..."
    for i in {1..30}; do
        curl -s "http://192.168.1.100/static/image${i}.jpg" &
        sleep 0.05
    done
    
    # 4. Simulate some errors
    echo "Simulating error conditions..."
    for i in {1..5}; do
        curl -s "http://192.168.1.100/nonexistent-page" &
        sleep 0.3
    done
    
    echo "Traffic generation completed"
    wait
    echo ""
}

# Function to validate QoS effectiveness
validate_qos_performance() {
    echo "=== QoS PERFORMANCE VALIDATION ==="
    echo "Analyzing traffic prioritization effectiveness..."
    
    if [ -f "${CAPTURE_FILE}" ]; then
        # Analyze response times by service type
        echo "Analyzing response times by service priority..."
        
        # High priority (checkout) analysis
        if command -v tshark &> /dev/null; then
            echo "Checkout Service (High Priority):" | tee -a ${ANALYSIS_REPORT}
            tshark -r ${CAPTURE_FILE} -Y "tcp.port == 443 and http" -T fields -e http.time 2>/dev/null | \
                awk '{sum+=$1; count++} END {if(count>0) printf "- Average response time: %.2f seconds\n", sum/count}' | tee -a ${ANALYSIS_REPORT}
            
            echo "Dashboard Service (Medium Priority):" | tee -a ${ANALYSIS_REPORT}
            tshark -r ${CAPTURE_FILE} -Y "tcp.port == 8080 and http" -T fields -e http.time 2>/dev/null | \
                awk '{sum+=$1; count++} END {if(count>0) printf "- Average response time: %.2f seconds\n", sum/count}' | tee -a ${ANALYSIS_REPORT}
            
            echo "Static Content (Low Priority):" | tee -a ${ANALYSIS_REPORT}
            tshark -r ${CAPTURE_FILE} -Y "tcp.port == 80 and http" -T fields -e http.time 2>/dev/null | \
                awk '{sum+=$1; count++} END {if(count>0) printf "- Average response time: %.2f seconds\n", sum/count}' | tee -a ${ANALYSIS_REPORT}
        fi
    fi
    
    echo ""
}

# Main execution function
main() {
    echo "Starting comprehensive network traffic analysis..."
    echo "This will capture and analyze traffic patterns for Project Bedrock Module 2"
    echo ""
    
    # Check for required tools
    if ! command -v tcpdump &> /dev/null; then
        echo "Error: tcpdump is required but not installed"
        exit 1
    fi
    
    # Check permissions
    if [ "$EUID" -ne 0 ]; then
        echo "Warning: Root privileges required for packet capture"
        echo "Some features may not work without sudo"
        echo ""
    fi
    
    # Create Wireshark filters
    create_wireshark_filters
    
    # Start traffic simulation in background
    simulate_traffic_for_analysis &
    TRAFFIC_PID=$!
    
    # Start packet capture
    start_capture
    
    # Wait for traffic simulation to complete
    wait $TRAFFIC_PID
    
    # Analyze captured traffic
    analyze_traffic
    
    # Validate QoS performance
    validate_qos_performance
    
    echo "=== ANALYSIS COMPLETE ==="
    echo "Generated files:"
    echo "- ${CAPTURE_FILE}: Raw packet capture (open with Wireshark)"
    echo "- ${ANALYSIS_REPORT}: Detailed analysis report"
    echo "- wireshark_filters.txt: Custom filters for Wireshark"
    echo ""
    echo "Next steps:"
    echo "1. Open ${CAPTURE_FILE} in Wireshark"
    echo "2. Apply filters from wireshark_filters.txt"
    echo "3. Review ${ANALYSIS_REPORT} for performance insights"
    echo "4. Use results to validate Module 2 performance improvements"
    echo ""
}

# Execute main function
main "$@"
