# Linux-SysAdmin-and-Automation Implemented Scenarios
All scenarios were developed and tested in a controlled virtualization environment to simulate a real-world headless server deployment.
- Virtualization Platform: Oracle VM VirtualBox.

- Operating System: Linux Ubuntu Server.

- Interface: No Graphical User Interface (GUI-less/Headless). All administration was performed strictly via the Command Line Interface (CLI).

- Access Method: Local terminal and remote SSH (Secure Shell) for administrative tasks.
## 1. User Management & Group RBAC

Created new users and a departmental hierarchy to manage access levels for different organizational units.
- Departments: HR, Networking, IT, and Economics.

  <img width="205" height="96" alt="image" src="https://github.com/user-attachments/assets/17cfea2d-8146-4278-8a5b-415d0c30df0b" />

  <img width="731" height="115" alt="image" src="https://github.com/user-attachments/assets/e9e4db02-0340-438e-b64c-59e7e4114222" />

- Provisioning: Users were assigned unique UIDs (e.g., stefan: 1001) and specific primary groups.

  <img width="286" height="164" alt="image" src="https://github.com/user-attachments/assets/cbc2762d-2217-4c8c-88e5-6f16a90dac43" />
  
- Security: Enforced a default password (12345) for initial setup and implemented a Password Policy:
  - Expiration: Passwords must be changed every 30 days using chage -M 30.

    <img width="597" height="219" alt="image" src="https://github.com/user-attachments/assets/edfb88c2-24e8-488f-837d-0f61566b041b" />

## 2. File System Security & Permissions
Configured strict directory access to prevent unauthorized data leakage.
- Departmental Isolation: Folders like /home/Firma/data/hr_files were locked down to their respective groups using chmod 770 and chown :hr.
- The Public Shared Folder:
  - Created a /Public directory accessible to all.
  - Sticky Bits & SGID: Implemented specific permissions so that while all can read, only the HR group can write or delete.
    
    <img width="447" height="51" alt="image" src="https://github.com/user-attachments/assets/513117be-bb40-477f-91b5-519f8eedee91" />

  - Used SGID (chmod g+s) to ensure files created in the shared folder inherit the group ownership of the directory, facilitating team     collaboration.

    
    <img width="514" height="153" alt="image" src="https://github.com/user-attachments/assets/f1397131-fa94-46f8-bcf4-76f4a38b5251" />

## 3. SSH isolation
- Cofigured sshd_config to allow users "stefan" and "walkorion" to log in via SSH.
- Users from HR and another department are restricted to local terminal access only

  <img width="911" height="591" alt="image" src="https://github.com/user-attachments/assets/0f357fea-4637-4476-a1fe-edab3a9f9d57" />

  <img width="868" height="768" alt="image" src="https://github.com/user-attachments/assets/b709d6be-8ff6-4bc4-898c-545c6d6ba0a3" />

- Audit Logging: Practiced active monitoring of authentication attempts using tail -f /var/log/auth.log.

  <img width="1282" height="275" alt="image" src="https://github.com/user-attachments/assets/777e7b19-e343-4fd7-a150-fdd358619ef4" />

## 4. Backup Automation & Data Integrity
Developed an automated disaster recovery solution to protect critical HR data.
- Created Backup folder

  <img width="738" height="405" alt="image" src="https://github.com/user-attachments/assets/0edd74ad-8f27-47a0-bb6e-96b049dfa56c" />

- The Script: Created backup_hr.sh located in /home/walkorion/Scripts/.

  <img width="848" height="411" alt="image" src="https://github.com/user-attachments/assets/8943373e-82d1-4038-bc34-5b832d7b6d67" />

- Functionality:
  - Archiving: Uses tar with gzip compression to save disk space.
  - Cleanup: Automatically identifies and deletes backups older than 7 days using the find command. 
- Scheduling:
  - Cron: Scheduled for nightly execution at 02:00 AM.

  <img width="917" height="441" alt="image" src="https://github.com/user-attachments/assets/2df11899-6c64-484c-8f7d-1f930c10d105" />

## 5. Restore functionality (TBA)

## 🖥️ Scenario: System Health Monitoring & Nginx Integration
Designed and deployed a custom Linux service to track system uptime and verify that the server is "alive" after every reboot.
- Developed myscript.sh, a Bash script that appends a "System is Live" timestamp to a dedicated log file.

  <img width="735" height="66" alt="image" src="https://github.com/user-attachments/assets/9a85a1e5-e4d8-43a6-a567-8c00f4917fe0" />

- Applied executable permissions using chmod +x to ensure the system can run the script.
- Created a unit file in /etc/systemd/system/ using the ExecStart directive to point to the script location.

  <img width="874" height="164" alt="image" src="https://github.com/user-attachments/assets/5719f54f-b0fc-41b6-a6c1-ac35f3d75f18" />

- Deployment
  - Initialized the configuration using systemctl daemon-reload.
  - Enabled the service with systemctl enable to ensure it triggers automatically on every system boot.
  - Verified the operational status using systemctl status.

    <img width="952" height="363" alt="image" src="https://github.com/user-attachments/assets/e04d61d8-67b0-4862-9d6b-5879a47ed538" />

- Nginx Integration & Web Exposure - Extended the monitoring service by making the logs accessible via a web browser using the Nginx web server.
  - Leveraged a pre-configured Nginx instance to serve system status data.

    <img width="1118" height="395" alt="image" src="https://github.com/user-attachments/assets/c86b7d42-d6eb-41ae-be16-1dbe1600450a" />

    
  - Created a symbolic link (symlink) between the service log file and the Nginx web root (/var/www/html/logs.html).

    <img width="816" height="129" alt="image" src="https://github.com/user-attachments/assets/b9cee076-4f53-4f08-93fc-ce912510ac74" />

    <img width="574" height="39" alt="image" src="https://github.com/user-attachments/assets/08c65d7a-bd52-4525-baa1-0ab8922a7733" />


       
