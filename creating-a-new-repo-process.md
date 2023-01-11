# Create a new Open Component Model Repository

This guide shows you how you can create a new repository within the Open Component Model repository.

This process only applies for projects under the Open Component Model scope.

Please follow these steps:

1. Create the new repository, using the https://github.com/open-component-model/repository-template template
2. Add the following teams to the repository under repository -> settings -> Team and member roles
   1. `Maintainer` with `Admin` permissions
   2. `Core` with `Write` permissions
3. Make sure your project includes all relevant files like `README.md`, `CONTRIBUTING.md` and include information how people can consume and contribute to your project
4. Make sure to have a `LICENSE` file with the text of the Apache-2.0 license.
   The repository-template already includes this file.
5. Make sure to have a `.reuse/dep5` file outlining the license information on a per file basis like below.
   Replace `<repo-name>` with the name of your repository.

   ```deb5
   Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
   Upstream-Name: <repo-name>
   Upstream-Contact: ospo@sap.com
   Source: https://github.com/open-component-model/<repo-name>
   Disclaimer: The code in this project may include calls to APIs ("API Calls") of
    SAP or third-party products or services developed outside of this project
    ("External Products").
    "APIs" means application programming interfaces, as well as their respective
    specifications and implementing code that allows software to communicate with
    other software.
    API Calls to External Products are not licensed under the open source license
    that governs this project. The use of such API Calls and related External
    Products are subject to applicable additional agreements with the relevant
    provider of the External Products. In no event shall the open source license
    that governs this project grant any rights in or to any External Products, or
    alter, expand or supersede any terms of the applicable additional agreements.
    If you have a valid license agreement with SAP for the use of a particular SAP
    External Product, then you may make use of any API Calls included in this
    project's code for that SAP External Product, subject to the terms of such
    license agreement. If you do not have a valid license agreement for the use of
    a particular SAP External Product, then you may only make use of any API Calls
    in this project for that SAP External Product for your internal, non-productive
    and non-commercial test and evaluation of such API Calls. Nothing herein grants
    you any rights to use or access any SAP External Product, or provide any third
    parties the right to use of access any SAP External Product, through API Calls.

   Files: **
   Copyright: 2022 SAP SE or an SAP affiliate company and Open Component Model contributors
   License: Apache-2.0
   ```

6. Add the Apache-2.0 license text as `./LICENSES/Apache-2.0.txt`.
   The repository-template already includes this file.
7. Include the REUSE badge at the top and a section about licensing at the bottom to your README. Replace `<repo-name>` with the name of your repository. (You can only register the repository with REUSE after it is public; but you can already include the badge within your README)

   ```markdown
   # <repo-name>

   [![REUSE status](https://api.reuse.software/badge/github.com/open-component-model/<repo-name>)](https://api.reuse.software/info/github.com/open-component-model/<repo-name>)

   ...
   <other-README-content>
   ...

   ## Licensing

   Copyright 2022 SAP SE or an SAP affiliate company and Open Component Model contributors.
   Please see our [LICENSE](LICENSE) for copyright and license information.
   Detailed information including third-party components and their licensing/copyright information is available [via the REUSE tool](https://api.reuse.software/info/github.com/open-component-model/<repo-name>).
   ```

8. Before making the repository public, you need to raise a request towards the OSPO. "[Request for subproject](https://github.wdf.sap.corp/OSPO/OSPO-request/issues/new?assignees=&labels=Outbound+Subproject&template=011-subproject-for-existing-project.md&title=Sub-project+Outbound+Request%3D%7Bproject-name%7D)" with the SAP Open Source Program Office SAP-internally. If you don't have access / you are not an SAP employee, please reach out to one of the SAP employees to do that.
9. After you get the okay from the OSPO for the project, you change the visibility under repository -> settings -> Change repository visibility
10. Finally register your project, when it is public, with the REUSE service at https://api.reuse.software/register
11. The bot from the Open Source Program Office will check daily if the repository is correctly set up and if not create a GitHub issue.
