# shieldrule

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

The following values are required to launch this Helm solution. We recommend using `--set` to set these if you're running Helm from a pipeline.

## Values

| Key                       | Description                                                                                                            | Default    |
|---------------------------|------------------------------------------------------------------------------------------------------------------------|------------|
| POSTGRES_HOST             | Host of the postgres database instance                                                                                 |            |
| POSTGRES_PORT             | Postgres database instance port                                                                                        |            |
| POSTGRES_DB               | Name of the postgres database to use                                                                                   |            |
| POSTGRES_USER             | Postgres database user to use                                                                                          |            |
| POSTGRES_PASSWORD         | Postgres password to use                                                                                               |            |
| AUDIENCE_URL              | Intended audience for OAuth. In most cases you should use "https://usemodernlogic.us.auth0.com/".                      |            |
| ISSUER_URL                | Oauth authorization server's issuer url. In most cases you should use "https://{company}-{env}.usemodernlogic.com/api" |            |
| AUTH0_ENVIRONMENT_PREFIX: | Prefix used to distinguish auth server. We recommend using {company}_{env}                                             |            |
| RESET_DB                  | Deprecated                                                                                                             | false      |
| USE_AUTH_0                | Whether to use Auth0 for authentication                                                                                | true       |
| ENVIRONMENT               | This sets the java profile the server should use. Should always be production, unless instructed otherwise.            | production |
| SENTRY_ENVIRONMENT        | Where to direct sentry alerts. Normally you should use the company name all lowercase                                  |            |
| METRICS_NAMESPACE         | Deprecated                                                                                                             |            |
| SLACK_REDIRECT_URI        | Deprecated                                                                                                             |            |
| SHIELDRULE_ENVIRONMENT    | Sliderule environment identifier. Normally you should use "{company}_{env}"                                            |            |
| USE_INSTANCE_PROFILE      | Whether to use an AWS IAM role provided by the container                                                               | true       |
| SERVER_BUCKET             | Name of the server storage bucket made in Terraform step 1                                                             |            |
| REDIS_HOST                | Redis cluster host                                                                                                     |            |
| REDIS_PORT                | Redis cluster port                                                                                                     |            |
| USE_REDIS                 | Whether to use redis for caching                                                                                       | true       |
| USE_SQS                   | Whether to use SQS for queue jobs                                                                                      | true       |
| SQS_QUEUE_NAME            | Name of the SQS queue to use (created by the terraform in step 1)                                                      |            |
| SQS_URL                   | Use of the SQS queue to use (created by the terraform in step 1)                                                       |            |
| PROMETHEUS_ACCESS_TOKEN   | Auth token for prometheus instance to access metrics. Sliderule will provide this after initial installation           |            |
| EMAIL_USER_TOKEN          | Aws identifier token to override default SES user. Sliderule will provide this after initial installation              |            |
| EMAIL_USER_KEY            | Aws secret token to override default SES user auth. Sliderule will provide this after initial installation             |            |