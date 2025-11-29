[comment]: <> (SPDX-License-Identifier: AGPL-3.0)

[comment]: <> (-------------------------------------------------------------)
[comment]: <> (Copyright © 2024, 2025  Pellegrino Prevete)
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

# Universal Recipes

Ur
[PKGBUILD](
  https://wiki.archlinux.org/title/PKGBUILD)s
are also called *universal recipes*, because they
are supposed to run on all Life and DogeOS supported
platforms, such as GNU/Linux, Android and Windows.

In particular, this makes Ur recipes seamlessly compatible
with
[Arch Linux](
  https://archlinux.org),
with the Pacman-based
[Termux](
  https://termux.dev)
Android runtime environment and with the
[MSYS2](
  https://msys2.org)
Windows runtime environments, given they are built using
[`reallymakepkg`](
  https://github.com/themartiancompany/reallymakepkg).

While Ur recipes and packages are compatible with the
all of the above platform, at least Arch Linux developers explicitly
forbid publishing on their repos recipes which are
compatible with many operating systems or platforms at once.

For Termux it is instead currently under evaluation
[merging the Tur into the Ur](
  https://github.com/termux-user-repository/tur/issues/1486).

### Examples

For an updated reference Universal Recipe `PKGBUILD` you
can consult the one for the
[`evmfs`](
  https://github.com/themartiancompany/evmfs-ur).

As you notice most of the extra code compared
to a regular `PKGBUILD` is exclusively relative
to mantaining the recipe compatible with systems who do not
have available the `evmfs` command, so
one of the vanilla base operating systems without any
HIP component installed.

Whenever this retro-compatibility requirement
can be omitted, for example for all the software
which is not distributed through HTTP mirrors,
you see the recipes are regular Arch Linux `PKGBUILD`s.

### Compatibility with non-Pacman based runtime environment

While foreseen in a future release, recipe compatibility
with packagement systems such as `dpkg` and `rpm` is
currently not implemented.
