# Terraform Lambda Typescript Architecture
proof of concept about terraform building serverless using aws provider

## Use case 
- Terraform
- Typescript
- TSLint
- Webpack
- Typedi
- Babel
- Dynamoose

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

## Steps 🚀
 1. install npm on
 2. install terraform global
 3. install yarn
 4. yarn deploy