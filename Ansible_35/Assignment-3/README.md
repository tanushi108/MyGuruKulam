# Assignment-3_Ansible




## Syntax Check

Always validate the playbook before execution:

```bash
ansible-playbook -i inventory site.yml --syntax-check
```

Expected result:

```text
playbook: site.yml
```
<img width="1108" height="116" alt="image" src="https://github.com/user-attachments/assets/bf970e6e-d643-4d25-ab3d-7cc151eb2473" />


## Test Connectivity

```bash
ansible app -i inventory -m ping
```

<img width="1271" height="314" alt="image" src="https://github.com/user-attachments/assets/7b1f5d65-9c56-4fce-b4fc-c0ce8d8c2ab5" />

---

## 1. Update Package Repository

The playbook updates the APT package cache before installing the required software.

```
TASK [Update apt cache]
```

## 2. Install Required Packages

The following packages are installed automatically:

* Git
* Maven
* OpenJDK 11
* MySQL Server
* Python MySQL client
* wget
* tar

```
TASK [ Install required packages]
```
<img width="1324" height="257" alt="image" src="https://github.com/user-attachments/assets/d94da13a-495a-43fd-88b2-ee9fcfb817a0" />
 
## 3. Check Java version

```
TASK [ Check Java version ]
TASK [ Display Java version ]
```
### 4. Check Maven Version

```
TASK [ Check Maven version ]
TASK [ Display Maven version ]
```

<img width="1126" height="546" alt="image" src="https://github.com/user-attachments/assets/ac9bdf20-f7d0-44c1-bc1d-575ffa794b63" />

## 5. Install and Configure MySQL

MySQL Server is installed and enabled as a system service.

The playbook creates the application database:

```text
spring3hibernate
```

```
TASK [ Start and enable MySQL ]
```


## 6. Create Tomcat User

```
TASK [ Create Tomcat user ]
TASK [ Create Tomcat base directory ]
```

## 7. Install Apache Tomcat

The assignment requires:

```text
Apache Tomcat 7.0.108
```

The playbook downloads the official Tomcat archive and extracts it to:

```text
/opt/tomcat/apache-tomcat-7.0.108
```

Tomcat ownership is assigned to the `tomcat` user and group.

```
TASK [ Download Tomcat 7.0.108 ]
TASK [ Extract Tomcat ]
TASK [ Set Tomcat ownership ]
```

<img width="1268" height="365" alt="image" src="https://github.com/user-attachments/assets/100d9737-b28a-46a2-a3c0-07d6b2348ae3" />

<img width="1273" height="232" alt="image" src="https://github.com/user-attachments/assets/868d0dc0-7e3d-4c10-98ee-dc00f4ac436f" />


## 8. Clone Spring3HibernateApp

The application source code is cloned from:

```text
https://github.com/opstree/spring3hibernate.git
```

The application is stored at:

```text
/opt/spring3hibernate
```

```
TASK [ Clone Spring3Hibernate repository ]
```

```
TASK [ Update Java source version in pom.xml ]
TASK [ Update Java target version in pom.xml ]

```

<img width="1113" height="189" alt="image" src="https://github.com/user-attachments/assets/79f002fc-ae44-4324-91c6-d42f7cfe048f" />

---

## 9. Build the Application

The application is built using:

```bash
mvn clean package
```

```
TASK [ Build Spring3Hibernate WAR ]
```

<img width="1320" height="491" alt="image" src="https://github.com/user-attachments/assets/62bcd25f-9d2e-41b0-b684-ee0da972ed7f" />


## 10. Deploy WAR File

```
TASK [ Deploy Spring3Hibernate WAR ]
```
---

## 11. Create Tomcat Service

The playbook creates:

```text
/etc/systemd/system/tomcat.service
```

```
TASK [ Create Tomcat systemd service ]
```
<img width="932" height="107" alt="image" src="https://github.com/user-attachments/assets/0db04f81-c0d2-4a96-8949-658faa2b5ed6" />

---

## 12. Restart Tomcat and check status

After deployment, Tomcat is restarted using Ansible:

```
TASK [ Restart and enable Tomcat ]
TASK [ Check Tomcat status ]
TASK [ Display Tomcat status ]
```

<img width="876" height="247" alt="image" src="https://github.com/user-attachments/assets/8cb8ea52-f9b1-4549-a05b-724dddd4d931" />


## Verify WAR Deployment

```
TASK [ Check deployed WAR ]
TASK [ Verify WAR deployment ]
```

<img width="1045" height="246" alt="image" src="https://github.com/user-attachments/assets/4a568ce7-3785-424b-93e9-60db35ce554d" />



