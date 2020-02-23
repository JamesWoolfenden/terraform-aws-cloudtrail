[![Slalom][logo]](https://slalom.com)

# terraform-aws-cloudtrail [![Build Status](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail) [![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-cloudtrail.svg)](https://github.com/JamesWoolfenden/terraform-aws-cloudtrail/releases/latest)  [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

This is a basic example for using Cloudtrail.
---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Introduction

THis module deploys a basic *Cloudtrail* set-up, with kms key and *S3* log bucket.

## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "cloudtrail" {
  source            = "JamesWoolfenden/cloudtrail/aws"
  version           = "0.0.4"
  common_tags       = var.common_tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cloud\_watch\_logs\_group\_arn | n/a | `string` | `""` | no |
| cloud\_watch\_logs\_role\_arn | n/a | `string` | `""` | no |
| common\_tags | This is to help you add tags to your cloud objects | `map` | n/a | yes |
| sns\_topic\_name | n/a | `string` | `""` | no |
| trail | Basic Settings for Cloudtrail | `map` | <pre>{<br>  "include_global_service_events": false,<br>  "name": "tf-trail-account",<br>  "s3_key_prefix": "prefix"<br>}<br></pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | n/a |
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
[linkedin]: https://www.linkedin.com/company/slalom-consulting/
[twitter]: https://twitter.com/Slalom
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-cloudtrail&url=https://github.com/JamesWoolfenden/terraform-cloudtrail
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-cloudtrail&url=https://github.com/JamesWoolfenden/terraform-cloudtrail
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
[share_email]: mailto:?subject=terraform-aws-cloudtrail&body=https://github.com/JamesWoolfenden/terraform-aws-cloudtrail
