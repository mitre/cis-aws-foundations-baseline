PWD_LENGTH = attribute(
  'pwd_length',
  description: 'Required password length',
  default: '14')

control "cis-aws-foundations-1.9" do
  title "Ensure IAM password policy requires minimum length of #{PWD_LENGTH} or greater"
  desc  "Password policies are, in part, used to enforce password complexity
requirements. IAM password policies can be used to ensure password are at least
a given length. It is recommended that the password policy require a minimum
password length #{PWD_LENGTH}."
  impact 0.3
  tag "rationale": "Setting a password complexity policy increases account
resiliency against brute force login attempts."
  tag "cis_impact": ''
  tag "cis_rid": "1.9"
  tag "cis_level": 1
  tag "csc_control": [["5.7", "16.12"], "6.0"]
  tag "nist": ["IA-5(1)","IA-2", "Rev_4"]
  tag "cce_id": "CCE-78907-3"
  tag "check": "Perform the following to ensure the password policy is
configured as prescribed:

'Via AWS Console

* Login to AWS Console (with appropriate permissions to View Identity Access
Management Account Settings)
* Go to IAM Service on the AWS Console
* Click on Account Settings on the Left Pane
* Ensure 'Minimum password length' is set to #{PWD_LENGTH} or greater.

'Via CLI

'aws iam get-account-password-policy

Ensure the output of the above command includes 'MinimumPasswordLength': #{PWD_LENGTH} (or
higher)"

  tag "fix": "Perform the following to set the password policy as prescribed:

'Via AWS Console

* Login to AWS Console (with appropriate permissions to View Identity Access
Management Account Settings)
* Go to IAM Service on the AWS Console
* Click on Account Settings on the Left Pane
* Set 'Minimum password length' to #{PWD_LENGTH} or greater.
* Click 'Apply password policy'

' Via CLI

' aws iam update-account-password-policy --minimum-password-length #{PWD_LENGTH}

'Note: All commands starting with 'aws iam update-account-password-policy' can
be combined into a single command."

  describe aws_iam_password_policy do
    its('minimum_password_length') { should cmp >= PWD_LENGTH }
  end
end
