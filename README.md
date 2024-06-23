# Local Dirtree Terraform Provider

This is a [Terraform](https://www.terraform.io) data provider, giving a simple way to reference the names of files in some directory structure (probably in source control adjacent to a module) to, say, interpolate lots of templates in one go.  This is useful in a case where template files will come and go from a project, and maintaining parallel `file(path)` definitions manually in the terraform would be tiresome.


## Requirements

-	[Terraform](https://www.terraform.io/downloads.html) >= 0.13.x
-	[Go](https://golang.org/doc/install) >= 1.22


## Building The Provider

1. Clone the repository
2. Enter the repository directory
3. Build the provider using the Go `build` command:
```sh
$ go build
```

## Developing the Provider

If you wish to work on the provider, you'll first need [Go](http://www.golang.org) installed on your machine (see [Requirements](#requirements) above).

To compile the provider, run `go install`. This will build the provider and put the provider binary in the `$GOPATH/bin` directory.

~~To generate or update documentation, run `go generate`.~~
Documentation is currently built with a branch of a fork of `tfplugindocs`, found [here](https://github.com/bill-rich/terraform-plugin-docs/tree/f-v6_support).  At the root of this repo, run `tfplugindocs` compiled from that branch.


In order to run the acceptance tests, run `make testacc`.

```sh
$ make testacc
```
