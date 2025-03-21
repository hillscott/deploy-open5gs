Open5GS is a software implementation of the 5G core network (5GC) and Evolved Packet Core (EPC) that allows cellular network operators to deploy 5G and 4G systems. Here’s an overview of the main components within Open5GS, each serving a specific function within the network architecture:

1. AMF (Access and Mobility Management Function)
- Purpose: The AMF is a core component in the 5G architecture that manages access and mobility aspects of the network. It handles connection and session management for user equipment (UE).
- Key Functions: It manages registration, authentication, session establishment, and mobility management. The AMF also interacts with other functions like SMF for session management and AUSF for authentication.

2. SMF (Session Management Function)
- Purpose: The SMF manages session-related operations in the 5G network.
- Key Functions: It is responsible for establishing, modifying, and releasing sessions. The SMF also allocates and manages IP addressing for UEs and decides on the routing of user plane data.

3. UPF (User Plane Function)
- Purpose: The UPF handles user data processing and routing in the network.
- Key Functions: It is involved in forwarding data packets between the data network and the UE. The UPF also performs traffic usage reporting to the SMF and supports packet inspection and QoS enforcement.

4. NRF (Network Repository Function)
- Purpose: The NRF supports service discovery functions within the network.
- Key Functions: It stores information about network function instances and their supported services. Other network functions query the NRF to discover the instances needed for network operations.

5. AUSF (Authentication Server Function)
- Purpose: The AUSF is responsible for authentication services in the network.
- Key Functions: It handles the authentication and security procedures for UEs connecting to the network. The AUSF works with the UDM to access subscriber authentication data.

6. UDM (Unified Data Management)
- Purpose: The UDM manages subscriber data and profiles.
- Key Functions: It stores and manages user identification, subscription, and session information. The UDM provides this information to other network functions like the AMF, SMF, and AUSF during network procedures.

7. PCF (Policy Control Function)
- Purpose: The PCF manages policy rules for controlling network resources.
- Key Functions: It provides policy rules to control traffic flow within the network, ensuring compliance with operator policies and supporting data flow efficiency.

8. UDR (Unified Data Repository)
- Purpose: The UDR serves as a storage point for structured data.
- Key Functions: It centralizes user and session data, making it accessible to other network functions as needed. This includes subscription data, policy data, and application data.

9. NSSF (Network Slice Selection Function)
- Purpose: The NSSF supports the operation of network slicing.
- Key Functions: It selects the appropriate network slice instances for incoming sessions based on subscription and policy data.

Additional Components
- WebUI: Open5GS includes a Web-based User Interface for monitoring and managing the UEs.
  - The web UI is not implemented as part of this deployment though. You can find more information on it in the [Open5GS Build Docs](https://open5gs.org/open5gs/docs/guide/02-building-open5gs-from-sources/) - See "Install the dependencies to run WebUI"
- CLI: Command Line Interface tools for detailed management and troubleshooting of the network.
  - The mongosh binary + the open5gs-dbctl script are used for UE management as part of this deployment.

These components are integral to the functioning of Open5GS, working together to provide flexible 5G and 4G network capabilities. This architecture allows for the dynamic management of network resources, high data throughput, and the ability to introduce new services efficiently.

![image](https://github.com/user-attachments/assets/5eff503a-513a-4463-8744-c3358c0abfbe)
(Note that HP's PacketRusher is used instead of UERANSIM)

More Background information on Open5gs and Docker can be found at the sources below:
- R. Zhang, Y. Lin, S. Chen and Z. Mo, "A Multi-Node 5G Core Network Testbed Developed from Open5GS," 2023 9th International Conference on Computer and Communications (ICCC), Chengdu, China, 2023, pp. 1038-1043, doi: 10.1109/ICCC59590.2023.10507325
- L. Mamushiane et al., "Towards Stress Testing Open5GS Core (UPF Node) On A 5G Standalone Testbed," 2023 IEEE AFRICON, Nairobi, Kenya, 2023, pp. 1-6, doi: 10.1109/AFRICON55910.2023.10293284
- [https://github.com/Borjis131/docker-open5gs.git](docker-open5gs git repo)
- [https://github.com/HewlettPackard/PacketRusher](HP PacketRusher git repo)
- [https://github.com/open5gs/open5gs](Open5gs - The original git repo)
- [https://open5gs.org/open5gs/docs/](Open5gs - Documentation)
