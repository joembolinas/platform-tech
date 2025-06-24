# Intellectual Property Notice

This template is an exclusive property of Mapua-Malayan Digital College and is protected under Republic Act No. 8293, also known as the Intellectual Property Code of the Philippines (IP Code). It is provided solely for educational purposes within this course. Students may use this template to complete their tasks but may not modify, distribute, sell, upload, or claim ownership of the template itself. Such actions constitute copyright infringement under Sections 172, 177, and 216 of the IP Code and may result in legal consequences. Unauthorized use beyond this course may result in legal or academic consequences.

Additionally, students must comply with the Mapua-Malayan Digital College Student Handbook, particularly with the following provisions:

 Offenses Related to MMDC IT:
   Section 6.2 – Unauthorized copying of files
   Section 6.8 – Extraction of protected, copyrighted, and/or confidential information by electronic means using MMDC IT infrastructure
 Offenses Related to MMDC Admin, IT, and Operations:
   Section 4.5 – Unauthorized collection or extraction of money, checks, or other instruments of monetary equivalent in connection with matters pertaining to MMDC

Violations of these policies may result in disciplinary actions ranging from suspension to dismissal, in accordance with the Student Handbook.

For permissions or inquiries, please contact MMDC-ISD at isd@mmdc.mcl.edu.ph.

## Networking and Cybersecurity Architecture Template

Task Title: Finalized Network Diagram with Firewall, Security, and Performance-Enhancing Measures
Platform Context: FinMark – Financial Technology Platform
Target Output: Two Network Diagrams (Current \+ Proposed) \+ Short Explanation (Slides)

### Part 1: Current Network Infrastructure

Based on the provided [network\_inventory.csv](https://drive.google.com/file/d/1phDAtUMxZ9x_n97-6cZbkZcAL2FLJCRN/view?usp=sharing), [traffic\_logs.csv](https://drive.google.com/file/d/1J-MJD2GeL02HQGrq0vksdtrKuA2XGKBq/view?usp=drive_link) and project context:

 [FinMark Corporation IT Manual](https://docs.google.com/document/d/1rHcPZqM79yiMCfvoG78dZAtuA_-H7fDb1kFUWJGQ3SQ/edit?usp=drive_link)
 [MO-IT151 Homework: Finer FinMark Project Management H3101 CSN1](https://docs.google.com/spreadsheets/d/1DxxwuvsWaTBAR4-8tGd08cMsuA3ImHnehJQKieg9YcY/edit?usp=sharing)
 Devices or Components Likely Present:

   Router1 (10.0.0.1): Core Router, Cisco IOS. Handles HTTP, SSH. Currently using a default password.
   WebServer1 (10.0.0.20): Web Server, Ubuntu 18.04. Serves HTTP/HTTPS. SSL/TLS is outdated.
   DBServer1 (10.0.0.30): DB Server, Windows 2012\. Uses MSSQL (port 1433). No dedicated firewall is active on this server.
   PC-Client-01 (10.0.0.101): User PC, Windows 10 Pro. Uses RDP.
   PC-Client-02 (10.0.0.102): User PC, Windows 10 Home. Uses RDP. OS is outdated, and no antivirus is installed.
   Printer-01 (10.0.0.150): Network Printer. Uses RAW protocol on port 9100\. Unsecured, no password.
   Firewall: No dedicated network firewall device is explicitly mentioned in the inventory. Basic OS-level firewalls might be present but are not configured optimally (e.g., DBServer1 has no firewall).
   DNS/CDN/Load Balancers: Not explicitly mentioned in the current setup. Given the performance issues (dashboard load times, system slowdowns), these are likely absent or insufficient.
   Access Control Systems: Basic, as evidenced by "Unauthorized access incidents" and reliance on default passwords.
 Cloud or Hosting Services:

   The [network\_inventory.csv](https://drive.google.com/file/d/1phDAtUMxZ9x_n97-6cZbkZcAL2FLJCRN/view?usp=sharing) suggests an on-premises infrastructure. While FinMark aims for a SaaS platform, the current described hardware points to local hosting.
   On-premises servers (per inventory); no explicit cloud use
 Data Flow from External Internet to Internal System

   External user requests (HTTP/HTTPS) likely hit `Router1`, which forwards them to `WebServer1`.
   `WebServer1` processes requests and communicates with `DBServer1` for data (e.g., `DB_QUERY` over TCP/1433 as seen in [traffic\_logs.csv](https://drive.google.com/file/d/1J-MJD2GeL02HQGrq0vksdtrKuA2XGKBq/view?usp=drive_link)).
   Internal users (`PC-Client-01`, `PC-Client-02`) access internal resources, including `WebServer1` and potentially `DBServer1` directly (e.g., `PC-Client-01` pinging `DBServer1` successfully).
   The [traffic\_logs.csv](https://drive.google.com/file/d/1J-MJD2GeL02HQGrq0vksdtrKuA2XGKBq/view?usp=drive_link) shows an external IP (`192.168.1.50`, assuming this is external to the 10.0.0.0/24 network) making HTTP requests to `WebServer1` ("Automated script access").
   Another external IP (`10.0.0.15` \- this seems like a typo in the log and might be an external IP or a misconfigured internal device) attempted SSH to `Router1`.

Diagram 1: Current Network Architecture
 [Diagram io](https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=code%20\(5\).xml&dark=auto#R%3Cmxfile%3E%3Cdiagram%20id%3D%224UG_JhkGkG7YVw2qeW5O%22%20name%3D%22Page-1%22%3E7Vxdd6M2E%2F41Pmd7AQcQn5eOk3R7mux613m77VUOBsWmixEFeR33178jECAQduzYcZKt7RMZRp9onhnNjEQGaLR4%2FDXz0%2FktCXE8MLTwcYAuB4aBkK7BD6OsS4qu26ikzLIo5LSGMIn%2BxZzIK86WUYjzVkFKSEyjtE0MSJLggLZofpaRVbvYA4nbvab%2BDEuESeDHMvVbFNI5p9qa1mR8xNFsXnWtVzkLvyrNCfncD8lKIKGrARplhNDyavE4wjGbvmpiynrXG3LrkWU4obtU%2BDLVqTe%2B1qzg24U5VtxL89Pvile28sOPl%2FyJ%2BWDpupqCWUaWKS%2BGM4of%2Byben1bFNXlcev20ABRMFphmayjCG6pqrNucXwnTXU%2FqXJhqz%2BZEn%2FN4VjfdzAJc8InonxR4HKrAH84SP1ZysswCnCs0ovA43Zm54sUmZSlpolhbA3Qxpwvo7VKHy5xm5DsekZhkQElIAiUvHqI47pD8OJolcBvAlGGgX7CJjgCFQ56xiMKQdXOxmkcUT1I%2FYH2uQOiABvxJQsweSGPNk4RyOdJNuAcGUT9KWLNFvsyercDocnwjG5Fnq5r4sWU%2BIkNmI9JV23SRpfPUOpyp9SNLnH0a7c1k6humW%2BCvyMqBgR4s9pX4Djl28YGc0M%2FnNatOxZrqMddbZ1xglOMZLV7qMtt001Ftz0CaU6bOkWTxIUoWfvZdSTBdEfjtF8XrKLmFUkD8LSk5DJefyioDw46ZHE4zuJqxqw83w0%2BQr8CfrqnFF8ZimL%2FIRYd5vlwAgwztOvap2GhR%2FROBZIJnC%2BCQTyOSnJVAG2kWakHNcE1VQJrpylhDqEe320gF%2Fe5oqEzRMXVCB2H%2FMZVQ6QDTVXWku7bLU5kx%2FauuretqUwvp3lFYkyh5Pld8SvEipRJHJpOPQLghswjkTRuKpQQ24RAsN35LMjonMwJ64aqhdmSkKXNDSMrZ9zemdM0lx19S0mYuMCFb%2F8nqq1Z1%2Bxdvrri5fGzdrfld7E9xfOEH32fFEAQUXNnsyyVWoJefoqFwyOxYphhiP8%2BjoCReR3E1qv0wUq6EfMrq5bGcfRghIK%2B0sv1shmktAFCOLwJsmrciLMOgOaMfbQO6Dx%2B86phECW1UiG6ZbRViIVXAaWVCVA2W4%2BRtNJiDOfPXQrGUFcj36NXQVQu5pq3z1Grb1p3qLrL7FsydGoOLcrSNsNSzubv8zClNcyXD%2FyxxTmU75%2BPd3RjamQD1a6vMWYAOEaCosD4wVZb5qwuOqbu9BvhJ5eipQZiGaiMH2QZP7UPEamtjxxErBmHw5HGo5EEW9axNw6oAMwx5EW0YgK%2BR9xiiTAx%2FOQteNao%2BW%2BoYq5nAqlcTR9tte12nkT%2BpV7CkBQlB3E97psBtbexggUsDJYgjYLtS9SvI2XikjJrMrmBxt07vy%2Ft6OZYkLp%2F7KbtcPM5Y4FINojwgakAWKUNIfu8n4X2KAUVznPlxrqZBW5xaNnsfiivf7YbJz5jkUeEsosspoaAvepw7ygRZ9gGjhT%2FDwzwtY5ua7GBoyHY9p8%2FBeCg%2BLOc7psGcVy8AhLOrH5jhSPRQq%2FimwTTMksbghYzqqOopwxW63o4ImuBymIZrOTpPTdlXqcy3VohCs1TTMy3NKtMjRJYEiBrbIGpsgWhPXgFR6Fz7vKQhX0w%2BT0pSEXIY%2FnGG8HuC8KZg6B6I9jqGFOoBuA69mMiz7Co9HOGtNVIA99eKrn0YkQz3hM4qgMs5l%2FjBX8ZsmRmDHbAiWVhCu%2FTrx2DOyHWK%2Fj%2BnWI6w9QO%2FHHcO8uVo2hnpJ0O6Y7pbLIYdgG4Y2tNAN2zV8pCp2WVqH47zFZ6Cy%2FajD%2Brf8HRSZW0AOduz6mY1LnZHk08mN0C%2Fu5nsCOVyXLkK4MH35c0Z0CcDtGW1rQ%2FbtdQavpC6z0PwC6jqcCOCLy%2BeAjDqAfDtZPLlRjA6rqMMr3zW5d6wPaP2lW1mFyG1VpcslQ0Mxz4NTIs4SsS36ZQsTJWYRS26mBU28vo8tpPGSFoRkiZgsiFGgh8j%2BqdwXdZyLH7b1GI3bz2iKTvhYgRFzj1yGGXveEfHsHZM1TEssEp4am4Nd3RrW0gVohvoJQKKDP80WmDQFrKNzXCv3Ym570sC9JYE%2FOQCYBxbAPZSqGmg6Uo4VdIomcm6dHTLkDSu895HsLlWpDV0%2FhJA9TPBqGO6vR6GDCXNirVZwtDPDpxTcf%2FoaqJ%2FKbPA07Zaq5nlgp%2Bqe46r8bTd5IYNh%2BeuawWWaqdaKcRym43X9pb7LL63cZLqAP1yskNXTpvxNjJU%2BfCUaPqbPR7qy5zD7AJjPzWD4ylZiRqmIEDGnGTRv2x6Y4lhL2TQvyllIi4l3UDWSyua%2BrxehTbLVEVHs9Ng%2BSCSmpH1l%2BG2mnUMR%2FV0Q3Mdnu6kvfZ1H7oP09%2FrUR0Avt5uEYleLfn%2BnIH3asWdULj2Pl3jdTS95alICPNs93a7tfcA%2Bw7mhm2ban3AjaU76YFnu9HFds8WIbom2crPwiIA%2Fzak6L%2FrC7X2FE8jXnuZKI3ZGk4lIN2NmCsNJhPYTNoHHiPXvixxtn7dk1z64IWNmrcKpy5qTuJYP09fm9q2YwCubqj1CzSQPqG%2Bn2jMsVRbiN0f92zWlpPiPW%2FIDaq9%2FWFdUjoKWR0XsGQp2v9oy32pYgLQ%2BBu8OkGCpqUI3kxrQo3xz%2BUeDqfn%2FA0aa%2FAiW0itDTF5P%2BmZ22Gvug3VCaj3v8bz1CaUa6riDtQRtqB6jmlL9jbuOYTy4X9Fee2CvUjMrq5vyTRi76NpwzQ9HLigye6nvO0zbF%2FxuFbXp30juO090bxB3%2FISsp71DFW3XRXsde1wxAJxESVF2OUM11c7ouKZbxKuvU%2FnSqg9fL3nWxYd7gvgexIIzwDasaAjRad7sbQBE7vCaSN2TA91sGNIcPF63vdG%2B%2BMDbpv%2FblHanM1%2FCUFX%2Fwc%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E) see this whole picture

![][image1]

Weak Points in the Current Design

 Single Points of Failure:
   `Router1`: As the sole core router, its failure would bring down all external and potentially internal connectivity.
   `WebServer1` & `DBServer1`: Without redundancy or load balancing, failure or overload of these servers directly impacts service availability (contributing to "frequent system crashes" and "dashboard takes 20 seconds to load").
 Areas Vulnerable to Cyberattacks:
   Router1:
     Default password in use: Critical vulnerability, allows easy unauthorized access.
     SSH port (22) open to external access: traffic\_logs.csv shows a failed SSH login attempt from `10.0.0.15` (potentially external). If not needed for legitimate external admin, this is an unnecessary risk.
   WebServer1:
     Outdated SSL/TLS: Susceptible to known vulnerabilities (e.g., POODLE, BEAST), allowing potential interception/decryption of sensitive data in transit. This violates FinMark IT Manual C (TLS 1.2+).
     Automated script access from `192.168.1.50`: Could be legitimate, but also a sign of bot activity or vulnerability scanning if not whitelisted.
   DBServer1:
     No firewall: Directly exposed to threats from within the LAN. Any compromised internal device can directly attack the DB server.
     Direct ICMP access from `PC-Client-01`: While ICMP itself isn't a high risk, it shows a lack of network segmentation and filtering. If clients can ping, they might be able to attempt other connections.
   PC-Client-02:
     Outdated OS, no antivirus: Highly vulnerable to malware, which could then spread across the network.
   Printer-01:
     Unsecured printing, no password: Can be exploited for information leakage or as a pivot point for attacks.
   General Lack of Segmentation: The flat network structure allows threats to move laterally with ease. A compromised user PC could potentially access servers directly.
   Unclear API Security: The project brief mentions "unsecured APIs" as a pain point for backend teams.
   Weak Access Control: "Unauthorized access incidents" reported, indicating issues with current authentication/authorization. Default passwords confirm this.
 Performance Degradation Under Heavy Traffic:
   No Load Balancing: `WebServer1` and `DBServer1` are likely bottlenecks. The 20-second dashboard load time for 200 employees and system slowdowns during peak hours are direct symptoms.
   Limited Bandwidth/Capacity of Router1: May struggle with increasing external traffic.
   Unoptimized Queries/Backend: While a software issue, it exacerbates network load on `DBServer1`.
   RDP Dropouts (PC-Client-01) / Timeout (PC-Client-02): Indicates network congestion or issues with the RDP service/target machines.
 Internal and External Traffic Segmentation:
   Poor/No Segmentation: The network appears flat. Internal user PCs can directly ping critical servers like `DBServer1`. There's no clear DMZ or segregation of server/user zones. This violates the principle of least privilege.
 Compliance with Data Privacy Laws (PDPA, GDPR, PCI DSS) & FinMark IT Manual:
   FinMark IT Manual Violations:
     A. RBAC: Likely not strictly enforced given "unauthorized access incidents."
     B. MFA: Not mentioned as implemented; default passwords violate authentication strength.
     C. Data Encryption: Outdated TLS on `WebServer1` violates "TLS 1.2+ for data in transit." Encryption at rest for `DBServer1` is unconfirmed but unlikely given other security lapses.
     D. Monitoring: No SIEM or comprehensive logging mentioned for the current setup.
     E. System Load Management: Current performance issues directly contradict this.
   PDPA/GDPR/PCI DSS: The current state (default passwords, outdated TLS, no DB firewall, potential lack of encryption at rest, unauthorized access) poses significant risks to financial and customer data, making compliance highly unlikely.

### Part 2: Proposed Network Architecture

This section outlines proposed enhancements to the existing network architecture to improve security, performance, and manageability. The original architecture includes basic firewalling, VPN access, and load balancing. The following additions aim to build on that foundation.

To make the network more secure and faster, several improvements will be made:

 A Web Application Firewall (WAF) will be added to protect the web server from common attacks like SQL injection and cross-site scripting.
 Intrusion Detection and Prevention Systems (IDS/IPS) will be implemented to monitor network traffic and detect threats in real time.
 Endpoint Detection and Response (EDR) will be installed on internal devices like PCs and printers to help detect and stop threats.
 VLAN-based segmentation will be used to separate client devices from important systems like the database and web servers.
 If email is used in the network, an Email Security Gateway will also be added to block phishing and malware.
  For improved performance and security, the load balancer will continue managing web traffic while also accelerating static content delivery for remote users. The network architecture separates internal and external traffic, with external requests filtered through firewalls, DMZs, VPN gateways, and authenticated via RBAC and MFA. Internal traffic is protected by an internal firewall and directed to key resources like servers and printers. Secure remote administration is enabled through encrypted VPN access, while the DMZ hosts public-facing services like WebServer1 and IDS/IPS, ensuring sensitive systems remain isolated. This layered setup strengthens both security and operational efficiency.

Diagram 2: Proposed Network Design

Key Decisions and Rationale

| Improvement                              | Issue It Solves                                        | Why It’s Better for FinMark                                    |
| ---------------------------------------- | ------------------------------------------------------ | --------------------------------------------------------------- |
| Firewall                       | Blocks unauthorized external access                    | Establishes strong perimeter security                           |
| IDS/IPS                        | Detects and stops live threats (e.g., scans, exploits) | Proactively monitors and protects the network                   |
| VPN \+ RBAC \+ MFA             | Prevents weak authentication and unauthorized logins   | Secures remote access with encryption and role-based control    |
| Internal Firewall              | Prevents threats from spreading internally             | Segments internal traffic to protect critical assets            |
| Load Balancer                  | Fixes slow performance and overload issues             | Distributes traffic for higher availability and faster response |
| VLAN Segmentation              | Stops free movement across devices and servers         | Isolates systems to reduce lateral attack risk                  |
| EDR (Endpoint Protection)      | Protects outdated or unsecured devices                 | Detects and responds to threats at the device level             |
| Email Security Gateway         | Blocks phishing and malware in emails                  | Protects users from email-based attacks                         |
| Admin VLAN \+ Whitelisting     | Prevents unauthorized admin access                     | Only trusted devices can manage the network                     |
| CDN (Content Delivery Network) | Reduces latency and improves website load times        | Speeds up access for remote users and offloads server strain    |

### Part 3: Final Output for Presentation

[https://www.canva.com/design/DAGngtDvQ08/6xo7Z\_EHgYF67B2Y3HU1Aw/edit?utm\_content=DAGngtDvQ08\&utm\_campaign=designshare\&utm\_medium=link2\&utm\_source=sharebutton](https://www.canva.com/design/DAGngtDvQ08/6xo7Z_EHgYF67B2Y3HU1Aw/edit?utm_content=DAGngtDvQ08&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

The final output contains the following components:

 Diagram 1: Current Network Setup (with labels and analysis)
 Diagram 2: Proposed Network Architecture (with improvements clearly marked)
 Short written explanation in pdf/deck (bullets or 3–5 slides) describing:
   Major vulnerabilities/bottlenecks
   Key design changes
   How your design improves security, performance, or reliability
   You may use tools like Lucidchart, Draw.io, Cisco Packet Tracer (for simulation), or PowerPoint shapes to create your diagrams
 To be presented on: Week 4 synchronous session
