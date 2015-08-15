# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils games

SLOT="0"
LICENSE="HPND"
KEYWORDS="~x86"
DESCRIPTION="BoulderDash SVGAlib/X11 game with original ZX Spectrum/Commodore 64 graphics and levels"

SRC_URI="http://www.ibiblio.org/pub/Linux/X11/games/${P}-b5.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/X11/games/"

RDEPEND="X? ( x11-base/xorg-x11 )
	svga? ( media-libs/svgalib )"

DEPEND="${RDEPEND}"

IUSE="+X svga"

S="${WORKDIR}/${P}-b5"

src_prepare() {
	epatch "${FILESDIR}"/compilation.patch
	epatch "${FILESDIR}"/fix_path.patch
}

src_configure() {
	sed -i -e 's:/usr/local/games/lib:/usr/share/games:' config.h.in
	egamesconf $(use_with X x) $(use_with svga svgalib)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	domenu "${FILESDIR}"/${PN}.desktop
	doicon data/graphics/bd_icon.xpm

	dodoc "${FILESDIR}"/README
	dodoc BoulderDash-1.0-b5.lsm

	prepgamesdirs
	ewarn "Before starting BoulderDash, see README file"
	use svga && ewarn "BoulderDash with svgalib not tested !"
}
