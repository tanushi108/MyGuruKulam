# CI/CD Assignment 2 – Jenkins User Authentication & Authorization

Submitted by Devashish Sathawane

**Part 1:** Role-based access control for 3 teams (Developer, Testing, DevOps) across 9 jobs and 3 views, using Jenkins' Role-Based Authorization Strategy.
**Part 2:** Google SSO login for the admin user.

## Part 1: Role-Based Authorization

### Install required plugins

```
Manage Jenkins → Plugins → Available plugins
```
Installed: **Role-based Authorization Strategy** and **Google Login**.
<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/6cbd7bfc-3fba-4202-83d6-197ef896e64d" />

```
Download progress - all success
```
<img width="975" height="362" alt="image" src="https://github.com/user-attachments/assets/b09b34e1-f275-489d-8f42-3f264b461722" />

### Create the 9 jobs

Each is a Freestyle project with an Execute shell build step:
```bash
echo "Job Name: $JOB_NAME"
echo "Build Number: $BUILD_NUMBER"
```
Repeated for: `dev-1/2/3`, `test-1/2/3`, `devops-1/2/3`.
<img width="975" height="256" alt="image" src="https://github.com/user-attachments/assets/c7ac6132-0fc4-4086-8103-5674b361bd84" />
<img width="975" height="133" alt="image" src="https://github.com/user-attachments/assets/57207941-8242-4c3b-8f15-ced0a12b1aba" />

### Create 3 views

List View, filtered by job name pattern for each team:
- **Developer View** → dev-1, dev-2, dev-3
- **Testing View** → test-1, test-2, test-3
- **DevOps View** → devops-1, devops-2, devops-3
<img width="803" height="103" alt="image" src="https://github.com/user-attachments/assets/d37ea501-3463-49c1-9826-31cabf10b2f0" />

### Create the users

```
Manage Jenkins → Users → Create User
```
Created: developer-1, developer-2, testing-1, testing-2, devops-1, devops-2, admin-1.
<img width="975" height="523" alt="image" src="https://github.com/user-attachments/assets/b5ee23cc-40f7-484c-94b0-2f14fd34eb8f" />

### Enable Role-Based Strategy

```
Manage Jenkins → Security → Authorization → Role-Based Strategy → Save
```
This strategy was chosen (over Legacy, Project-based, or Matrix-based) because it lets permissions be assigned by **regex pattern on job names** (`dev-.*`, `test-.*`, `devops-.*`), which maps directly onto the team/job-prefix structure asked for here - Matrix-based would need per-job checkboxes for every user, and Project-based would need per-job role assignment one at a time.
<img width="434" height="163" alt="image" src="https://github.com/user-attachments/assets/f2fcdc15-a30a-4716-9fd8-9ef10bdafedb" />

### Configure Global roles

```
Manage Jenkins → Manage Roles → Global roles
```
- `admin` → Overall/Administer (full access)
- `user-read` → Overall/Read (so logged-in users can at least see the dashboard shell)
<img width="975" height="316" alt="image" src="https://github.com/user-attachments/assets/da2c95c3-8ab1-4903-b357-84172d7affef" />

### Configure Item roles (the core of the access control)

```
Manage Jenkins → Manage Roles → Item roles
```
| Role | Pattern | Permissions |
|---|---|---|
| dev-full | `dev-.*` | Build, Configure, Read, Workspace |
| dev-view | `dev-.*` | Read only |
| test-full | `test-.*` | Build, Configure, Read, Workspace |
| test-view | `test-.*` | Read only |
| devops-full | `devops-.*` | Build, Configure, Read, Workspace |
| devops-view | `devops-.*` | Read only |
<img width="975" height="391" alt="image" src="https://github.com/user-attachments/assets/4d650ea7-bd5d-4167-bda4-4140bf5bb5d5" />

### Assign roles to users - Global roles

```
Manage and Assign Roles → Assign Roles
```
`admin-1` (and `admin`) → `admin`. All other users → `user-read` (basic dashboard access).

<img width="315" height="547" alt="image" src="https://github.com/user-attachments/assets/26bba7a5-2b61-490a-b5f3-4137124ef650" />

### Assign roles to users - Item roles

| User | Roles assigned |
|---|---|
| developer-1, developer-2 | `dev-full` |
| testing-1, testing-2 | `dev-view` + `test-full` |
| devops-1, devops-2 | `dev-view` + `devops-full` + `test-view` |

This matches the requirement exactly: developers only touch dev jobs; testers get full control of test jobs and can view dev jobs; devops gets full control of devops jobs and can view both dev and test jobs.

<img width="539" height="610" alt="image" src="https://github.com/user-attachments/assets/c6396849-86e7-4172-abde-592056bf273b" />

## Verify using every user login

### developer-1

Only sees `dev-1/2/3`, only the "Developer View" tab.

<img width="975" height="313" alt="image" src="https://github.com/user-attachments/assets/e6e28ce5-5248-4578-b18d-ff7f6b2322bf" />

### developer-2

Same as developer-1.
<img width="975" height="306" alt="image" src="https://github.com/user-attachments/assets/5896061f-9688-4b06-8ec4-559f6c61cc3d" />

### devops-1

Sees all 9 jobs (dev, devops, test) across all 3 view tabs, but build (▶) buttons only appear on devops jobs.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/37b84d26-03cc-41cd-bdeb-d55333473f1f" />

### devops-2

Same as devops-1.
<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/91d62299-0074-402e-94bb-7a4e37e30ea6" />

### testing-1

Sees dev + test jobs only (no devops), build buttons only on test jobs.
<img width="975" height="405" alt="image" src="https://github.com/user-attachments/assets/8316e003-3470-47b4-b503-9657b120f267" />

### testing-2

Same as testing-1.
<img width="975" height="409" alt="image" src="https://github.com/user-attachments/assets/4469f5e8-f5f0-49f8-8c57-c38001d285bc" />

## Part 2: Enable Google SSO for Admin

### Create a new Google Cloud project

```
console.cloud.google.com → New Project: "Jenkins-SSO"
```
<img width="975" height="337" alt="image" src="https://github.com/user-attachments/assets/242f9fcd-cbdc-46e2-b8ae-cad38124f781" />

### Configure OAuth consent screen

App name "Jenkins SSO", support email set.
<img width="975" height="299" alt="image" src="https://github.com/user-attachments/assets/8eabedc6-fd29-4822-ad40-af6790d82efb" />

Scopes requested: `userinfo.email`, `userinfo.profile`, `openid`.
<img width="975" height="421" alt="image" src="https://github.com/user-attachments/assets/d8441f5a-cd07-43ef-af93-8b15fd6a8d85" />

### Create credentials (OAuth client ID)

```
APIs & Services → Credentials → Create Credentials → OAuth client ID
Application type: Web application
```
<img width="975" height="370" alt="image" src="https://github.com/user-attachments/assets/3074b75f-32a2-4a1d-ab2a-632bf389da3d" />

Client ID and secret generated:

<img width="975" height="522" alt="image" src="https://github.com/user-attachments/assets/39ca9790-dbbb-4a4e-8c2f-11edaaf1549e" />

### Configure Jenkins Security Realm

```
Manage Jenkins → Security → Authentication → Security Realm → Login with Google
```
Client ID and Client Secret pasted in.
<img width="975" height="388" alt="image" src="https://github.com/user-attachments/assets/3985b7b9-39a3-443d-9a4a-1c4983ac2c80" />

### Grant the admin's Google email the admin role

Added `devashish5848@gmail.com` (admin's Google account) to Global roles and checked `admin`.
<img width="446" height="551" alt="image" src="https://github.com/user-attachments/assets/5a74b2ac-b8e8-49f1-a4cb-0b0afb1d8842" />

### Login flow via Google

"Sign in with Google" prompt, continuing to "Jenkins SSO".
<img width="975" height="524" alt="image" src="https://github.com/user-attachments/assets/fba56653-c648-4ca6-9fce-34cba3f8a199" />

### Successfully logged into Jenkins via Google

Logged in as "Devashish Sathawane" (`devashish5848@gmail.com`) with full profile access - confirming Google SSO works end to end for the admin user.
<img width="975" height="525" alt="image" src="https://github.com/user-attachments/assets/28888cd6-ff3b-4ad3-b0aa-a27d9a08752f" />

## Note on Authorization Strategies

Went through all four before picking one:

| Strategy | Why not used here |
|---|---|
| **Legacy mode** | No per-user control at all - any logged-in user gets full access. Not usable for team separation. |
| **Project-based Matrix** | Per-job permission grids, but each job needs its own manual setup - doesn't scale to "all jobs starting with dev-" cleanly. |
| **Matrix-based** | Global grid only, no per-job or per-pattern granularity - can't restrict a user to just the `devops-*` jobs. |
| **Role-Based Strategy** ✅ | Supports regex-pattern item roles (`dev-.*`, `test-.*`, `devops-.*`), so one role definition covers a whole team's jobs and new jobs matching the pattern are automatically covered. |
