..
   SPDX-License-Identifier: AGPL-3.0-or-later

   ----------------------------------------------------------------------
   Copyright © 2024, 2025  Pellegrino Prevete

   All rights reserved
   ----------------------------------------------------------------------

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Affero General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Affero General Public License for more details.

   You should have received a copy of the GNU Affero General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.


===============
ur-package-info
===============

-----------------------------------------------------
User Repository package information retrieval command
-----------------------------------------------------
:Version: ur-package-info |version|
:Manual section: 1

Synopsis
========

ur-package-info *[options]* *package*

Description
===========

*ur-package-info* is a command to retrieve various
informations about a package published on the
user repository.

Networks
==========

Currently available networks are
Gnosis and DogeChain, respectively
for purchasing and selling applications
with Dollars and Dogecoins.

Options
========

-P publisher           Target package publisher.
-r revision            Target package revision.
-i info_type           It can be 'publishers'.


Contract options
=================

-A ur_address          Address of the 'User Repository'
                       contract on the
                       network.
-V ur_version          Version of the target 'User Repository'
                       contract on the network.
-B up_address          Address of the 'User Repository
                       Publishers' contract on the
                       network.
-C pp_address          Address of the 'Package
                       Publishers' contract on the
                       network.

LibEVM options
================

-u                     Whether to retrieve publishers' contract
                       address from user directory or custom
                       deployment.
-d deployments_dir     Contracts deployments directory.
-n network             EVM network name (${_networks[*]}).

Credentials options
====================

-N wallet_name         Wallet name.
-w wallet_path         Wallet path.
-p wallet_password     Wallet password.
-s wallet_seed         Wallet seed path.
-k api_key             Etherscan-like service key.

Application options
====================

-C cache_dir           Work directory.
-H gnupg_home          GNUPG home directory.
-G gnupg_private       GNUPG private home directory.

-h                     Displays help message.
-c                     Enable color output
-v                     Enable verbose output

Bugs
====

https://github.com/themartiancompany/ur/-/issues

Copyright
=========

Copyright Pellegrino Prevete. AGPL-3.0.

See also
========

* ur-package-info
* ur
* ur-packages
* ur-publishers
* ur-purchase
* pub
* aspe

.. include:: variables.rst
