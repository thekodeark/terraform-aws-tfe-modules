Cert Module
===========

A terraform module to create certificate for AWS resources

Module Input Variables
----------------------

| Name   |      Requied      |  Description |
|----------|:-------------:|------:|
| hosted_zone |  yes | Hosted zone of route 53 |
| fqdn |  yes | A fully qualified domain name |

Usage
-----

```hcl
module "cert" {
  source      = "./modules/cert"
  fqdn        = "test.kodeark.com"
  hosted_zone = "kodeark.com"
}
```


Outputs
=======

 - `arn` - ARN of ACM
 - `zone_id` - Route 53 Zone ID where ACM is created

