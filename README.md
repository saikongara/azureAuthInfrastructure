
# Authentication of Data Engineering platform on Azure

This GitHub repository houses terraform script to deploy Authentication &amp; Monitoring around Azure persistent Infrastructure that supports Big Data operations for Data Engineering.

#### The resources deployed as part of this Infrastructure-as-code are;
> - **Azure RBAC** - Azure `Role based Authentication` to restrict resource level access based on `User ID` and `Service Principles`.
> - **Azure Monitor** - The alerting system configured to send `email` and `text` notification.
> - **Azure Security** - The security system that restricts resource level access based on AAD access provisioning.


`Jenkins` file to support automated `DevOps` deployment integrated with `GitHub`.

## Branching
Latest emhancements will be updated to Master branch for release.
1. `master` branch
    > 1. merge needs `Pull Request` review/approval.
    > 1. Once reviewed and merged with `develop`, raise `Pull Request` for `master` for enhancement to be made.

1. `develop` branch
    > 1. Create Enhancement wise branches out of it.
    > 1. Work enhancements wise contribution.
    > 1. Push latest code with `Pull Requests` and get reviewed.
    > 1. merge needs `Pull Requests` review/approval.