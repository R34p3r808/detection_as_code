# Wazuh AWS Terraform Project

This Terraform project deploys a single Ubuntu EC2 instance with Wazuh installed. It creates:
- A key pair for SSH access
- A security group with SSH and Wazuh ports open
- A 30GB EBS root volume

## Instructions

1. Update your AWS credentials.
2. Ensure you have your SSH key (`~/.ssh/id_rsa.pub`).
3. Run:

```
terraform init
terraform apply
```

4. Access the Wazuh dashboard at `http://<instance-ip>:5601`.

## SSH Access

```
ssh -i ~/.ssh/id_rsa ubuntu@<instance-ip>
```
