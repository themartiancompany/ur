# Universal Recipes

Ur
[PKGBUILD](
  https://wiki.archlinux.org/title/PKGBUILD)s
are also called *universal recipes*, because they
are supposed to run on all Life and DogeOS supported
platforms, such as GNU/Linux, Android and Windows.

In particular, this makes Ur recipes seamlessly compatible
with Arch Linux, with the Pacman-based Termux
Android runtime environment and with the MSYS2/MINGW
Windows runtime environments, given they are built using
[`reallymakepkg`](
  https://github.com/themartiancompany/reallymakepkg).

The viceversa though is not true, as Arch Linux developers explicitly
forbid publishing on their repos recipes which are
compatible with many operating systems or platforms at once.

For Termux it is instead currently under evaluation merging
the Tur into the Ur.
