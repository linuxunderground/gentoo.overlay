# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils games

MY_P="${P}unstable"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Clone of Boulderdash (a.k.a Emerald Mine on the Amiga)"

SRC_URI="http://gdash.googlecode.com/files/${MY_P}.tar.gz"
HOMEPAGE="http://code.google.com/p/gdash/"

IUSE=""

RDEPEND="media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	>=x11-libs/gtk+-2.2:2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	domenu gdash.desktop
	doicon gdash.png

	rm -r "${D}${GAMES_DATADIR}"/pixmaps
	rm -r "${D}${GAMES_DATADIR}"/applications

	prepgamesdirs
}
