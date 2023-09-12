# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools udev

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="Generic driver for ACS (CCID and non-CCID) Smart Card Reader."

HOMEPAGE="https://github.com/acshk/acsccid"
SRC_URI="https://codeload.github.com/acshk/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"

RDEPEND=">=sys-apps/pcsc-lite-1.8.3
	virtual/libusb:1
	!app-crypt/ccid
	!app-crypt/acr38u"
DEPEND="${RDEPEND}
	kernel_linux? ( virtual/pkgconfig )
	dev-lang/perl
	sys-devel/flex
	sys-devel/gettext"

IUSE=""

src_prepare() {
	default
	# See bootstrap file
	mkdir config || die
	cp /usr/share/gettext/config.rpath config || die
	eautoreconf
}

src_install() {
	default

	if use kernel_linux; then
		udev_dorules "${FILESDIR}"/92-pcsc-acsccid.rules
	fi
}

pkg_postinst() {
	if use kernel_linux; then
	    udev_reload
	fi
}

pkg_postrm() {
	if use kernel_linux; then
	    udev_reload
	fi
}
