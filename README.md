# Linuxunderground gentoo.overlay

This Git-based overlay contains the ebuilds I create myself.

Feel free to use the ebuilds yourself as well. If you have any comments, please let me know.

**net-misc/azure-cli**
When you upgrade net-misc/azure-cli, if you get a lot of blocking ebuild,
simply unmerge all azure-* ebuild before upgrade :
```
# qlist -I -C dev-python/azure | xargs emerge -C
# emerge -auv azure-cli
```
(qlist belongs to app-portage/portage-utils)

**app-emulation/ti99sim**
https://www.linuxunderground.be/en/devel/ti99/ti99-dev-notes.html

**net-misc/tlsdate**
https://www.linuxunderground.be/en/devel/tlsdate/tlsdate-dev-notes.html

**See also**
https://www.linuxunderground.be/en/linuxunderground-overlay.html

