# Assignment 5: Scripted CI Pipeline for Java Project

## Objective

The objective of this assignment is to create a **Jenkins Scripted CI Pipeline** for a Java-based project.

The pipeline automates the complete Continuous Integration process, including:

* Code checkout
* Code stability analysis
* Code quality analysis
* Code coverage analysis
* Parallel execution of analysis stages
* Report generation
* User-configurable scan execution
* Manual approval before publishing
* Artifact publishing
* Slack notifications
* Email notifications
* Success and failure notifications

---

# Pipeline Stages

## 1. Code Checkout

The first stage checks out the source code from the Git repository.

This downloads the project source code into the Jenkins workspace.

```
https://github.com/opstree/spring3hibernate.git
```

---

# 2. User Parameters

The pipeline provides options to skip individual scans.

The following parameters can be used:

```text
RUN_STABILITY
RUN_QUALITY
RUN_COVERAGE
```


<img width="1362" height="378" alt="image" src="https://github.com/user-attachments/assets/db480e3d-a828-4f18-b724-5db020e37411" />



---

# 3. Parallel Analysis

The three analysis stages are independent, so they can execute simultaneously.

Jenkins Scripted Pipeline provides the `parallel` step for this purpose.

<img width="1365" height="376" alt="image" src="https://github.com/user-attachments/assets/68de5725-ace5-4d44-b926-123d1cb6e287" />


---

# 4. Code Stability Analysis

The Code Stability stage executes the project's automated tests.

Example:

```bash
mvn clean test -Dfindbugs.skip=true
```

JUnit tests verify whether the application is functioning correctly.

The stage helps identify:

* Test failures
* Application defects
* Regression issues
* Unstable code

If the tests fail, the pipeline can be marked as failed.

<img width="1360" height="601" alt="image" src="https://github.com/user-attachments/assets/b41f87bd-962d-41c0-b39d-257ff723b61c" />


---

# 5. Code Quality Analysis

The Code Quality stage performs static analysis using SonarQube.

Example:

```bash
mvn sonar:sonar
```

SonarQube can identify:

* Bugs
* Code smells
* Vulnerabilities
* Reliability issues
* Maintainability issues
* Security issues

---

# 6. Code Coverage Analysis

Code coverage determines how much of the source code is executed by automated tests.

JaCoCo can be used to generate the coverage report.

Example:

```bash
mvn test jacoco:report
```

The report can provide:

* Line coverage
* Branch coverage
* Method coverage
* Class coverage

Typical JaCoCo report location:

```text
target/site/jacoco/
```
<img width="1338" height="560" alt="image" src="https://github.com/user-attachments/assets/f0d624fc-5fe5-4c1f-8bec-7d898143b3b9" />

---

# 7. Generate Reports

After the parallel analysis stages are completed, the pipeline generates and publishes the available reports.

## JUnit Report

```groovy
junit 'target/surefire-reports/*.xml'
```
JUnit reports display:

* Total tests
* Passed tests
* Failed tests
* Skipped tests

<img width="794" height="321" alt="image" src="https://github.com/user-attachments/assets/8a65b389-c094-4ef6-a1d6-bec9e7a37495" />


## JaCoCo Report

The JaCoCo HTML report can be archived from:

```text
target/site/jacoco/**
```
<img width="620" height="364" alt="image" src="https://github.com/user-attachments/assets/96ee5d66-55d3-4f22-a9b0-2b1a21e26769" />

## SonarQube Report

SonarQube provides the quality analysis results through the SonarQube dashboard.

<img width="1365" height="525" alt="image" src="https://github.com/user-attachments/assets/4acbc463-e630-41a1-9cc8-de7f526be4e1" />

---

# 8. Approval Stage

Before publishing artifacts, the pipeline waits for manual approval.

The Scripted Pipeline uses the Jenkins `input` step.

Example:

```groovy
stage('Approval') {
    def approval = input(
        message: 'Approve artifact publication?',
        ok: 'Approve'
    )

    echo "Publication approved by: ${approval}"
}
```

The user can either:

* Approve the publication
* Abort/deny the publication

The artifact is **not published before approval**.

<img width="1185" height="602" alt="image" src="https://github.com/user-attachments/assets/b7e57b6b-9b23-4d1e-9e76-c6a733dc4b0c" />

---

# 9. Publish Artifacts

If the user approves the publication, the pipeline publishes the generated artifact.

For a Maven Java project, artifacts are generally generated inside:


```text
target/*.war
```

Example:

```groovy
stage('Publish Artifacts') {
    archiveArtifacts(
        artifacts: 'target/*.jar',
        fingerprint: true
    )
}
```

The artifact becomes available from the Jenkins build page.


<img width="1080" height="241" alt="image" src="https://github.com/user-attachments/assets/7738c128-11fe-41d8-a07c-ccbc2861c8f8" />

---

# 10. Slack Notification

Slack notifications inform the development team about the pipeline failure.


<img width="1321" height="435" alt="image" src="https://github.com/user-attachments/assets/bd6604f9-1689-4a65-a942-1c5ac385631b" />

---

# 11. Email Notification

Email notifications provide detailed pipeline status to the required recipients.

Example:

```groovy
emailext(
    subject: "Jenkins Build: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    body: "The Jenkins pipeline has failed.",
    to: "tanushirana875@gmail.com"
)
```


<img width="1070" height="327" alt="image" src="https://github.com/user-attachments/assets/245267db-aa26-4982-85ec-654644d5b317" />

---



# Conclusion

This assignment demonstrates how to implement a complete **Jenkins Scripted CI Pipeline** for a Java application.

The pipeline performs code checkout, parallel stability/quality/coverage analysis, report generation, configurable scan execution, manual approval, artifact publishing, and Slack/Email notifications.

The use of a manual approval step ensures that artifacts are published only after authorization, while the configurable scan parameters provide flexibility to the user during build execution.
