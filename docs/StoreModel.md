[comment]: <> (SPDX-License-Identifier: AGPL-3.0)

[comment]: <> (-------------------------------------------------------------)
[comment]: <> (Copyright © 2024, 2025, 2026  Pellegrino Prevete)
[comment]: <> (All rights reserved)
[comment]: <> (-------------------------------------------------------------)

[comment]: <> (This program is free software: you can redistribute)
[comment]: <> (it and/or modify it under the terms of the GNU Affero)
[comment]: <> (General Public License as published by the Free)
[comment]: <> (Software Foundation, either version 3 of the License.)

[comment]: <> (This program is distributed in the hope that it will be useful,)
[comment]: <> (but WITHOUT ANY WARRANTY; without even the implied warranty of)
[comment]: <> (MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the)
[comment]: <> (GNU Affero General Public License for more details.)

[comment]: <> (You should have received a copy of the GNU Affero General Public)
[comment]: <> (License along with this program.)
[comment]: <> (If not, see <https://www.gnu.org/licenses/>.)

# Application store model

The User Repository (Ur)
allows one to set for sale
applications using the same
cryptocurrency exchange mechanisms
underlying the functioning
of its storage system and protocol, the
[Ethereum Virtual Machine File System](
 https://github.com/themartiancompany/evmfs).

The `ur` command-line application allows
one to publish and set on sale, download and run
an application, a videogame, a song, a videoclip
or any digital media on the store by imposing
an user to execute the purchase function for the
Universal Recipe (PKGBUILD) repository snapshot
corresponding to the latest release
of the selected `pkgbase`, by default the latest
one, in order to get access to the content.

In such a model, free (as in freeware) applications
on the store are simply releases for a `pkgbase`
which have their price set at 0 ether.

The contracts configured in the reference `ur`
client imposes that transactions can happen
either through network gas transfers or by means
of a ERC-20 token and they do forbid users
from reading the evmfs URI pointing to the
OpenPGP signed archive corresponding to the release.

In practice this mean you can sell your digital
items for virtually any currency, including
a custom one.

A characteristic of version 1.0 of the main
Ur contract is all releases are *final*, as in
 **they can't be edited after publication**.

### Copy protection systems

Publishers of closed source applications
are invited to set up further piracy restrictions
for their applications as they see fit, as no
unencrypted smart contract data is private,
so it's not hard at all for any willing user
to get access to the content
sold on the store without purchasing it.

This is not restricting in any way though for
an application developer, as it's trivial
to add an Ur purchase verification routine
in the application itself.

If you are a developer and you want to look
at working code to integrate such a purchase verification
routine into your program, a GNU Bash implementation is
made available inside the
[`aspe`](
  https://github.com/themartiancompany/aspe)
program, which is called from the `ur` program to
handle the Universal Recipes download and checks
for whether a given `pkgbase` has been purchased.
