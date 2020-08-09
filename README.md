[![Slalom][logo]](https://slalom.com)

# terraform-aws-cloudtrail

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-cloudtrail.svg)](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

This is an updated example for using Cloudtrail that works, in addition to the trail Glue is added to support querying in Athena.

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Introduction

This module deploys a basic *Cloudtrail* set-up, with kms key and *S3* log bucket and sets up a table for Athena with AWS Glue.

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
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_watch\_logs\_group\_arn | ARN for Cloudwatch logs group | `string` | `""` | no |
| cloud\_watch\_logs\_role\_arn | Role ARN for Cloudwatch logs | `string` | `""` | no |
| common\_tags | This is to help you add tags to your cloud objects | `map` | n/a | yes |
| enable\_log\_file\_validation | Bool to enable log file validation | `bool` | `true` | no |
| enable\_logging | Toggle logging | `bool` | `true` | no |
| is\_multi\_region\_trail | Is this a multi-region trail? Secure option is default | `bool` | `true` | no |
| is\_organization\_trail | Is this for an organisation? | `bool` | `false` | no |
| mfa\_delete | Terraform wont currently work with this set on, disabling by default with an ignore on changes | `bool` | `false` | no |
| sns\_topic\_name | The name of the SNS topic | `string` | `""` | no |
| trail | Basic Settings for Cloudtrail | `map` | <pre>{<br>  "include_global_service_events": false,<br>  "name": "tf-trail-account",<br>  "s3_key_prefix": "prefix"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | n/a |
| kms | n/a |
| service\_account | n/a |
| trail | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2020 [Slalom, LLC](https://slalom.com)

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
[logo]: https://gist.githubusercontent.com/JamesWoolfenden/5c457434351e9fe732ca22b78fdd7d5e/raw/15933294ae2b00f5dba6557d2be88f4b4da21201/slalom-logo.png
[website]: https://slalom.com
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-cloudtrail&url=https://github.com/JamesWoolfenden/terraform-cloudtrail
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-cloudtrail&url=https://github.com/JamesWoolfenden/terraform-cloudtrail
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
[share_email]: mailto:?subject=terraform-aws-cloudtrail&body=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
