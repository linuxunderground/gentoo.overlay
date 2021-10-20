# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="C65 / MEGA65 emulator : THE COMMODORE 65 LIVES AGAIN"

EGIT_REPO_URI="https://github.com/lgblgblgb/${PN}.git"
SRC_URI="roms? (
	http://www.zimmers.net/anonftp/pub/cbm/firmware/computers/c65/911001.bin
	https://files.mega65.org/files/other/920228_5GTvvJ.BDF
	)"

HOMEPAGE="https://www.mega65.org"

IUSE="+roms"

RDEPEND="x11-libs/gtk+:3
	media-libs/libsdl2[haptic]"

DEPEND="${RDEPEND}"

BDEPEND="roms? ( dev-util/bsdiff )"

src_prepare() {
	cp "${DISTDIR}/911001.bin" "${S}" || die
	cp "${DISTDIR}/920228_5GTvvJ.BDF" "${S}" || die
	sed -i -e '/local/ d' build/Makefile.common || die
	sed -i \
			-e '/^TARGETS/ d' \
			-e '/^ARCHS/ i\
TARGETS = mega65 c65' \
			Makefile || die

	eapply_user
}

src_install() {
	export INSTALL_BINDIR="${ED}/usr/bin"

	ewarn "In order to run the emulator, you need to get ROM. See:"
	ewarn "https://gist.github.com/ricardoquesada/9f6cf7bef3e6952d21ee792524a57aaa"
	if use roms; then
		bspatch 911001.bin 920228.bin 920228_5GTvvJ.BDF || die
		insinto /usr/share/xemu/
		doins 920228.bin
		doins 911001.bin
		ewarn "You'll find ROM files in /usr/share/xemu"
	fi

	insinto /usr/bin
	dosym xemu-xmega65 /usr/bin/xmega65
	dosym xemu-xc65 /usr/bin/xc65

	emake DESTDIR="${ED}" install || die "emake install failed"
}
