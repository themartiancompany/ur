[comment]: <> (SPDX-License-Identifier: AGPL-3.0)

[comment]: <> (----------------------------------------------------)
[comment]: <> (Copyright © 2024, 2025, 2026)
[comment]: <> (            Pellegrino Prevete)
[comment]: <> (All rights reserved)
[comment]: <> (----------------------------------------------------)

[comment]: <> (This program is free software: you can redistribute)
[comment]: <> (it and/or modify it under the terms of the)
[comment]: <> (GNU Affero General Public License as published)
[comment]: <> (by the Free Software Foundation, either version)
[comment]: <> (3 of the License.)

[comment]: <> (This program is distributed in the hope that it)
[comment]: <> (will be useful, but WITHOUT ANY WARRANTY;)
[comment]: <> (without even the implied warranty of)
[comment]: <> (MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.)
[comment]: <> (See the GNU Affero General Public License)
[comment]: <> (for more details.)

# Package management

Internally, the `ur` is written to be
modular, so that it can be easily adapted
to work with any pre-existing package maanger.
The default and main is for the `inteppacman`
package manager, which is a pacman extension
with support for handling Android applications,
targeting the
[pacman tree published and mantained](
  https://github.com/themartiancompany/pacman)
published and maintained by The Martian Company,
which includes cross-platform support and
user-level management.

Cross-platform support and user-level management
code comes from the Termux and MSYS2/MinGW projects.
