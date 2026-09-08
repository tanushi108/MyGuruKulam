# CI/CD Assignment 2 – Jenkins User Authentication & Authorization

Submitted by Devashish Sathawane

**Part 1:** Role-based access control for 3 teams (Developer, Testing, DevOps) across 9 jobs and 3 views, using Jenkins' Role-Based Authorization Strategy.
**Part 2:** Google SSO login for the admin user.

## Part 1: Role-Based Authorization


### Create the 9 jobs

Each is a Freestyle project with an Execute shell build step:
```bash
echo "Job Name: $JOB_NAME"
echo "Build Number: $BUILD_NUMBER"
```
Repeated for: `Assignment_2-dev-1/2/3`, `Assignment_2-test-1/2/3`, `Assignment-2-devops-1/2/3`.
<img width="1045" height="355" alt="image" src="https://github.com/user-attachments/assets/3c9ba8e7-397f-4b74-a23e-8816457b73b0" />


### Create 3 views

List View, filtered by job name pattern for each team:
- **Developer** → Assignment_2-dev-1, Assignment_2-dev-2, Assignment_2-dev-3
- **Testing** → Assignment_2-test-1, Assignment_2-test-2, Assignment_2-test-3
- **DevOps** → Assignment_2-devops-1, Assignment_2-devops-2, Assignment_2-devops-3
<img width="646" height="83" alt="image" src="https://github.com/user-attachments/assets/a70ea150-93c5-4b41-b0ff-52170b205609" />


### Create the users

```
Manage Jenkins → Users → Create User
```
Created: developer1, developer2, testing1, testing2, devops1, devops2, admin1.
<img width="1331" height="449" alt="image" src="https://github.com/user-attachments/assets/4d2b2ba2-7b3e-4296-93cd-b799609e70fa" />



### Configure Global roles

```
Manage Jenkins → Role management → Manage Roles → Global roles
```
- `admin` → Overall/Administer (full access)
- `read-access` → Overall/Read (so logged-in users can at least see the dashboard shell)

<img width="985" height="274" alt="image" src="https://github.com/user-attachments/assets/fc228511-20f0-4b5d-b3bf-631e02853a9a" />



### Configure Item roles (the core of the access control)

```
Manage Jenkins → Role management → Manage Roles → Item roles
```

| Role | Pattern | Permissions |
|---|---|---|
| developer | `Assignment_2-dev-.*` | Build, Configure, Read, Workspace |
| developer-view | `Assignment_2-dev-.*` | Read only |
| testing | `Assignment_2-test-.*` | Build, Configure, Read, Workspace |
| testing-view | `Assignment_2-test-.*` | Read only |
| devop | `Assignment_2-devops-.*` | Build, Configure, Read, Workspace |


<img width="1003" height="347" alt="image" src="https://github.com/user-attachments/assets/8495ca7c-5b8f-43e0-8213-e675489b4659" />


### Assign roles to users - Global roles

```
Manage and Assign Roles → Assign Roles
```
 `admin` → `admin`. All other users → `read-access` (basic dashboard access).

<img width="323" height="454" alt="image" src="https://github.com/user-attachments/assets/2f6ff9d0-58dd-48b5-8078-5b6b0d23ac73" />


### Assign roles to users - Item roles

| User | Roles assigned |
|---|---|
| developer-1, developer-2 | `developer` + `developer-view` |
| testing-1, testing-2 | `developer-view` + `testing` + `testing-view`|
| devops-1, devops-2 | `developer-view` + `devops` + `testing-view` |

This matches the requirement exactly: developers only touch dev jobs; testers get full control of test jobs and can view dev jobs; devops gets full control of devops jobs and can view both dev and test jobs.

<img width="347" height="353" alt="image" src="https://github.com/user-attachments/assets/d2d7aa13-6a09-4f7d-9dc2-1a013ab35217" />

## Verify using every user login

### developer1 or developer2

Only sees `Assignment-dev-1/2/3`, only the "Developer" tab.

<img width="1354" height="344" alt="image" src="https://github.com/user-attachments/assets/3fe98959-82eb-4fd4-925f-fa9be8a03b9b" />


### devops1 or devops2

Sees all 9 jobs (dev, devops, test) across all 3 view tabs, but build (▶) buttons only appear on devops jobs.

<img width="1365" height="536" alt="image" src="https://github.com/user-attachments/assets/49295d66-27e7-4f83-88bc-d590937840d6" />



### testing1 or testing2

Sees dev + test jobs only (no devops), build buttons only on test jobs.

<img width="1365" height="485" alt="image" src="https://github.com/user-attachments/assets/0e9f9f38-0f38-46ed-97f1-2e6a7f69376b" />



## Part 2: Enable Google SSO for Admin


### Configure OAuth consent screen

App name "Jenkins"

<img width="1183" height="614" alt="image" src="https://github.com/user-attachments/assets/c64b7661-47c6-4fca-bfd9-7e77a92880e4" />


### Create credentials (OAuth client ID)

```
APIs & Services → Credentials → Create Credentials → OAuth client ID
Application type: Web application
```
<img width="771" height="580" alt="image" src="https://github.com/user-attachments/assets/901f8a4f-5cee-4639-8710-495bf4c361b3" />

### Configure Jenkins Security Realm

```
Manage Jenkins → Security → Authentication → Security Realm → Login with Google
```
Client ID and Client Secret pasted in.

<img width="1201" height="506" alt="image" src="https://github.com/user-attachments/assets/deabd305-d748-4fb9-9a33-044711b01af4" />


### Grant the admin's Google email the admin role

Added `tanushirana875@gmail.com` (admin's Google account) to Global roles and checked `admin`.

<img width="446" height="551" alt="image" src="https://github.com/user-attachments/assets/5a74b2ac-b8e8-49f1-a4cb-0b0afb1d8842" />

### Login flow via Google

"Sign in with Google" prompt, continuing to "Jenkins SSO".
<img width="1221" height="624" alt="image" src="https://github.com/user-attachments/assets/8c2540cc-0341-48c5-bbce-0382b8b1697d" />


### Successfully logged into Jenkins via Google

Logged in as "Tanushi Rana" (`tanushirana875@gmail.com`) with full profile access - confirming Google SSO works end to end for the admin user.
<img width="1365" height="527" alt="image" src="https://github.com/user-attachments/assets/cdcc1709-28b3-4853-a193-d9fd5c5259d2" />



## Note on Authorization Strategies

Went through all four before picking one:

| Strategy | Why not used here |
|---|---|
| **Legacy mode** | No per-user control at all - any logged-in user gets full access. Not usable for team separation. |
| **Project-based Matrix** | Per-job permission grids, but each job needs its own manual setup - doesn't scale to "all jobs starting with dev-" cleanly. |
| **Matrix-based** | Global grid only, no per-job or per-pattern granularity - can't restrict a user to just the `devops-*` jobs. |
| **Role-Based Strategy** ✅ | Supports regex-pattern item roles (`dev-.*`, `test-.*`, `devops-.*`), so one role definition covers a whole team's jobs and new jobs matching the pattern are automatically covered. |
