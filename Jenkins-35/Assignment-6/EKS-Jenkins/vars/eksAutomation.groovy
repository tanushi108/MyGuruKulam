def call(Map config = [:]) {

    def operation = config.get('operation', 'verify')
    def clusterName = config.get('clusterName', '')
    def region = config.get('region', 'ap-south-1')
    def ansibleRepo = config.get('ansibleRepo', '')
    def ansibleBranch = config.get('ansibleBranch', 'main')

    if (!(operation in ['create', 'verify', 'destroy'])) {
        error "Invalid operation: ${operation}. Use create, verify, or destroy."
    }

    if (!clusterName?.trim()) {
        error "Cluster name is required."
    }

    if (!ansibleRepo?.trim()) {
        error "Ansible repository URL is required."
    }

    stage('Checkout Ansible Repository') {

        deleteDir()

        git(
            branch: ansibleBranch,
            url: ansibleRepo
        )

        sh '''
            echo "===== Ansible Repository ====="
            pwd
            ls -la
            echo "=============================="
        '''
    }

    stage('Ansible Syntax Check') {

        sh '''
            ansible-playbook site.yml \
              -i inventory \
              --syntax-check
        '''
    }

    stage('EKS Automation') {

        withCredentials([
            string(
                credentialsId: 'aws-access-key',
                variable: 'AWS_ACCESS_KEY_ID'
            ),
            string(
                credentialsId: 'aws-secret-key',
                variable: 'AWS_SECRET_ACCESS_KEY'
            )
        ]) {

            sh """
                set -e

                export AWS_DEFAULT_REGION=${region}

                echo "======================================"
                echo "EKS Automation"
                echo "Operation : ${operation}"
                echo "Region    : ${region}"
                echo "Cluster   : ${clusterName}"
                echo "======================================"

                echo "Checking AWS authentication..."
                aws sts get-caller-identity

                echo "Running Ansible..."

                ansible-playbook site.yml \
                  -i inventory \
                  -e "operation=${operation}" \
                  -e "eks_cluster_name=${clusterName}"
            """
        }
    }
}
