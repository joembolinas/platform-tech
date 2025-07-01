# Homework: Milestone 1: Project Blueprint (Draft)

By now, your team should have already consulted with your mentor regarding the initial requirements of your task.

This time, submit a draft of your Milestone 1 for initial feedback. Note that this submission will serve as your mentoring session for Milestone 1. Your submission is important—your mentor’s feedback here will help assess your responsiveness to improving your work. If you choose not to submit a draft, you are waiving your opportunity for revisions in Milestone 1. While this is allowed, it’s highly recommended that you take advantage of all opportunities for growth, including feedback from a practitioner with relevant specialization and experience.

To help you refocus on the key expectations of your client, here’s a summary of the main responsibilities per specialization. These are the end-goals of your contract with them, so before the term ends, make sure that these goals are fully achieved:

1. ~~ Software Development: Optimize the application to handle a growing number of users and online orders without failure or performance issues.~~
2. Network & Cybersecurity: Ensure data security, maintain system stability, and prevent or manage system crashes and data breaches.
3. ~~ Data Analytics: Analyze order patterns, predict peak usage periods, and support inventory management through data-driven insights.~~

This week, you are tasked to complete the following:

A. Software Development:

1. Analyze FinMark's current system behavior based on the provided context, especially issues related to:
2. Users being unable to load key pages during peak hours
3. Failed transactions when generating financial reports or submitting planning requests
4. Vague error messages and unhandled exceptions
5. Key Tasks:
6. Visualize the Current Architecture
7. Create a diagram illustrating how the current system components interact (frontend, backend, database, APIs, services).
8. Identify potential points of failure and explain likely root causes (e.g., poor scalability, weak error handling, unoptimized queries, or security lapses).
9. Propose a Revised Software Architecture
10. Design an improved system structure considering:
11. Scalability: e.g., load balancing, service decomposition, caching, database replication
12. Security: e.g., authentication, data encryption, input validation
13. Present this as a clearly labeled diagram.
14. Prepare a Brief Presentation
15. Submit two diagrams: (1) Current flow and (2) Proposed system architecture
16. Include an explanation (short document or slide deck) summarizing key pain points and improvements

B. Network and Cybersecurity

1. Analyze FinMark’s current network setup and security posture based on the provided context, particularly in relation to:
2. Unauthorized access incidents reported in recent weeks
3. System slowdowns during peak usage hours
4. Potential vulnerabilities that affect platform stability, user trust, and regulatory compliance
5. Key Tasks:
6. Diagram the Current Network Infrastructure
7. Create a diagram illustrating the assumed current network components and data flow.
8. Include elements such as routers, firewalls, servers, DNS, CDN (if applicable), load balancers, and access control systems.
9. Clearly label data flow paths (e.g., external request → internal systems) and note areas where unauthorized access or slow performance may occur.
10. Analyze Bottlenecks and Vulnerabilities
11. Identify specific issues related to:
12. Performance (e.g., latency under load, limited bandwidth)
13. Security (e.g., weak access control, lack of encryption or segmentation)
14. Propose a Redesigned Secure and Scalable Network
15. Develop a revised network architecture that addresses performance and security issues, including:
16. Role-based access control and authentication layers
17. Scalable components (e.g., distributed servers, load balancers, cloud/CDN services)
18. Security features (e.g., updated firewalls, intrusion detection/prevention systems, data encryption)
19. Ensure that legal and policy considerations (e.g., PDPA, GDPR, PCI DSS, or FinMark’s IT Manual) are reflected where relevant.
20. Prepare a Brief Presentation
21. Submit two diagrams: (1) Current network setup and (2) Proposed secure and scalable design
22. Include a short explanation (document or slide deck) that summarizes:
23. Key vulnerabilities and performance issues
24. Design decisions and security improvements

C. Data Analytics:

1. Analyze FinMark’s current data pipeline and reporting system based on the context provided, focusing on issues related to:
2. Lack of real-time data capture on customer behavior and system usage
3. Delayed or outdated reports that affect timely marketing and business decisions
4. Inability to anticipate market trends due to missing predictive capabilities
5. Key Tasks:
6. Map the Current Data Flow
7. Diagram or outline the existing (or assumed) data flow from user interactions to reporting tools.
8. Highlight what data is currently missing or not captured in real time (e.g., page visits, API hits, order frequency, user actions).
9. Identify what types of marketing or business decisions are negatively affected by these data gaps.
10. Design a Refined Data Pipeline
11. Propose a revised data flow that enables real-time or near-real-time analytics, including:
12. Customer behavior tracking
13. Event logging, session tracking, usage monitoring
14. Data aggregation and storage in a data warehouse or data lake
15. Analysis and visualization through dashboards and KPIs
16. Clearly label all components in the diagram, such as:
17. Data sources (e.g., user activity, APIs)
18. Data ingestion tools (e.g., Kafka, ETL scripts)
19. Storage systems (e.g., SQL/NoSQL, Redshift, BigQuery)
20. Analytics tools (e.g., Python, Tableau, Power BI)
21. Key metrics (e.g., daily active users, campaign response rates, system failures)
22. Identify Key Insights and Predictive Opportunities
23. Suggest at least 3 actionable insights your system could generate to support:
24. Product scaling
25. Improved customer experience
26. Better business and marketing planning
27. Explain how the data could power automated marketing actions (e.g., alerts, triggers, campaign launch conditions).
28. Prepare a Brief Presentation
29. Submit two diagrams: (1) Current data flow and (2) Proposed real-time pipeline
30. Include a short explanation document covering:
31. Data problems
32. Justification for the proposed solution
33. Sample visualizations or dashboards (mockups only)

 To fully be guided, follow the instructions below:

1. Access the appropriate templates  [here](https://docs.google.com/document/d/1bcHvH_Xo-6-hzKI0QPPBNUATzujPmdbBOnh9yHeWMB8/copy). Notice that all the specialization tasks are included here. This is for you to also know how your tasks are interconnected.
2. After reading all the tasks, remove those which you won’t be working on.
3. Retain the Intellectual Property Notice page.
4. Note that the templates contain guide questions. The tools for each task have been provided in the previous week. You may explore these tools when appropriate for your diagramming task.
5. Follow the naming convention: MO-IT151 Milestone 1: Draft `<Section>` `<Group Number.>` E.g., MO-IT151 Milestone 1: Draft  A1101 Group #6
6. Submit the link to your copy of this template. This will serve as your submission for this week, where your mentor is expected to make comments on your initial draft.
7. Make sure that the link you will submit is an appropriate one and is accessible to anyone from MMDC can comment. Erroneous link, placeholders, or inaccessible links are considered as non-submission.

---

## Networking and Cybersecurity Architecture Template

Task Title: Finalized Network Diagram with Firewall, Security, and Performance-Enhancing Measures
Platform Context: FinMark – Financial Technology Platform
Target Output: Two Network Diagrams (Current + Proposed) + Short Explanation (Slides)

### Part 1: Current Network Infrastructure

1. Describe the assumed current network setup. [Assume a basic but realistic architecture for a SaaS platform handling sensitive financial data — you may draw inspiration from platforms like AWS-hosted applications or basic enterprise setups.]
   Guide Questions:

 What devices or components are likely present (e.g., routers, firewalls, DNS, CDN, internal servers)?
 What cloud or hosting services might be used?
 How does data flow from the external internet to the internal system?

2. Include Diagram 1: Current Network Architecture
   (Attach or draw your current network infrastructure—use symbols for routers, firewalls, servers, etc.)

 Clearly label external sources (e.g., user browser, mobile app)
 Indicate the flow of data (arrows from request to database, etc.)

3. Analyze weak points in the current design.
   Guide Questions:

 Are there any single points of failure?
 Are there areas vulnerable to cyberattacks (e.g., open ports, unprotected APIs)?
 Where could performance degrade under heavy traffic?
 Are internal and external traffic segmented properly?
 Are any components handling sensitive data compliant with local and/or global data privacy laws?

Add notes directly beside diagram components or in bullet format below the diagram.

### Part 2: Proposed Network Architecture

4. Design an improved version of the network.
   Guide Questions:

 What new security layers or firewalls will be added?
 Will you use load balancers or CDNs to improve performance?
 How will the system handle internal vs. external requests?
 Will VPNs or DMZs be used for secure admin access?

5. Include Diagram 2: Proposed Network Design
   (Create a clear diagram of the new layout, labeling all components and data flow paths.)

 Show improvements in traffic routing, failover setup, or content delivery
 Use standard network diagram symbols (firewalls, switches, servers, cloud, etc.)

6. Document key decisions and rationale.
   For each improvement made, explain:

 What issue it solves (security, performance, reliability)
 Why this design is better for the platform’s needs

### Part 3: Final Output for Presentation

 Diagram 1: Current Network Setup (with labels and analysis)
 Diagram 2: Proposed Network Architecture (with improvements clearly marked)
 Short written explanation in pdf/deck (bullets or 3–5 slides) describing:
   Major vulnerabilities/bottlenecks
   Key design changes
   How your design improves security, performance, or reliability
   You may use tools like Lucidchart, Draw.io, Cisco Packet Tracer (for simulation), or PowerPoint shapes to create your diagrams

To be presented on: Week 4 synchronous session
