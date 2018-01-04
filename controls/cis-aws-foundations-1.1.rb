control "cis-aws-foundations-1.1" do
  title "Avoid the use of the 'root' account"
  desc  "The 'root' account has unrestricted access to all resources in the AWS
account. It is highly recommended that the use of this account be avoided."
  impact 0.4
  tag "rationale": "The 'root' account is the most privileged AWS account.
Minimizing the use of this account and adopting the principle of least
privilege for access management will reduce the risk of accidental changes and
unintended disclosure of highly privileged credentials."
  tag "cis_impact": ""
  tag "cis_rid": "1.1"
  tag "cis_level": 1
  tag "cis_control_number": ""
  tag "nist": ""
  tag "cce_id": ""
  tag "check": "Implement the Ensure a log metric filter and alarm exist for
usage of 'root' account recommendation in the Monitoring section of this
benchmark to receive notifications of root account usage. Additionally,
executing the following commands will provide ad-hoc means for determining the
last time the root account was used:

'aws iam generate-credential-report

'aws iam get-credential-report --query 'Content' --output text | base64 -d |
cut -d, -f1,5,11,16 | grep -B1 '<root_account>'

'Note: there are a few conditions under which the use of the root account is
required, such as requesting a penetration test or creating a CloudFront
private key."
  tag "fix": "Follow the remediation instructions of the Ensure IAM policies
are attached only to groups or roles recommendation"

  aws_cloudwatch_alarm(
    metric: 'my-metric-name',
    metric_namespace: 'my-metric-namespace',
  ) do
    it { should exist }
  end

  describe aws_cloudwatch_log_metric_filter(
    filter_name: 'my-filter',
    log_group_name: 'my-log-group'
  ) do
    it { should exist }
  end

end