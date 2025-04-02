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


===========
ur-purchase
===========

--------------------------------------------------------
User Repository application purchase command
--------------------------------------------------------
:Version: ur-purchase |version|
:Manual section: 1

Synopsis
========

ur-purchase *[options]* *package* *publisher* *revision*

Description
===========

*ur-purchase* is the command to use to purchase
applications on the Ur user repository and application
store.

Purchases are non-revocable and valid for the specific
revision (version) of the purchased build recipe.

Packages (programs, libraries) must be purchased
even if they are free.

Packages can be purchased at an higher price
compared to target at user discretion.

Application store fees
=======================

Publishing packages on the User Repository is permissionless
and free, still when the repository is used a 'store' and
applications are sold for money, a 'fair' share of the application
price is sent to Ur authors to account for development and
software maintainance costs.

For both Dollars and Dogecoins purchases Ur authors shares
are the following:

* 5%  for applications sold between $1 / 1 DOGE,
* 10% for applications sold between $5 / 5 DOGE,
* 20% for applications sold for over $10 / 10 DOGE.

Ur authors reserve the right to update the shares percentages
in subsequent versions of the User Repository contracts
to maintain them 'fair'.

In no case Ur authors can prohibit users' access
to their purchase applications.

Due to the permissionless nature of the store though, Ur authors
reserve the right to inform users a legal entity may have required
them to publicly tell purchasing a certain application
constitutes a law infringement in certain jurisdictions, in order
not to be considered complicit of the infringements.

Networks
==========

Currently available networks are
Gnosis and DogeChain, respectively
for purchasing applications with
Dollars and Dogecoins.

Options
=========

-r <recipient>         Address of the user for which the package
                       recipe is being purchased.
                       Default: ${target_recipient}
-P <price>             Manually specify an amount to purchase
                       the recipe for.
                       Default: ${target_price}
-m <measure_unit>      Unit of measure for the network
                       purchasing currency.
                       It can be 'ether' or 'wei'.
                       Default: ${measure_unit}
-y                     If enabled do not ask for confirmation
                       before purchase.
                       Default: ${auto_confirm}

Contract options
=================

-A <ur_address>        Address of the 'User Repository'
                       contract on the
                       network.
                       Default: ${ur_address}
-V <ur_version>        Version of the target 'User Repository'
                       contract.
                       Default: ${ur_version}

LibEVM options
===============

-u                     Whether to retrieve publishers' contract
                       address from user directory or custom
                       deployment.
                       Default: ${user_level}
-d <deployments_dir>   Contracts deployments directory.
                       Default: ${deployments_dir}
-n <network>           EVM network name (${_networks[*]}).
                       Default: ${target_network}

Credentials Options
====================

-N <wallet_name>       Wallet name.
                       Default: ${wallet_name}
-w <wallet_path>       Wallet path.
                       Default: ${wallet_path}
-p <wallet_password>   Wallet password.
                       Default: ${wallet_password}
-s <wallet_seed>       Wallet seed path.
                       Default: ${wallet_seed}
-k <api_key>           Etherscan-like service key.
                       Default: ${api_key}

Application options
=====================

-C <cache_dir>         Work directory.
                       Default: ${cache_dir}

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
* ur-packages
* ur-publishers
* pub
* aspe

.. include:: variables.rst
