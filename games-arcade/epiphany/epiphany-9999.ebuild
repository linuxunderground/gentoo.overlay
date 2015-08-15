# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

WANT_AUTOMAKE="1.10"

inherit autotools eutils games

if [[ ${PV} == "9999" ]]; then
	inherit cvs
	ECVS_SERVER="epiphany.cvs.sourceforge.net:/cvsroot/epiphany"
	ECVS_MODULE="epiphany"
	SRC_URI=""
	S="${WORKDIR}/${PN}"
else
	SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="Clone of Boulderdash (a.k.a Emerald Mine on the Amiga)"

HOMEPAGE="http://epiphany.sourceforge.net/site/"

RDEPEND="media-libs/libsdl[sound,video]
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}"

IUSE=""

src_prepare() {
	if [[ ${PV} == "9999" ]]; then
		epatch "${FILESDIR}"/gcc-optimization-"${PV}".patch
		eautoreconf
	else
		epatch "${FILESDIR}"/gcc-optimization.patch
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon "${FILESDIR}"/epiphany-game.xpm
	domenu "${FILESDIR}"/epiphany-game.desktop

	dodoc AUTHORS
	dodoc ChangeLog
	dodoc Tech
	dodoc TODO
	dodoc README

	prepgamesdirs
}
