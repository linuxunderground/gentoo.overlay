# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib eutils udev

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86 ~arm"
DESCRIPTION="Generic driver for ACS (CCID and non-CCID) Smart Card Reader."

SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.bz2"
HOMEPAGE="http://acsccid.sourceforge.net/"

#unlike app-crypt/ccid, libusb-compat is required (virtual/libusb:0)
RDEPEND=">=sys-apps/pcsc-lite-1.8.3
	virtual/libusb:0
	!app-crypt/ccid
	!app-crypt/acr38u"
DEPEND="${RDEPEND}
	kernel_linux? ( virtual/pkgconfig )
	sys-devel/flex"

IUSE=""

src_prepare() {
	sed -i -e 's:GROUP="pcscd":ENV{PCSCD}="1":' src/92_pcscd_acsccid.rules
	sed -i -e 's:GROUP="pcscd":ENV{PCSCD}="1":' src/92_pcscd_acsccid_group.rules
}

src_install() {
	default

	if use kernel_linux; then
		udev_newrules src/92_pcscd_acsccid.rules 92-pcsc-acsccid.rules
		udev_newrules src/92_pcscd_acsccid_group.rules 92-pcsc-acsccid_group.rules
	fi
}
