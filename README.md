# terraform-aws-cloudtrail

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-cloudtrail.svg)](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-aws-cloudtrail.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-aws-cloudtrail/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-cloudtrail&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-aws-cloudtrail/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-cloudtrail&benchmark=INFRASTRUCTURE+SECURITY)

This is an updated example for using Cloudtrail that works, in addition to the trail Glue is added to support querying in Athena.

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Introduction

This module deploys a _Cloudtrail_ set-up, with kms key and _S3_ log bucket and sets up a table for Athena with AWS Glue.

## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "cloudtrail" {
  source            = "JamesWoolfenden/cloudtrail/aws"
  version           = "v0.1.3"
  trail             = var.trail
}
```

## Costs

```text
Terraform directory at .
  ✔ Running terraform plan
  ✔ Running terraform show

✔ Calculating monthly cost estimate

Project: .

 Name                                                  Monthly Qty  Unit              Monthly Cost

 module.cloudtrail.aws_cloudwatch_log_group.trails
 ├─ Data ingested                                                0  GB                       $0.00
 ├─ Archival Storage                                             0  GB                       $0.00
 └─ Insights queries data scanned                                0  GB                       $0.00

 module.cloudtrail.aws_kms_key.cloudtrail
 ├─ Customer master key                                          1  months                   $1.00
 ├─ Requests                                        Cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                Cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                Cost depends on usage: $0.10 per 10k requests

 module.cloudtrail.aws_s3_bucket.trails
 ├─ Standard - infrequent access
 │  ├─ Storage                                                   0  GB-months                $0.00
 │  ├─ PUT, COPY, POST, LIST requests                            0  1k requests              $0.00
 │  ├─ GET, SELECT, and all other requests                       0  1k requests              $0.00
 │  ├─ Lifecycle transition                                      0  1k requests              $0.00
 │  ├─ Retrievals                                                0  GB-months                $0.00
 │  ├─ Select data scanned                                       0  GB-months                $0.00
 │  └─ Select data returned                                      0  GB-months                $0.00
 ├─ One zone - infrequent access
 │  ├─ Storage                                                   0  GB-months                $0.00
 │  ├─ PUT, COPY, POST, LIST requests                            0  1k requests              $0.00
 │  ├─ GET, SELECT, and all other requests                       0  1k requests              $0.00
 │  ├─ Lifecycle transition                                      0  1k requests              $0.00
 │  ├─ Retrievals                                                0  GB-months                $0.00
 │  ├─ Select data scanned                                       0  GB-months                $0.00
 │  └─ Select data returned                                      0  GB-months                $0.00
 ├─ Glacier
 │  ├─ Storage                                                   0  GB-months                $0.00
 │  ├─ PUT, COPY, POST, LIST requests                            0  1k requests              $0.00
 │  ├─ GET, SELECT, and all other requests                       0  1k requests              $0.00
 │  ├─ Lifecycle transition                                      0  1k requests              $0.00
 │  ├─ Retrieval requests (standard)                             0  1k requests              $0.00
 │  ├─ Retrievals (standard)                                     0  GB-months                $0.00
 │  ├─ Select data scanned (standard)                            0  GB-months                $0.00
 │  ├─ Select data returned (standard)                           0  GB-months                $0.00
 │  ├─ Retrieval requests (expedited)                            0  1k requests              $0.00
 │  ├─ Retrievals (expedited)                                    0  GB-months                $0.00
 │  ├─ Select data scanned (expedited)                           0  GB-months                $0.00
 │  ├─ Select data returned (expedited)                          0  GB-months                $0.00
 │  ├─ Retrieval requests (bulk)                                 0  1k requests              $0.00
 │  ├─ Retrievals (bulk)                                         0  GB-months                $0.00
 │  ├─ Select data scanned (bulk)                                0  GB-months                $0.00
 │  ├─ Select data returned (bulk)                               0  GB-months                $0.00
 │  └─ Early delete (within 90 days)                             0  GB-months                $0.00
 ├─ Glacier deep archive
 │  ├─ Storage                                                   0  GB-months                $0.00
 │  ├─ PUT, COPY, POST, LIST requests                            0  1k requests              $0.00
 │  ├─ GET, SELECT, and all other requests                       0  1k requests              $0.00
 │  ├─ Lifecycle transition                                      0  1k requests              $0.00
 │  ├─ Retrieval requests (standard)                             0  1k requests              $0.00
 │  ├─ Retrievals (standard)                                     0  GB-months                $0.00
 │  ├─ Retrieval requests (bulk)                                 0  1k requests              $0.00
 │  ├─ Retrievals (bulk)                                         0  GB-months                $0.00
 │  └─ Early delete (within 180 days)                            0  GB-months                $0.00
 ├─ Standard
 │  ├─ Storage                                                   0  GB-months                $0.00
 │  ├─ PUT, COPY, POST, LIST requests                            0  1k requests              $0.00
 │  ├─ GET, SELECT, and all other requests                       0  1k requests              $0.00
 │  ├─ Select data scanned                                       0  GB-months                $0.00
 │  └─ Select data returned                                      0  GB-months                $0.00
 └─ Intelligent tiering
    ├─ Storage (frequent access)                                 0  GB-months                $0.00
    ├─ Storage (infrequent access)                               0  GB-months                $0.00
    ├─ Monitoring and automation                                 0  1k objects               $0.00
    ├─ PUT, COPY, POST, LIST requests                            0  1k requests              $0.00
    ├─ GET, SELECT, and all other requests                       0  1k requests              $0.00
    ├─ Lifecycle transition                                      0  1k requests              $0.00
    ├─ Select data scanned                                       0  GB-months                $0.00
    ├─ Select data returned                                      0  GB-months                $0.00
    └─ Early delete (within 30 days)                             0  GB-months                $0.00

 PROJECT TOTAL                                                                               $1.00

----------------------------------
To estimate usage-based resources use --usage-file, see https://infracost.io/usage-file

3 resource types weren't estimated as they're not supported yet.
Please watch/star https://github.com/infracost/infracost as new resources are added regularly.
1 x aws_cloudtrail
1 x aws_glue_catalog_table
1 x aws_glue_catalog_database
```

## Checks

This module has a Checkov skip added as the MFA_delete functionality is currently broken in Terraform 0.12.8. I have added an ignore so that you can manually update this item without interference.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_glue_catalog_database.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_glue_catalog_table.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_table) | resource |
| [aws_iam_role.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kms_alias.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_sns_topic.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudtrail_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudtrail_service_account) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Bool to enable log file validation | `bool` | `true` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Toggle logging | `bool` | `true` | no |
| <a name="input_expiry"></a> [expiry](#input\_expiry) | Expire logs after this many days | `number` | `30` | no |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | Is this a multi-region trail? Secure option is default | `bool` | `true` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Is this for an organisation? | `bool` | `false` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | n/a | `string` | `"cloudtrail"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | n/a | `number` | `90` | no |
| <a name="input_trail"></a> [trail](#input\_trail) | Basic Settings for Cloudtrail | `map(any)` | <pre>{<br>  "include_global_service_events": false,<br>  "name": "tf-trail-account",<br>  "s3_key_prefix": "prefix"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_kms"></a> [kms](#output\_kms) | n/a |
| <a name="output_log_group"></a> [log\_group](#output\_log\_group) | n/a |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
| <a name="output_trail"></a> [trail](#output\_trail) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Policy

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Policy required is:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "SNS:CreateTopic",
                "SNS:DeleteTopic",
                "SNS:GetTopicAttributes",
                "SNS:ListTagsForResource",
                "SNS:SetTopicAttributes"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "glue:CreateDatabase",
                "glue:CreateTable",
                "glue:DeleteDatabase",
                "glue:DeleteTable",
                "glue:GetDatabase",
                "glue:GetTable",
                "glue:UpdateDatabase",
                "glue:UpdateTable"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:DeleteRolePolicy",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListInstanceProfilesForRole",
                "iam:ListRolePolicies",
                "iam:PutRolePolicy"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": [
                "kms:CreateAlias",
                "kms:CreateKey",
                "kms:DeleteAlias",
                "kms:DescribeKey",
                "kms:EnableKeyRotation",
                "kms:GetKeyPolicy",
                "kms:GetKeyRotationStatus",
                "kms:ListAliases",
                "kms:ListResourceTags",
                "kms:PutKeyPolicy",
                "kms:ScheduleKeyDeletion"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor4",
            "Effect": "Allow",
            "Action": [
                "logs:AssociateKmsKey",
                "logs:CreateLogGroup",
                "logs:DeleteLogGroup",
                "logs:DeleteRetentionPolicy",
                "logs:DescribeLogGroups",
                "logs:DisassociateKmsKey",
                "logs:ListTagsLogGroup",
                "logs:PutRetentionPolicy"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor5",
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketLogging",
                "s3:GetBucketObjectLockConfiguration",
                "s3:GetBucketPolicy",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketWebsite",
                "s3:GetEncryptionConfiguration",
                "s3:GetLifecycleConfiguration",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:GetReplicationConfiguration",
                "s3:ListAllMyBuckets",
                "s3:ListBucket",
                "s3:PutBucketAcl",
                "s3:PutBucketLogging",
                "s3:PutBucketPolicy",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutBucketVersioning",
                "s3:PutEncryptionConfiguration",
                "s3:PutLifecycleConfiguration"
            ],
            "Resource": "*"
        }
    ]
}

```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2022 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
