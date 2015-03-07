# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils games

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~arm"
DESCRIPTION="Lightweight arcade diamonds digging game for X11"

SRC_URI="http://www.ibiblio.org/pub/Linux/games/arcade/${P}.tgz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/games/arcade/"

RDEPEND=""

DEPEND="${RDEPEND}
	x11-misc/imake"

IUSE=""

src_prepare() {
	# http://patch-tracker.debian.org/patch/series/dl/xdigger/1.0.10-13+lenny1/buffers
	epatch "${FILESDIR}"/buffers
	# http://patch-tracker.debian.org/patch/series/dl/xdigger/1.0.10-13+lenny1/start-level-on-move
	epatch "${FILESDIR}"/start-level-on-move
	#
	epatch "${FILESDIR}"/QA-Notice
}

src_configure() {
	# must be hardcoded 
	sed -i \
			-e '/XDIGGER_LIB_DIR/s:/usr/lib/X11:/usr/share/games:' \
			-e '/XDIGGER_HISCORE_DIR/s:/var/X11R6:/var/games:' \
			configure.h
	sed -i \
			-e 's:/usr/lib/X11:/usr/share/games:' \
			-e 's:/var/X11R6:/var/games:' \
			xdigger.man
	#
	sed -i \
			-e "/BINDIR/s:/usr/bin/X11:${GAMES_BINDIR}:" \
			-e '/ICONDIR/s:/usr/include/X11:/usr/share:' \
			-e 's:XDIGGER_HISCORE_DIR:${D}XDIGGER_HISCORE_DIR:' \
			Imakefile
	xmkmf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" install.man || die "emake install.man failed"

	dodoc README
	domenu "${FILESDIR}"/${PN}.desktop

	prepgamesdirs
}
