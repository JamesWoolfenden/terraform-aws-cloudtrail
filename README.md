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

This module deploys a basic _Cloudtrail_ set-up, with kms key and _S3_ log bucket and sets up a table for Athena with AWS Glue.

## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "cloudtrail" {
  source            = "JamesWoolfenden/cloudtrail/aws"
  version           = "v0.1.3"
  trail             = var.trail
  common_tags       = var.common_tags
}
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
| [aws_glue_catalog_table.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_table) | resource |
| [aws_kms_alias.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.trails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudtrail_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudtrail_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_watch_logs_role_arn"></a> [cloud\_watch\_logs\_role\_arn](#input\_cloud\_watch\_logs\_role\_arn) | Role ARN for Cloudwatch logs | `string` | `""` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | This is to help you add tags to your cloud objects | `map(any)` | n/a | yes |
| <a name="input_enable_log_file_validation"></a> [enable\_log\_file\_validation](#input\_enable\_log\_file\_validation) | Bool to enable log file validation | `bool` | `true` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Toggle logging | `bool` | `true` | no |
| <a name="input_is_multi_region_trail"></a> [is\_multi\_region\_trail](#input\_is\_multi\_region\_trail) | Is this a multi-region trail? Secure option is default | `bool` | `true` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Is this for an organisation? | `bool` | `false` | no |
| <a name="input_mfa_delete"></a> [mfa\_delete](#input\_mfa\_delete) | Terraform wont currently work with this set on, disabling by default with an ignore on changes | `bool` | `false` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | n/a | `number` | `90` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | The name of the SNS topic | `string` | `""` | no |
| <a name="input_trail"></a> [trail](#input\_trail) | Basic Settings for Cloudtrail | `map(any)` | <pre>{<br>  "include_global_service_events": false,<br>  "name": "tf-trail-account",<br>  "s3_key_prefix": "prefix"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_kms"></a> [kms](#output\_kms) | n/a |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
| <a name="output_trail"></a> [trail](#output\_trail) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2021 James Woolfenden

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
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-cloudtrail&url=https://github.com/JamesWoolfenden/terraform-cloudtrail
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-cloudtrail&url=https://github.com/JamesWoolfenden/terraform-cloudtrail
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
[share_email]: mailto:?subject=terraform-aws-cloudtrail&body=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
