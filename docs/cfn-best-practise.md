AWS Best Practise:
1. Do not hardcode resource names in templates
- use prefix as resource naming.
- ex RoleName: !Sub ${Prefix}-role

2. Cloudformation Lint using cfn-lint

3. Static analysis of CloudFormation templates using cfn_nag
- It will search for insecure infrastructure like
- IAM rules that are too permissive (wildcards)
- Security group rules that are too permissive (wildcards)
- Access logs that aren't enabled
- Encryption that isn't enabled
- Password literals

4. Taskcat can be one more option for unit test like framework to implement

5. AWS-Specific Parameter Types or use Allowed Patterns / Values

6. Nested stacks usage

7. Always choose !Sub over !Join.

8. Choose wisely parameters to be stored in System parameter store if values changes dynamically.

9. Cfn-nag tool ensures any cloudformation format or syntax can be improved.

10. Auto-generate docs and images and flow chart once template are finalized