# sssd
Cookbook for sssd on linux. the goal is to provide a cookbook that will be able to setup sane values for your sssd configuration while keeping flexibility of overriding values.
## Requirements
### Cookbooks
N/A

### Chef
* `>= 12.14`

### Platforms
* `rhel7`
* `centos7`

## Resources
### sssd
The `sssd` resource allows you to install and configure sssd.

#### Properties
| Name | Type | Required | Default | Platform Family | Description |
| ---- | ---- | -------- | ------- | --------------- | ----------- |
| `version` | `String` | `false` | - | `All` | Version of the sssd package to install |
| `configuration` | `Hash` | `false` | `{}` | `All` | Configuration hash for sssd, see configuration structure below |
| `action` | `[:install, :configure]` | `false` | `:install` | `All` | Action to apply to the resource |

#### Note
Configuration Structure is a Hash following the following structure:

```ruby
{
  "section_name" => {
    "key" => "value",
    "key" => "value",
  },
}
```

## Versionning
This cookbook will follow semantic versionning 2.0.0 as described [here](https://semver.org/)

## Lisence
MIT

## Contributing
Put link vers contributing here
