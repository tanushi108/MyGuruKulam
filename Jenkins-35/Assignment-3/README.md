# Assignment - 03: CI Checks Using Jenkins

## Objective

Perform Continuous Integration (CI) checks on three different API repositories using Jenkins. The objective is to automate code validation, security checks, testing, code coverage, dependency analysis, report generation, artifact management, and failure notifications.

The following repositories are used:

| Language | Repository                                         | Application      |
| -------- | -------------------------------------------------- | ---------------- |
| Python   | https://github.com/OT-MICROSERVICES/attendance-api | Attendance API   |
| GoLang   | https://github.com/OT-MICROSERVICES/employee-api   | Employee API     |
| Java     | https://github.com/opstree/spring3hibernate.git    | Spring3Hibernate |

---

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
│   ├── Python-Credential-Scan
│   ├── Python-Unit-Test
│   ├── Python-Code-Coverage
│   └── Python-Dependency-Check
│
├── GoLang
│   ├── Go-Credential-Scan
│   ├── Go-Unit-Test
│   ├── Go-Code-Coverage
│   └── Go-Dependency-Check
│
└── Java
    ├── Java-Credential-Scan
    ├── Java-Unit-Test
    ├── Java-Code-Coverage
    ├── Java-Dependency-Check
    └── Java-SonarQube
```

The exact number of jobs can be modified according to the CI requirements.

---

# 3. Source Code Management

GitHub is used as the source code management system.

The repositories configured in Jenkins are:

### Python

```text
https://github.com/OT-MICROSERVICES/attendance-api
```

### GoLang

```text
https://github.com/OT-MICROSERVICES/employee-api
```

### Java

```text
https://github.com/opstree/spring3hibernate.git
```

Each Jenkins job is configured to retrieve the source code from the corresponding GitHub repository before executing the CI checks.

---

# 4. Python CI Checks

Repository:

```text
https://github.com/OT-MICROSERVICES/attendance-api
```

The Python project is checked using multiple CI stages.

## 4.1 Credential Scanning

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
gitleaks detect --source . --no-banner
```

If secrets are detected, the Jenkins build fails.

---

## 4.2 Unit Testing

Python unit tests are executed using the project's configured testing framework.

Example:

```bash
pytest
```

The test result files can be stored and published in Jenkins.

---

## 4.3 Code Coverage

Code coverage is generated to determine how much of the application source code is executed by the tests.

Example:

```bash
pytest --cov=. --cov-report=xml --cov-report=html
```

The generated reports can include:

```text
coverage.xml
htmlcov/
```

These reports are archived in Jenkins for later access.

---

## 4.4 Dependency Check

Python dependencies are checked to identify outdated or vulnerable packages.

Depending on the project configuration, tools such as `pip-audit` can be used.

Example:

```bash
pip-audit
```

If a dependency contains a critical vulnerability, the build can be configured to fail.

---

# 5. GoLang CI Checks

Repository:

```text
https://github.com/OT-MICROSERVICES/employee-api
```

The Go project is checked using standard Go CI tools.

## 5.1 Credential Scanning

Gitleaks is used to scan the repository for accidentally committed credentials.

Example:

```bash
gitleaks detect --source . --no-banner
```

---

## 5.2 Unit Testing

Go unit tests are executed using:

```bash
go test ./...
```

The command executes tests across the Go packages in the project.

---

## 5.3 Code Coverage

Go coverage can be generated using:

```bash
go test ./... -coverprofile=coverage.out
```

A human-readable coverage report can be generated using:

```bash
go tool cover -html=coverage.out -o coverage.html
```

The following files can be archived in Jenkins:

```text
coverage.out
coverage.html
```

---

## 5.4 Static Analysis

Go static analysis can be performed using:

```bash
go vet ./...
```

This helps identify suspicious constructs and potential problems in the source code.

---

## 5.5 Dependency Check

Go dependencies are maintained through `go.mod` and `go.sum`.

The dependency list can be checked using:

```bash
go list -m all
```

Additional vulnerability scanning can be performed using suitable Go security tools such as:

```bash
govulncheck ./...
```

---

# 6. Java CI Checks

Repository:

```text
https://github.com/opstree/spring3hibernate.git
```

The Java application uses Maven for building and testing.

---

## 6.1 Credential Scanning

The Java repository is scanned for exposed credentials using Gitleaks.

Example:

```bash
gitleaks detect --source . --no-banner
```

The Jenkins build fails if credentials or secrets are detected according to the configured Gitleaks rules.

---

## 6.2 Build

The Maven project is compiled and packaged using:

```bash
mvn clean package
```

For a build without executing tests:

```bash
mvn clean package -DskipTests
```

The generated WAR file is stored as a Jenkins artifact.

Example:

```text
target/Spring3HibernateApp.war
```

---

## 6.3 Unit Testing

Maven executes the project's unit tests using:

```bash
mvn test
```

Maven normally generates test reports under:

```text
target/surefire-reports/
```

These reports can be published in Jenkins using the JUnit publisher.

---

## 6.4 Code Coverage

JaCoCo is used for Java code coverage.

Example:

```bash
mvn test
mvn jacoco:report
```

The generated report is generally available under:

```text
target/site/jacoco/
```

The complete JaCoCo report can be archived in Jenkins.

---

## 6.5 Dependency Check

The Java project's Maven dependencies can be checked for known vulnerabilities.

OWASP Dependency-Check can be integrated with Maven/Jenkins to scan project dependencies.

Example Maven command:

```bash
mvn org.owasp:dependency-check-maven:check
```

The generated dependency-check report can be stored as a Jenkins artifact.

---

## 6.6 SonarQube Analysis

SonarQube is used for static code quality analysis.

The Maven SonarQube scanner can be executed using:

```bash
mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
    -Dsonar.projectKey=Spring3Hibernate \
    -Dsonar.projectName=Spring3Hibernate
```

The SonarQube server is configured in Jenkins using the SonarQube installation configuration.

SonarQube can analyze:

* Bugs
* Vulnerabilities
* Code smells
* Duplicated code
* Maintainability
* Reliability
* Security
* Code coverage information

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

# 8. Jenkins Artifact Management

Build artifacts are archived in Jenkins after successful CI checks.

For the Java application, the WAR file is treated as the main build artifact.

Example:

```text
target/Spring3HibernateApp.war
```

Jenkins `archiveArtifacts` can be used to store artifacts.

Example:

```groovy
archiveArtifacts(
    artifacts: 'target/*.war',
    fingerprint: true
)
```

The `fingerprint` option allows Jenkins to track the artifact across builds and jobs.

---

# 9. Local Artifact Storage

Jenkins can store artifacts locally on the Jenkins controller or configured build node.

The artifacts are associated with the corresponding Jenkins build.

Example:

```text
Jenkins
  └── Job
      └── Build #1
          ├── Reports
          └── Artifacts
```

This method is suitable for assignment or small CI environments.

---

# 10. Remote Artifact Storage

For production environments, artifacts can be stored in remote artifact repositories or object storage.

Possible solutions include:

* AWS S3
* Nexus Repository
* JFrog Artifactory
* Google Cloud Storage
* Azure Blob Storage

Remote storage provides better scalability and persistence for large CI/CD environments.

---

# 11. Failure Notifications

Jenkins is configured to send notifications when CI checks fail.

Notifications can be sent through:

* Email
* Slack

The notification should contain useful build information such as:

```text
Job Name
Build Number
Build Status
Failed Stage
Build URL
```

---

# 12. Email Notification

Email notifications are configured using Jenkins email plugins such as Email Extension Plugin.

A failure notification can contain:

```text
Subject:
FAILED: <JOB_NAME> #<BUILD_NUMBER>

Message:

Jenkins CI Pipeline Failed.

Job: <JOB_NAME>
Build: <BUILD_NUMBER>
Status: FAILURE

Please check the Jenkins console output for details.

Build URL:
<BUILD_URL>
```

Email notifications are configured to trigger when a CI job fails.

---

# 13. Slack Notification

Slack notifications are configured using the Jenkins Slack Notification plugin.

Example failure message:

```text
FAILED: Python-Code-Coverage #15

The Jenkins CI check has failed.

Build URL:
http://localhost:8080/job/Python-Code-Coverage/15/
```

Slack notifications provide quick visibility of failed builds.

---

# 14. Failure Handling

The Jenkins jobs are configured so that a failed CI check causes the build to fail.

Examples:

```text
Credential Scan Failed
        ↓
Build Failed

Unit Test Failed
        ↓
Build Failed

Dependency Check Failed
        ↓
Build Failed

Code Quality Check Failed
        ↓
Build Failed
```

Failure notifications are then triggered through Email and Slack.

---

# 15. CI Workflow

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

# 16. Generic CI Checks

The following generic checks are implemented across the repositories where applicable:

* Git repository checkout
* Credential scanning
* Build validation
* Unit testing
* Static analysis
* Dependency checking
* Code coverage
* Report generation
* Artifact archiving
* Failure notification

These checks help identify problems before the application reaches later stages of the software delivery lifecycle.

---

# 17. Advanced CI Checks

Advanced checks include:

* SonarQube static code analysis
* OWASP Dependency-Check
* Gitleaks secret scanning
* JaCoCo code coverage
* Go static analysis
* Go vulnerability scanning
* Python dependency auditing
* Artifact fingerprinting
* Automated Slack notifications
* Automated Email notifications

---

# 18. Jenkins Plugins Used

The following Jenkins plugins/tools can be used for this assignment:

* Git Plugin
* Pipeline Plugin
* JUnit Plugin
* Email Extension Plugin
* Slack Notification Plugin
* SonarQube Scanner for Jenkins
* Credentials Plugin
* Workspace Cleanup Plugin
* HTML Publisher Plugin
* OWASP Dependency-Check Plugin, where applicable

External tools used include:

```text
Git
Jenkins
Maven
Java
Python
pytest
Gitleaks
Go
JaCoCo
SonarQube
OWASP Dependency-Check
pip-audit
govulncheck
```

---

# 19. Result

The CI setup successfully provides automated validation for three repositories:

### Python

```text
attendance-api
```

Checks include:

```text
Credential Scanning
Unit Testing
Code Coverage
Dependency Checking
```

### GoLang

```text
employee-api
```

Checks include:

```text
Credential Scanning
Unit Testing
Code Coverage
Static Analysis
Dependency/Vulnerability Checking
```

### Java

```text
spring3hibernate
```

Checks include:

```text
Credential Scanning
Maven Build
Unit Testing
JaCoCo Code Coverage
Dependency Checking
SonarQube Code Quality
```

Reports are stored and accessible from Jenkins, while application artifacts such as the WAR file are archived for future use.

Failure notifications are configured through Email and Slack to provide immediate information about unsuccessful CI checks.

---

# 20. Conclusion

Assignment-03 demonstrates the implementation of a Jenkins-based Continuous Integration system for Python, GoLang, and Java repositories.

The CI process automatically retrieves source code from GitHub, performs security and quality checks, executes tests, generates coverage and dependency reports, stores reports in Jenkins, manages build artifacts, and sends notifications when failures occur.

This setup improves software quality by detecting security, dependency, testing, coverage, and code-quality issues early in the development lifecycle.
