# GolangNetlifyFunctions

## Purpose
Netlify's documentation on deploying multiple Golang functions has a few pain points. First, deploying multiple functions on their system without the constant need to update the Makefile as this [example](https://github.com/netlify/aws-lambda-go-example) would have required. Second, deploying without a frontend introduces some small changes. This example attempts to streamline Netlify's already easy-to-use deployment system even further.

## Important Pieces
*Golang refers to the Go Programming Language. They may be used interchangeably below.*

What made this all work together were the following:
* [Makefile](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/master/Makefile) - A file instructing the [make](https://www.gnu.org/software/make/manual/html_node/Introduction.html) command how to build the software. In this case, we're just telling it what the [go-tool](https://golang.org/cmd/go/) should do to the packages (hello and goodbye folders).
* ["make build"](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/ad9e223b7eb6d842aedfcf009bc708509b87c02f/netlify.toml#L2) command is called upon by Netlify's deployment system and uses the [Makefile](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/master/Makefile).
* [GO_IMPORT_PATH](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/ad9e223b7eb6d842aedfcf009bc708509b87c02f/netlify.toml#L5) tells the [go-tool](https://golang.org/cmd/go/) where to fetch the golang source code. What we're doing is using the Netlify system to just run our [go-tool](https://golang.org/cmd/go/) to create the functions and deploy it to the cloud for us.
* When you see something like ["./..."](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/ad9e223b7eb6d842aedfcf009bc708509b87c02f/Makefile#L2) that tells the [go-tool](https://golang.org/cmd/go/) to go through the current directory (or [GOPATH](https://github.com/golang/go/wiki/GOPATH)) and find all the packages to look at.

## How to deploy this example...
*The following assumes you have some [git basics](https://www.atlassian.com/git). It also assumes you have a Netlify account authorized to access your GitHub repos.*

1. [Fork this repo](https://help.github.com/en/articles/fork-a-repo#fork-an-example-repository).
1. Change [this](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/70583093ac3d99b882391074087c5224edd6e9e9/netlify.toml#L5) to point to your fork instead of mine.
1. Go to [app.netlify.com](https://app.netlify.com/) to login.
1. Click on "New site from Git".
1. Select "GitHub". Requires [configuring Netlify with GitHub](https://www.netlify.com/docs/github-permissions/#installing-the-netlify-app-on-github).
1. Select or Find "GolangNetlifyFunctions" from the list.
1. Ensure the "Branch to deploy" drop-down field is set to master.
1. Click on "Deploy site".
1. Click on "Deploys" tab at the top of the page.
1. Wait for the first entry to change its status to: **PUBLISHED**.
1. Click on "Functions" tab at the top of the page.
1. You should see one function for "hello" and another for "goodbye".
1. If you click on either one, and visit the **Endpoint** under the function name of the form:
   
   *https://**[something-clever-netlify-made-for-you]**.netlify.com/.netlify/functions/**[function-name]***
   
   ...you will see either the words, "Hello, World!" or "Goodbye, World!"
1. Congratulations, you've just deployed a pure backend filled with Golang Netlify functions!

## How do I add more functions to this...
Simply create a directory on the first level of this repo, next to the "hello" and "goodbye" directories, and fill it with go files! This setup takes care of the rest!!! Have fun!

## References
* [Publishing a Golang Netlify Function](https://www.netlify.com/docs/functions/#go-lambda-functions)
* [netlify.toml Reference](https://www.netlify.com/docs/netlify-toml-reference/)

## Appendix
### Other Info
* A reference to the hack here that made this all work. Project assumes Netlify's build repo root will always be: [/opt/build/repo](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/70583093ac3d99b882391074087c5224edd6e9e9/netlify.toml#L6)
* Where your Netlify functions end up living is defined in this [functions line](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/70583093ac3d99b882391074087c5224edd6e9e9/netlify.toml#L3).
* If you desire, change the name of your functions folder in the [netlify.toml](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/70583093ac3d99b882391074087c5224edd6e9e9/netlify.toml#L3). We'll call this new name, **FUNCS_FOLDER_NAME**.
   
   If you make this change, be sure to change the [GOBIN entry in the netlify.toml file](https://github.com/phoenixcoder/GolangNetlifyFunctions/blob/70583093ac3d99b882391074087c5224edd6e9e9/netlify.toml#L6), appropriately.
   
   For instance, if your **FUNCS_FOLDER_NAME = llama**, you should change this line to:
   ```
   GOBIN=/opt/build/repo/llama
   ```
