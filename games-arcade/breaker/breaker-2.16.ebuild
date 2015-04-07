# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils games

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~arm"
DESCRIPTION="Arkanoid clone written with the SDL library"

SRC_URI="mirror://sourceforge/breaker10/breaker216.tar.gz"
HOMEPAGE="http://oldschoolprg.x10.mx"

IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/breaker3264

src_prepare() {
	epatch "${FILESDIR}/${PV}/0001-install.patch"
	epatch "${FILESDIR}/${PV}/0002-dot_breaker_dir.patch"
	export PREFIX="/usr"
	export BINDIR="${GAMES_BINDIR}"
	export DATADIR="${GAMES_DATADIR}/breaker"
}

src_install() {
	export PREFIX="${D}/usr"
	export BINDIR="${D}${GAMES_BINDIR}"
	export DATADIR="${D}${GAMES_DATADIR}/breaker"

	emake DESTDIR="${D}" install || die "emake install failed"

	newdoc _README.txt README.TXT
	if has ${LINGUAS} fr fr_FR; then
		newdoc _LISEZMOI.txt LISEZMOI.TXT
	fi

	prepgamesdirs
}
