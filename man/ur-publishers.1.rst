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


=============
ur-publishers
=============

----------------------------------------------
User Repository publishers management command
----------------------------------------------
:Version: ur-publishers |version|
:Manual section: 1

Synopsis
========

ur-publishers *[options]* *command* *[args]*

Description
===========

*ur-publishers* is the command through which
users can update and retrieve the list of the
user repository publishers and register themselves
as publishers.

Commands
===========

* list

    Lists all the registered publishers
    on the User Repository.

* register              
    *target_address*

    Register a new publisher on the User Repository.
    An anti-spam fee is currently active on all
    User Repository deployments to avoid package name
    squatting and spamming the publishers list.
    See the 'Enrolling fees' section below for
    further informations.

* update

    Updates the list of registered publishers
    on the User Repository.

Networks
==========

Currently available networks are
Gnosis and DogeChain, respectively
for purchasing and selling applications
with Dollars and Dogecoins.

Enrolling fees
================

Current enrolling one-time anti-spam fees
for User Repository publishers are:

* 10 Dollars on the Gnosis Network.
* 10 Dogecoins on DogeChain.

Fees are sent to Ur authors to account
for the User Repository development costs.

Publishing applications on the User Repository 
does not require publishers to sign up,
still unregistered publishers don't have their
applications indexed and searchable through the
*ur-packages* command and for users to install
them they have to know the unregistered publisher's
addresses in advance and manually input it
at install/run time using the '-P' option.


Options
========

-A up_address          Address of the 'User Repository
                       Publishers' contract on the
                       network.
-V up_version          Version of the target 'User Repository
                       Publishers' contract.
-u                     Whether to retrieve publishers' contract
                       address from user directory or custom
                       deployment.
-d deployments_dir     Contracts deployments directory.
-N wallet_name         Wallet name.
-w wallet_path         Wallet path.
-p wallet_password     Wallet password.
-s wallet_seed         Wallet seed path.
-n network             EVM network name (${_networks[*]}).
-k api_key             Etherscan-like service key.
-C cache_dir           Work directory.
-H gnupg_home          GNUPG home directory.
-G gnupg_private       GNUPG private home directory.
-y y/n                 Whether to update publishers' keys.
-P y/n                 Whether to publish key.
-U user_name           Publisher's key username.
-f key_fingerprint     Publisher's key fingerprint.

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

* ur-publishers -h
* ur
* ur-package-info
* ur-purchase
* pub

.. include:: variables.rst
