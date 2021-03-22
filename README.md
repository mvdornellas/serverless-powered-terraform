# Architecture Serverless Clean Powered By Terraform
proof of concept about terraform building serverless using aws provider and nodeJS

## Clean Architecture Concept
[![Clean Architecture](./assets/clean_architecture.png)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## Technologies
- Terraform
- Typescript
- TSLint
- Webpack
- Typedi
- Babel
- Dynamoose (Provider DynamoDB)

## Deployment 🚀
 - Run `yarn build` webpack package
 - Run `tf:init` initialize terraform
 - Run `tf:validate` validate template terraform
 - Run `tf:plan` view changes about terraform
 - Run `tf:apply` apply changes about terraform
 - Run `tf:destroy` delete resources
 - Run `yarn deploy` provisioned resources on aws provider
 - Run `yarn cleanup` clean build webpack
 - Run `yarn test` test
 - Run `yarn lint` check project clean code

## Step Build
 1. Install Terraform `https://learn.hashicorp.com/tutorials/terraform/install-cli`
 2. Install Node `https://nodejs.org/en/download/`
 3. Run `npm install --global yarn`
 4. Run `yarn` inside the project
 5. Run `yarn deploy` inside the project
