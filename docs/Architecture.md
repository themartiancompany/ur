# Architecture

Similarly to most others
[libEVM](
  https://github.com/themartiancompany/libevm)
applications the Ur is made up
of a set of Solidity contracts,
of their deployment configurations and of the
native computer clients used to interact
with the deployments.

Being the Ur a permissionless repository
possibly subjected to an immense amount of spam,
no package browsing or indexing functionalities
have been made available directly through the
main `UserRepository` contract.

Those features are provided instead by the
`PackagePublishers` contract to publishers
and developers who have signed up as such
on the `UserRepositoryPublishers` contract.

It must be underlined that while by default
package browsing and indexing are indeed a
permissioned feature, the signing up process
by itself is permissionless
and it is only provided as an anti-spam measure
as well as a way to fund the Repository development.

## Contracts

### `UserRepository`

For each
[pkgbase](
  https://wiki.archlinux.org/title/PKGBUILD)
users are assigned a
personal namespace on which they can write
progressive revisions of the package data.

Application purchases are tied to a
publisher-specific recipe revision.

After being published with
[`pub`](
  https://github.com/themartiancompany/pub),
applications can be installed and run with the
`ur` command.

Further details on publishing applications
are available on the `pub` manual page.

The `ur` command uses
[`aspe`](
  https://github.com/themartiancompany/aspe)
to locally retrieve the purchased build recipes.

None of an application revision's
published data can be edited a posteriori.

While revisions are progressive and by default
the Ur will try to acquire the latest, developers
are allowed to suggest users a specific
`targetRevision` over others.

#### Version 1.0

The types of data users need to provide
in order to publish an application on 1.0
repositories are:

- `recipe`:
    the build recipe script repository, as an
    [EVMFS](
      https://github.com/themartiancompany/evmfs)
    URI to an
    [EVM GPG signed](
      https://github.com/themartiancompany/evm-gnupg),
    zlib-compressed, tar archive,
    the signing key of which has been correctly published on the
    [EVM Contracts' Source Index](
      https://github.com/themartiancompany/evm-contracts-source-index)
    (`<pkgbase>.tar.xz.gpg`), containing a
    directory named the same as the `pkgbase`
    with in it at the very least the
    [PKGBUILD](
      https://wiki.archlinux.org/title/PKGBUILD)
    and its license file; the directory can
    contain additional files as well such as
    `.install` files and patches; while the Ur
    is currently designed to only handle pacman
    binary packages, it must be noted that
    requirement is not written on stone.
- `price`:
    the price, measured in wei, at which the
    application is being sold.

For further informations about the application
publishing process, in particular about
revenue fees, consult the
[`pub`](
  https://github.com/themartiancompany/pub)
manual.

The full Solidity contract source file is in
the `contracts/UserRepository/1.0` directory.

#### Version 1.1

The main difference with version 1.0 is
version 1.1 adds an optional `currency`
address field which can be used to specify an
[ERC-20 token](
  https://ethereum.org/en/developers/docs/standards/tokens/erc-20)
the publisher
wants the application to be purchased
with.

This specific feature has been added
in the context of the
[Google Cloud](
  https://cloud.google.com)
and
[PayPal](
  https://paypal.com)
sponsored
"[Seamless transactions, infinite possibilities](
  https://github.com/themartiancompany/seamless-transactions-infinite-possibilities-hackaton)"
hackaton organized by
[StackUp](
  hackaton.stackup.dev).

The full Solidity contract source file is in
the `contracts/UserRepository/1.1` directory.

### `UserRepositoryPublishers`

The `UserRepositoryPublishers` contract allows
publishers and developers to sign up as such
in order to have the list of their published applications
browsable and indexed.

#### Version 1.0

It provides the basic facilities to let publishers
sign up to the Repository.
The contract requires publishers and developers
to pay a one time 10 ethers gas units anti-spam 
fee.

So for example for the Ur Gnosis deployment
the sign up fee is $10, while for the Dogechain
deployment is 10 DOGE.

The full Solidity contract source file is in
the `contracts/UserRepositoryPublishers/1.0` directory.
