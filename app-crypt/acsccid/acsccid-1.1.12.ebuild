# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools udev

DESCRIPTION="Generic driver for ACS (CCID and non-CCID) Smart Card Reader."
HOMEPAGE="https://github.com/acshk/acsccid"
SRC_URI="https://codeload.github.com/acshk/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="sys-apps/pcsc-lite
	virtual/libusb:1
	!app-crypt/acr38u"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/flex
	sys-devel/gettext"
BDEPEND="kernel_linux? ( virtual/pkgconfig )"

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
