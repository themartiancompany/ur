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


=====
ur
=====

------------------
User Repository
------------------
:Version: ur |version|
:Manual section: 1

Synopsis
========

ur *[options]* *package*

Description
===========

*ur* is the reference implementation of the Ur,
the decentralized, distributed, uncensorable, undeletable,
permissionless user repository and application store
of Life and DogeOS.

Networks
==========

Currently available networks are
Gnosis and DogeChain, respectively
for purchasing applications with
Dollars and Dogecoins.

Options
=========

-S package_origin      Package origin, it can be
                       'ur' and 'fur'.
-P package_publisher   Package publisher.
-r target_revision     Package target revision.
-w work_dir            Work directory.
-b y/n                 Whether to run the program
                       after installed.
-d y/n                 Whether to skip dependencies
                       check when installing.

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
* ur-packages
* ur-publishers
* ur-purchase
* pub
* aspe

.. include:: variables.rst
