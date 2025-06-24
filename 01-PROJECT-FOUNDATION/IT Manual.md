# FinMark Corporation

IT Manual 2025

IT Manual: Data Security Provisions

### I. Purpose

This section outlines the data security provisions implemented to ensure the confidentiality,
integrity, and availability of data managed by FinMark Corporation, a Philippine company
headquartered in Makati City, serving clients across Southeast Asia. These provisions focus
on protecting financial records, customer information, and operational data, supporting
FinMark's regional growth and operational scalability.

### II. Scope

This policy applies to all:

- FinMark Corporation employees (full-time, part-time, contractual)
- Systems and applications operated by or on behalf of FinMark
- Third-party vendors with access to FinMark data

### III. Core Principles

1. Data Confidentiality — Protect sensitive information from unauthorized access.
2. Data Integrity — Prevent unauthorized alteration of data.
3. Data Availability — Ensure reliable access to data when needed.
4. Accountability — Assign clear responsibilities for data access and handling.

## A. Role-Based Access Control (RBAC)

- Access is granted based on job roles and responsibilities- Each employee is assigned
  system access that corresponds strictly to their role within FinMark Corporation- For
  example, finance personnel can access financial dashboards, while customer service staff
  may only view order status and customer contact details. This segmentation ensures that
  employees only access the information necessary to perform their duties-
- Default access level is minimal (least privilege). All new employees or system users are
  initially granted the lowest level of access required to perform their basic tasks. This "least
  privilege" principle reduces the risk of internal data exposure and helps ensure that
  sensitive operations are limited to those who are properly trained and authorized-
- Department heads must approve access elevation. Requests to increase system access
  or expand data visibility must go through a formal approval process handled by the
  employee's department head. The request must clearly state the purpose for access, the
  type of data or function needed, and the duration (if temporary)- The IT department will
  only implement access changes once a signed or digitally approved request is received,
  and all changes will be documented and subject to audit

## B. Authentication and Authorization
- Mandatory Multi-Factor Authentication (MFA): All system users must authenticate using at
least two factors (eg-, password and mobile app confirmation)- This significantly reduces
the risk of unauthorized access through compromised credentials.
- Pre-approved access only: All user access must be pre-approved by designated
department heads or data owners- This ensures accountability and helps track access
justifications across all roles-
- Session timeout after 15 minutes of inactivity: To prevent unauthorized access through
unattended sessions, systems automatically log users out after 15 minutes of inactivity-
Users must reauthenticate to continue their session.


## C. Data Encryption
- TLS 1.2+ for data in transit: All data transferred between clients, servers, and third-party
systems must be encrypted using Transport Layer Security (TLS) version 12 or higher to
protect against interception and eavesdropping.
- AES-256 encryption for data at rest: Data stored in databases or file systems must be
encrypted using Advanced Encryption Standard (AES) with a 256-bit key, ensuring that
even in case of physical theft, data remains inaccessible-
- Mandatory encryption for financial and customer records: All sensitive information,
including financial transactions and customer data, must be encrypted to comply with
local and regional data privacy laws and protect customer trust.


## D. Monitoring and Incident Response
- Real-time monitoring with SIEM: A Security Information and Event Management (SIEM)
system actively scans and aggregates security alerts, allowing the IT team to detect
anomalies and threats as they occur.
- Comprehensive logging of access and modifications: All user logins, file access, and
system changes are logged to provide a full audit trail for investigations and compliance
checks.
- Incident handling follows the Incident Response Plan (IRP): All detected threats or
breaches are managed based on the predefined IRP, which includes containment,
eradication, recovery, and reporting steps.


## E. System Load Management & Performance Tuning
- Load balancing during peak hours: Requests to the system are evenly distributed across
multiple servers, preventing overload and ensuring continuous access during high-traffic
periods.
- Dashboards optimized for sub-3 second load time: Performance tuning practices ensure
dashboards load within 3 seconds even with simultaneous access by hundreds of users,
supporting business continuity.
- Priority resource allocation for financial modules: Critical systems, especially those
processing financial data, receive prioritized access to computing resources to maintain
high reliability and accuracy


## F. Data Backup and Disaster Recovery
- Daily encrypted backups: Backups of critical systems and data are performed daily and
encrypted to protect against data loss and ensure recovery integrity
- Offsite secure storage: All backups are securely stored offsite or in a separate cloud
region to prevent data loss in case of local infrastructure failure or disasters.
- Quarterly DRP testing: The Disaster Recovery Plan is tested every quarter to ensure
preparedness, validate recovery time objectives (RTOs), and identify areas for
improvement


## G. User Awareness and Training
- Bi-annual cybersecurity training: All employees must complete training every six months
to stay informed of current threats, best practices, and company-specific security policies.
- Includes phishing simulations and safe data handling: Training modules simulate
real-world attacks and provide interactive scenarios to teach users how to handle
sensitive data securely and avoid social engineering attempts.

## H. Third-Party Vendor Compliance
- Vendors must sign a Data Protection Agreement (DPA): All third-party providers with
access to FinMark Corporation's data must sign a DPA to formalize their responsibility in
protecting company information.
- Security review and risk assessment before system integration: Before integrating
third-party tools or platforms, a full security assessment is conducted to evaluate potential
risks and ensure alignment with FinMark's security policies.


## V. Violations and Sanctions

Violations of this data security policy may lead to disciplinary action depending on severity, intent,
and impact:

  - Minor Violations (e.g., password sharing, delayed software updates): Verbal or written
  warning.
  - Moderate Violations (e.g. unauthorized access attempts, failure to report incidents):
  Suspension of access, mandatory retraining, and written reprimand.
  - Severe Violations (e_g_, intentional data breaches, gross negligence): Termination, legal
  action, and potential criminal charges under the Data Privacy Act of 2012 (RA 10173).

## VI. Review and Updates
This policy is reviewed every 6 months by FinMark Corporation's IT Security Team_ Updates are
implemented in response to:
  - Security incidents
  - Organizational changes
  - Updates in Philippine and Southeast Asian data protection regulations
