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
<img width="534" height="291" alt="image" src="https://github.com/user-attachments/assets/b21b5948-2a93-4207-bc98-3dc189226837" />


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


<img width="1138" height="403" alt="image" src="https://github.com/user-attachments/assets/45757c63-3a5d-4456-a57f-5d7cfef38eec" />

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

<img width="703" height="408" alt="image" src="https://github.com/user-attachments/assets/aad22f40-24c1-4af5-bb73-86ec73defca3" />

<img width="611" height="369" alt="image" src="https://github.com/user-attachments/assets/beec72de-3078-4fd5-bd88-7f1750096b13" />

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


<img width="1355" height="642" alt="image" src="https://github.com/user-attachments/assets/0d378ba9-9973-4515-a758-30a80cc2970a" />

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
    message: "SUCCESS: ${JOB_NAME} #${BUILD_NUMBER}"
)
```

A failed build can send a failure notification:

```groovy
slackSend(
    channel: '#jenkins',
    message: "FAILED: ${JOB_NAME} #${BUILD_NUMBER}"
)
```

Slack notifications provide quick visibility into the Jenkins build status.

<img width="1266" height="482" alt="image" src="https://github.com/user-attachments/assets/dbbfc35d-24f9-4e76-8488-c51f00bbd3c1" />


---

## 11. Email Notifications

Email notifications are configured to notify users about successful or failed builds.

Example successful build notification:

```groovy
emailext(
    subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    body: "Build completed successfully.",
    to: "tanushirana081@gmail.com"
)
```

Example failed build notification:

```groovy
emailext(
    subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    body: "Build failed. Please check the Jenkins console output.",
    to: "tanushirana081@email.com"
)
```

Replace the recipient email address with the required email address.

<img width="1118" height="345" alt="image" src="https://github.com/user-attachments/assets/37956d88-540c-43c5-b55f-9a25f43034c1" />

---


## Conclusion

This assignment implements a complete Declarative CI pipeline for a Java project using Jenkins.

The pipeline provides automated code checkout, parallel stability, quality and coverage checks, report generation, manual approval, artifact publication, and Slack and email notifications.

The parameterized build allows users to skip individual scans when required, while the approval stage ensures that artifacts are published only after explicit authorization.
