# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="A split-screen multiplayer remake of BoulderDash game"

SRC_URI="http://download.wonderland.cz/${P}.tar.gz"
HOMEPAGE="http://www.wonderland.cz/software/#doubledash"

RDEPEND="media-libs/sdl-image"

DEPEND="${RDEPEND}"

IUSE=""

src_prepare() {
	eapply "${FILESDIR}"/gentoo.patch
	eapply_user
}

src_install() {
	default

	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png

	dodoc README
}
