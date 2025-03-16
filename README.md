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

# Ur

Decentralized, distributed, permissionless, uncensorable, undeletable,
unstoppable, User Repository and Application Store.

### Overview

The Ur is an integral part of the OS-like software collection known
as Life, and its main extension, DogeOS, and part of the Human
Instrumentality Project (HIP).

Formally speaking, the Ur is the set of programs and smart contracts
you find in this software repository, together with their network
deployments, whose addresses are found in the `contracts/deployments`
directory, together with the universal build recipes for the programs
published on it, which can seamlessly build on the largest array
of operating system platforms.

Many of the Ur desirable properties derive from it being a program
on permissionless cryptocurrency
[EVM-compatible](
  https://ethereum.org/en/developers/docs/evm/)
blockchain networks and hosting its software build recipes on the
uncensorable, undeletable,
[Ethereum Virtual Machine File System](
 https://github.com/themartiancompany/evmfs).

As most other HIP program names, the word Ur word has many meanings,
and refer to many concepts, including:

- **U**ser **R**epository,
- **U**niversal **R**ecipe,
- the Sumerian city state,
- the adjective **your**,
- the statements **you're** and **you are**.

Many more meanings, not all of which can be easily expressed
in public in front of a young audience, are omitted for the sake
of decency. It is still opinion of Ur developers it is wise to tell
you in advance, to avoid situations like the one Linus Torvalds has
created with the Git software.

In particular the Ur deprecates the
[Aur](
  https://aur.archlinux.org),
the Arch Linux User Repository, a theoretically permissionless
user repository for the Arch Linux distribution plagued instead
by unsolvable censorship issues deriving from its inherent centralized
design which the author of the Ur has been a significant contributor
for more than a decade.

The inception of the Ur has been long and troubled and many times
the repository and the softwares at the same time it contains
and it is part of have risked to never see the light.

Before being announced to the public, the Ur has been in the works
for at least three years and conceptualized way earlier, well before
its author had learned how to handle the technologies needed to
write it.

###  How to install

The Ur can be installed in a plethora of ways.
Most of them use the Makefile provided in
this repository, so more or less you just have
to type:

```bash
$ make
# make \
   install
```

By default the application expects to be run from a
[FHS /usr tree](
  https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
but you can also run it standalone.

Ur's universal build recipe, seamlessly compatible with all
[pacman](
  https://man.archlinux.org/man/pacman.8.en)
environments on virtually all operating systems,
is available on the Ur itself (so if you got this
repository intact you should be able to recover it
from the
[Ethereum Virtual Machine File System](
  https://github.com/themartiancompany/evmfs)
at any time).
HTTP mirrors are made available on
[The Martian Company's Github](
  https://github.com/themartiancompany/ur-ur).

That can be built using
[reallymakepkg](
  https://github.com/themartiancompany/reallymakepkg)
and depending on the OS platform even using the standard
[makepkg](
  https://man.archlinux.org/man/makepkg.8.en).

Missing dependencies will be reported to user at runtime
so if you're looking for a complete list we strongly
suggest consulting the universal build recipe.

# Documentation

Manual entries for the programs making up the Ur
can be consulted using the `man` utility and are
automatically installed with the program.

```bash
man \
  ur
```

### License

The Ur is developed by Pellegrino Prevete and released under the
terms of the GNU Affero General Public License version 3.
