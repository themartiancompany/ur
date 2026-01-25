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

## Differences with `PKGBUILD`s

While one can indeed publish standard normal `PKGBUILD`s
as Universal Recipes on the Ur, it is highly suggested
the following general rules are respected.

### Switches

Generally speaking, cross-platform changes
which are currently not handled automatically by
[Reallymakepkg](
  https://github.com/themartiancompany),
the recipes do make large use of build switches
set through bash variables of the form `_variable_name`,
usually of boolean (`true`, `false`) or general
string types.

Switches must be generally be overridable and
their value is usually auto-detected from the running
system.

Common switches are:

- `_evmfs` (`bool`):
    retrieve resources from the EVMFS.
- `_git` (`bool`):
    whether to use Git to retrieve Git repositories;
    the presence of this switch depends on the fact
    platforms like Github and Gitlab do offer tarballs
    (archive files).
- `_git_service`:
    common value for this variable are `gitlab` and
    `github`.

## Packaging guidelines

Ur publishers should make sure to respect the following
packaging guidelines in order to streamline
applications public and private security and quality
assurance reviewing:

- all package resources must be stored on the
  [EVMFS](
    https://github.com/themartiancompany);
- packages should be
  [Gur](
    https://github.com/themartiancompany/gur)-compatible;
  in practice this means:
  - for a package called `package` its repository name on
    Github/Gitlab should be `package-ur`;
  - recipes directories must contain continuous
    integration configuration and build files for at least one
    online continuous integration system (for example
    Gitlab or Github); displayed platform compatibility
    on the store, except when set manually, is automatically
    determined on whether the program package includes those
    files and builds on one of those services;

## Examples

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

Contributions are welcome.
