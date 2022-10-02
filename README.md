## Setup Bottlerocket Managed Node Group on EKS with Terraform

This is a hard-fork of https://github.com/aws-samples/amazon-eks-bottlerocket-mngnodegrp-terraform with my own custom modifications to include the AWS Load Balancer Controller, which will allow Kubernetes ingresses and AWS Application Load Balancer integrations. It also includes some sample apps and some simple testing with NoseJS Puppeteer. A full pipeline is also kicked off through Github Actions. This project is meant as a working example only as it can be potentially split up into separate repositories. A single repository is used here just to keep things simple.

## Prerequisites

* An AWS account with admin privileges - We will assume you already have an [AWS account](https://docs.aws.amazon.com/polly/latest/dg/setting-up.html) with admin privileges.
* Command-line tools - Mac/Linux users need to install the latest version of [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html),[kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html), and [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (>=v0.13.0) on their workstation.Whereas Windows users need to create an EC2 [Cloud9 environment](https://docs.aws.amazon.com/cloud9/latest/user-guide/create-environment-main.html) in AWS and then install these CLI's inside their Cloud9 environment.

## Architecture
![image](https://user-images.githubusercontent.com/80008225/114781741-b1b69c00-9d3e-11eb-8db4-3c7961f48526.png)


## Usage Example 

* Clone terraform codes in your home directory 
```
git clone  https://github.com/kaynenotkanye/terraform-eks-with-aws-load-balancer-controller.git
```
* Change directory to terraform-eks-with-aws-load-balancer-controller
```
cd terraform-eks-with-aws-load-balancer-controller
```
* Then run:
```
# This is a wrapper script calling other commands.
./all-steps.sh 
```


## License

This library is licensed under the MIT-0 License. See the LICENSE file.
