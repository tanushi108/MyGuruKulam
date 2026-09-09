# Assignment 4 – Declarative CI Pipeline for Java Project

## Objective

Create a Jenkins Declarative CI Pipeline for a Java-based project that performs multiple Continuous Integration checks and provides controlled artifact publication.

The pipeline includes:

* Code Checkout
* Code Stability Analysis
* Code Quality Analysis
* Code Coverage Analysis
* Parallel execution of CI checks
* Quality and Coverage Report Generation
* Artifact Publishing
* Manual Approval before publishing artifacts
* Slack Notifications
* Email Notifications
* Parameters to skip individual scans
* Success and failure notifications

---

## Pipeline Stages

### 1. Code Checkout

The pipeline first checks out the source code from the configured Git repository.

The checkout stage ensures that the latest source code is available in the Jenkins workspace before performing any CI checks.


---

### 2. User Parameters

The pipeline provides parameters that allow the user to include individual scans during build execution.

<img width="683" height="408" alt="image" src="https://github.com/user-attachments/assets/630e975a-51be-4ae6-aa35-121a9932aa29" />


---

## 3. Parallel CI Checks

The following checks are executed in parallel:

* Code Stability
* Code Quality
* Code Coverage

<img width="896" height="292" alt="image" src="https://github.com/user-attachments/assets/dbe47b8c-d221-49a0-b335-5b019c825309" />


---

## 4. Code Stability Analysis

The Code Stability stage verifies that the Java application is working correctly by running the project's test cases.

Maven can be used to execute the tests:

```bash
mvn test
```

This stage helps identify:

* Failed test cases
* Runtime errors
* Regression issues
* Application stability problems

<img width="1298" height="631" alt="image" src="https://github.com/user-attachments/assets/02c6164d-d6e0-484c-909f-53529dc1895b" />

---

## 5. Code Quality Analysis

SonarQube is used to perform static code quality analysis.

Example Maven command:

```bash
mvn sonar:sonar
```

SonarQube can detect:

* Bugs
* Vulnerabilities
* Code smells
* Duplicated code
* Maintainability issues
* Reliability issues

<img width="1281" height="498" alt="image" src="https://github.com/user-attachments/assets/2ddadeca-6802-4614-993e-587c3780ac29" />


<img width="1343" height="577" alt="image" src="https://github.com/user-attachments/assets/2c8bda6f-4881-4bd1-8e48-ac5c1bcf6479" />



---

## 6. Code Coverage Analysis

JaCoCo is used to generate the code coverage report.

Example:

```bash
mvn test jacoco:report
```

The report is normally generated under:

```text
target/site/jacoco/
```

The coverage report can contain:

* Line coverage
* Branch coverage
* Method coverage
* Class coverage
* Instruction coverage

<img width="1298" height="569" alt="image" src="https://github.com/user-attachments/assets/6799e734-1d88-4962-9083-d1152b18560c" />

---

## 7. Generate Reports

After the CI checks are completed, Jenkins generates and publishes the available reports.

### JUnit Report

```groovy
junit(
    testResults: 'target/surefire-reports/*.xml',
    allowEmptyResults: true
)
```

### JaCoCo HTML Report

```groovy
publishHTML([
    allowMissing: true,
    alwaysLinkToLastBuild: true,
    keepAll: true,
    reportDir: 'target/site/jacoco',
    reportFiles: 'index.html',
    reportName: 'JaCoCo Coverage Report'
])
```

The reports allow developers to review test results, code coverage, and code quality.


---

## 8. Manual Approval

Before publishing artifacts, the pipeline pauses and asks the user for approval.

Example:

```groovy
stage('Approval') {
    steps {
        input(
            message: 'Approve artifact publication?',
            ok: 'Approve'
        )
    }
}
```

The artifact publishing stage is executed only after the user approves the publication.

If the user denies or aborts the approval, the publication does not take place.

---

## 9. Publish Artifacts

After approval, Jenkins publishes the generated build artifacts.

For a Maven Java project, the artifact can be a JAR or WAR file.

Example:

```groovy
stage('Publish Artifacts') {
    steps {
        archiveArtifacts(
            artifacts: 'target/*.jar',
            fingerprint: true
        )
    }
}
```

The artifacts can then be accessed from the Jenkins build page.

---

## 10. Slack Notifications

Slack notifications are configured to inform users about the pipeline result.

A successful build can send a success notification:

```groovy
slackSend(
    channel: '#jenkins',
    message: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
)
```

A failed build can send a failure notification:

```groovy
slackSend(
    channel: '#jenkins',
    message: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
)
```

Slack notifications provide quick visibility into the Jenkins build status.

---

## 11. Email Notifications

Email notifications are configured to notify users about successful or failed builds.

Example successful build notification:

```groovy
emailext(
    subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    body: "Build completed successfully.",
    to: "recipient@example.com"
)
```

Example failed build notification:

```groovy
emailext(
    subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    body: "Build failed. Please check the Jenkins console output.",
    to: "recipient@example.com"
)
```

Replace the recipient email address with the required email address.

---

## 12. Build Parameters

When the user selects **Build with Parameters**, Jenkins provides options to skip scans.

### Run all scans

```text
SKIP_STABILITY = false
SKIP_QUALITY   = false
SKIP_COVERAGE  = false
```

All CI checks are executed.

### Skip Code Quality

```text
SKIP_STABILITY = false
SKIP_QUALITY   = true
SKIP_COVERAGE  = false
```

The Code Quality stage is skipped.

### Skip Code Coverage

```text
SKIP_STABILITY = false
SKIP_QUALITY   = false
SKIP_COVERAGE  = true
```

The Code Coverage stage is skipped.

---

## 13. Jenkinsfile

A basic implementation of the pipeline is shown below:

```groovy
pipeline {

    agent any

    parameters {

        booleanParam(
            name: 'SKIP_STABILITY',
            defaultValue: false,
            description: 'Skip code stability analysis'
        )

        booleanParam(
            name: 'SKIP_QUALITY',
            defaultValue: false,
            description: 'Skip code quality analysis'
        )

        booleanParam(
            name: 'SKIP_COVERAGE',
            defaultValue: false,
            description: 'Skip code coverage analysis'
        )
    }

    stages {

        stage('Code Checkout') {
            steps {
                checkout scm
            }
        }

        stage('CI Checks') {

            parallel {

                stage('Code Stability') {
                    when {
                        expression {
                            !params.SKIP_STABILITY
                        }
                    }

                    steps {
                        sh 'mvn test'

                        junit(
                            testResults: 'target/surefire-reports/*.xml',
                            allowEmptyResults: true
                        )
                    }
                }

                stage('Code Quality') {
                    when {
                        expression {
                            !params.SKIP_QUALITY
                        }
                    }

                    steps {
                        withSonarQubeEnv('SonarQube') {
                            sh 'mvn sonar:sonar'
                        }
                    }
                }

                stage('Code Coverage') {
                    when {
                        expression {
                            !params.SKIP_COVERAGE
                        }
                    }

                    steps {
                        sh 'mvn test jacoco:report'
                    }
                }
            }
        }

        stage('Generate Reports') {
            steps {
                publishHTML([
                    allowMissing: true,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'target/site/jacoco',
                    reportFiles: 'index.html',
                    reportName: 'JaCoCo Coverage Report'
                ])
            }
        }

        stage('Approval') {
            steps {
                input(
                    message: 'Approve artifact publication?',
                    ok: 'Approve'
                )
            }
        }

        stage('Publish Artifacts') {
            steps {
                archiveArtifacts(
                    artifacts: 'target/*.jar',
                    fingerprint: true
                )
            }
        }
    }

    post {

        success {

            slackSend(
                channel: '#jenkins',
                message: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
            )

            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build completed successfully.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
Result: SUCCESS

Artifacts have been published.
""",
                to: "recipient@example.com"
            )
        }

        failure {

            slackSend(
                channel: '#jenkins',
                message: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
            )

            emailext(
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build failed.

Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
Result: FAILURE

Please check the Jenkins console output.
""",
                to: "recipient@example.com"
            )
        }

        aborted {

            slackSend(
                channel: '#jenkins',
                message: "ABORTED: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
            )
        }
    }
}
```

---

## 14. Jenkins Configuration

### Maven

Configure Maven from:

```text
Manage Jenkins
→ Tools
→ Maven installations
```

Make sure the configured Maven installation is available to the Jenkins agent.

### JDK

Configure the required Java version from:

```text
Manage Jenkins
→ Tools
→ JDK installations
```

The Java version should be compatible with the project's `pom.xml`.

### SonarQube

Configure SonarQube from:

```text
Manage Jenkins
→ System
→ SonarQube servers
```

The name configured in Jenkins should match:

```groovy
withSonarQubeEnv('SonarQube')
```

### Slack

Configure the Slack notification integration and Jenkins credentials/token as required.

### Email

Configure SMTP and Extended E-mail Notification from:

```text
Manage Jenkins
→ System
```

---

## 15. Reports and Artifacts

The pipeline can generate the following files:

```text
target/
├── *.jar
├── surefire-reports/
│   └── *.xml
└── site/
    └── jacoco/
        └── index.html
```

### Reports

* JUnit – Unit test results
* JaCoCo – Code coverage
* SonarQube – Code quality analysis

### Artifacts

* JAR
* WAR
* Other build output files as required

---

## 16. Notification Conditions

### Successful Build

Slack and email notifications are sent when the pipeline completes successfully.

The notification confirms:

* Job name
* Build number
* Build status
* Artifact publication status

### Failed Build

Slack and email notifications are sent when a pipeline stage fails.

The notification informs the user that the build failed and asks them to check the Jenkins console output.

### Aborted Build

A Slack notification can also be sent when the pipeline is manually aborted.

---

## 17. Assignment Requirements

| Requirement                | Implementation               |
| -------------------------- | ---------------------------- |
| Declarative CI Pipeline    | Jenkins Declarative Pipeline |
| Java Project               | Maven-based Java project     |
| Code Checkout              | Git Checkout                 |
| Code Stability             | Maven/JUnit tests            |
| Code Quality               | SonarQube                    |
| Code Coverage              | JaCoCo                       |
| Parallel Execution         | Jenkins `parallel`           |
| Skip Scans                 | Boolean build parameters     |
| Report Generation          | JUnit/JaCoCo/SonarQube       |
| Artifact Publishing        | Jenkins `archiveArtifacts`   |
| Approval Before Publishing | Jenkins `input`              |
| Slack Notification         | `slackSend`                  |
| Email Notification         | `emailext`                   |
| Success Notification       | `post { success }`           |
| Failure Notification       | `post { failure }`           |

---

## Conclusion

This assignment implements a complete Declarative CI pipeline for a Java project using Jenkins.

The pipeline provides automated code checkout, parallel stability, quality and coverage checks, report generation, manual approval, artifact publication, and Slack and email notifications.

The parameterized build allows users to skip individual scans when required, while the approval stage ensures that artifacts are published only after explicit authorization.
