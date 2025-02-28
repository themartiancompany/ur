# Ur

Decentralized, distributed, permissionless, uncensorable, undeletable,
unstoppable, User Repository and Application Store.

The Ur is an integral part of the OS-like software collection known
as Life, and its main extension, DogeOS, and part of the Human
Instrumentality Project (HIP).

Formally speaking, the Ur is the set of programs and smart contracts
you find in this software repository, together with their network
deployments, whose addresses can be found in the `contracts/deployments`
directory.

Many of the Ur desirable properties derive it being a program
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
of decency. It is still opinion of Ur developers it's wise to tell
you in advance, to avoid situations like the one Linus Torvalds has
created with the Git software.

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

### License

The Ur is developed by Pellegrino Prevete and released under the
terms of the GNU Affero General Public License version 3.
