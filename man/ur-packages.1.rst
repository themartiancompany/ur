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
ur-packages
===============

---------------------------------------------
User Repository packages' list management
---------------------------------------------
:Version: ur-packages |version|
:Manual section: 1

Synopsis
========

ur-packages *[options]* *command*

Description
===========

User Repository packages' list management


Commands
==========

* list                 Lists all registered publishers'
                       packages available on
                       the User Repository.
* update               Updates the local list for
                       available packages.

Networks
==========

Currently available networks are
Gnosis and DogeChain, respectively
for purchasing and selling applications
with Dollars and Dogecoins.

Options
========

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
-n network             EVM network name.

Credentials Options
=====================
-N wallet_name         Wallet name.
-w wallet_path         Wallet path.
-p wallet_password     Wallet password.
-s wallet_seed         Wallet seed path.

Application options
====================

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

* ur
* ur-package-info
* ur-publishers
* ur-purchase
* pub
* aspe
* evmfs

.. include:: variables.rst
