# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils games

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86 ~arm"
DESCRIPTION="A split-screen multiplayer remake of BoulderDash game"

SRC_URI="http://www.karlin.mff.cuni.cz/~benes/doubledash/${P}.tar.gz"
HOMEPAGE="http://www.karlin.mff.cuni.cz/~benes/doubledash/"

RDEPEND="media-libs/sdl-image"

DEPEND="${RDEPEND}"

IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/gentoo.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png

	dodoc README

	prepgamesdirs
}
