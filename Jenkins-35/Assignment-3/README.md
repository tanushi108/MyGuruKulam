<img width="1364" height="409" alt="image" src="https://github.com/user-attachments/assets/817a4e56-b48d-4f1b-8f69-28ce278ed08b" /># Assignment - 03: CI Checks Using Jenkins

# 1. Requirements

The assignment requires the following CI activities:

* Create separate Jenkins jobs for each repository and CI check.
* Configure Jenkins jobs to pull source code from GitHub.
* Perform generic and advanced CI checks.
* Perform credential/security scanning.
* Perform unit testing.
* Generate code coverage reports.
* Perform dependency checks.
* Store reports in Jenkins.
* Manage and archive build artifacts.
* Configure failure notifications.
* Configure Email and Slack notifications.
* Use local or remote storage for artifacts.

---

# 2. Jenkins Jobs

Separate Jenkins jobs are created for the different CI checks.

A typical job structure is:

```text
Assignment-03
│
├── Python
│   ├── Credential-Scan
│   ├── Unit-Testing
│   ├── Code-Coverage
│   └── Dependency-Check
│
├── Go
│   ├── Credential-Scaning
│   ├── Unit-Testing
│   ├── Code-Coverage
│   └── Dependency-Check
│
└── Java
    ├── Credential-Scan
    ├── Unit-Test
    ├── Code-Coverage
    └──  Dependency-Check
    
```

<img width="1364" height="409" alt="image" src="https://github.com/user-attachments/assets/fd91c955-c036-4035-a979-5ed1d334f2dc" />



# 3. Python CI Checks

Repository:

```text
https://github.com/OT-MICROSERVICES/attendance-api
```

The Python project is checked using multiple CI stages.

## 3.1 Credential Scanning

Credential scanning is performed to detect accidentally committed secrets such as:

* API keys
* Passwords
* Access tokens
* Private keys
* Cloud credentials
* Database credentials

Gitleaks can be used for credential scanning.

Example:

```bash
gitleaks detect \
  --source . \
  --redact \
  --report-format json \
  --report-path gitleaks-report.json \
  --exit-code 1
```
<img width="1130" height="546" alt="image" src="https://github.com/user-attachments/assets/e8ff351c-1454-45c4-81a4-e3dcfb56d092" />


---

## 3.2 Unit Testing

Python unit tests are executed using the project's configured testing framework.

Example:

```bash
poetry run pytest -v \
    --junitxml="$WORKSPACE/test-results.xml" \
    --cov=. \
    --cov-report=html:"$WORKSPACE/htmlcov" \
    --cov-report=term
```


<img width="1355" height="549" alt="image" src="https://github.com/user-attachments/assets/e87242d6-ad3f-438f-b231-c02e3274c9a5" />

---

## 3.3 Code Coverage

Code coverage is generated to determine how much of the application source code is executed by the tests.

Example:

```bash
poetry run pytest \
  --cov=. \
  --cov-report=xml:coverage.xml \
  --cov-report=html:htmlcov \
  --junitxml=report.xml \
  --ignore=client/tests/test_postgres_conn.py \
  --ignore=client/tests/test_redis_conn.py
```

The generated reports can include:

```text
coverage.xml
htmlcov/
```

<img width="1140" height="530" alt="image" src="https://github.com/user-attachments/assets/bd6ce252-bb1d-4c1c-a5ba-643d1b59b2de" />


---

## 3.4 Dependency Check

Python dependencies are checked to identify outdated or vulnerable packages.

If a dependency contains a critical vulnerability, the build can be configured to fail.

<img width="1328" height="591" alt="image" src="https://github.com/user-attachments/assets/d8796037-198c-46c6-8a73-14b1a1bf7a06" />

---

# 4. Go CI Checks

Repository:

```text
https://github.com/OT-MICROSERVICES/employee-api
```

The Go project is checked using standard Go CI tools.

## 4.1 Credential Scanning

Gitleaks is used to scan the repository for accidentally committed credentials.

Example:

```bash
gitleaks detect \
  --source . \
  --redact \
  --report-format json \
  --report-path reports/gitleaks-report.json
```
<img width="1184" height="620" alt="image" src="https://github.com/user-attachments/assets/24dce8a2-bc1e-48aa-87e1-e3033e7401f3" />


---

## 4.2 Unit Testing

Go unit tests are executed using:

```bash
go test -v ./... 2>&1 | tee reports/go-test-output.txt | \
    "$(go env GOPATH)/bin/go-junit-report" \
    > reports/junit-report.xml
```

The command executes tests across the Go packages in the project.

<img width="1206" height="588" alt="image" src="https://github.com/user-attachments/assets/bf008038-2d9e-4107-9602-7ea281053a79" />


---

## 5.3 Code Coverage

Go coverage can be generated using:

```bash
go tool cover -func=reports/coverage.out | tee reports/coverage-summary.txt
```

A human-readable coverage report can be generated using:

```bash
go tool cover \
    -html=reports/coverage.out \
    -o reports/coverage.html
```

The following files can be archived in Jenkins:

```text
coverage.out
coverage.html
```

<img width="1125" height="581" alt="image" src="https://github.com/user-attachments/assets/d9abe1eb-767a-49cf-9c41-869c676d38bd" />

---


## 4.5 Dependency Check

The dependency list can be checked using:

```bash
go list -m all > dependency-report.txt
```
<img width="1293" height="577" alt="image" src="https://github.com/user-attachments/assets/2ba11b57-405e-4985-b98f-f105564d1689" />


---

# 5. Java CI Checks

Repository:

```text
https://github.com/opstree/spring3hibernate.git
```

The Java application uses Maven for building and testing.

---

## 5.1 Credential Scanning

The Java repository is scanned for exposed credentials using Gitleaks.

Example:

```bash
gitleaks detect \
  --source . \
  --redact \
  --report-format json \
  --report-path gitleaks-report.json \
  --exit-code 0
```

The Jenkins build fails if credentials or secrets are detected according to the configured Gitleaks rules.

<img width="1205" height="604" alt="image" src="https://github.com/user-attachments/assets/2653bbbf-cf81-48fd-82a4-8ea99ace2d43" />


---


## 5.2 Unit Testing

Maven executes the project's unit tests using:

```bash
mvn test
```

Maven normally generates test reports under:

```text
target/surefire-reports/*.xml
```

These reports can be published in Jenkins using the JUnit publisher.

<img width="1308" height="617" alt="image" src="https://github.com/user-attachments/assets/ba1ce41e-c019-4d9a-bd77-c3b23ca63804" />

---

## 5.3 Code Coverage

JaCoCo is used for Java code coverage.

Example:

```bash
mvn test
mvn org.jacoco:jacoco-maven-plugin:0.8.13:report
```

The generated report is generally available under:

```text
target/site/jacoco/
```

The complete JaCoCo report can be archived in Jenkins.

---

## 5.5 Dependency Check

The Java project's Maven dependencies can be checked for known vulnerabilities.

The generated dependency-check report can be stored as a Jenkins artifact.

<img width="1241" height="580" alt="image" src="https://github.com/user-attachments/assets/2ca83509-f02c-4c76-9456-087ea0709703" />


---
# 7. Report Management

Reports generated during CI execution are stored in Jenkins.

Common reports include:

```text
Unit Test Reports
Code Coverage Reports
Dependency Reports
Credential Scan Results
SonarQube Analysis
Static Analysis Reports
```

Examples of generated report locations:

### Python

```text
coverage.xml
htmlcov/
```

### GoLang

```text
coverage.out
coverage.html
```

### Java

```text
target/surefire-reports/
target/site/jacoco/
target/dependency-check-report.html
```

---


# 8. Failure Notifications

Jenkins is configured to send notifications when CI checks fail.

Notifications can be sent through:

* Email
* Slack

The notification should contain useful build information such as:

```text
Job Name
Build Number
Build Status
Build URL
```

---

# 9. Email Notification

Email notifications are configured using Jenkins email plugins such as Email Extension Plugin.

A failure notification can contain:

```text
Subject:
FAILED:  $JOB_NAME #$BUILD_NUMBER

Message:

Hello Team,

Job Name: $JOB_NAME
Build Number: #$BUILD_NUMBER
Build Status: $BUILD_STATUS

Please check the Jenkins console output for details.

Build URL: $BUILD_URL

The automated CI checks and test execution have been completed.

Regards,
Jenkins CI
```

Email notifications are configured to trigger when a CI job fails.

<img width="778" height="472" alt="image" src="https://github.com/user-attachments/assets/0579e29f-0a69-4203-943d-3b0886f10218" />


---

# 10. Slack Notification

Slack notifications are configured using the Jenkins Slack Notification plugin.

Slack notifications provide quick visibility of failed builds.

<img width="1309" height="549" alt="image" src="https://github.com/user-attachments/assets/fcf6bd7b-1cfe-4924-9f03-ce2d354326ef" />

---

# CI Workflow

The overall CI workflow is:

```text
GitHub Repository
        |
        v
Jenkins Job
        |
        v
Checkout Source Code
        |
        v
Credential Scan
        |
        v
Build / Compile
        |
        v
Unit Testing
        |
        v
Code Coverage
        |
        v
Dependency / Security Check
        |
        v
Code Quality Analysis
        |
        v
Generate Reports
        |
        v
Archive Reports / Artifacts
        |
        v
Success / Failure Notification
```

---


# 20. Conclusion

Assignment-03 demonstrates the implementation of a Jenkins-based Continuous Integration system for Python, GoLang, and Java repositories.

The CI process automatically retrieves source code from GitHub, performs security and quality checks, executes tests, generates coverage and dependency reports, stores reports in Jenkins, manages build artifacts, and sends notifications when failures occur.

This setup improves software quality by detecting security, dependency, testing, coverage, and code-quality issues early in the development lifecycle.
