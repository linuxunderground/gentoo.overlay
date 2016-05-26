# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils flag-o-matic

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/Peanhua/${PN}.git
		https://github.com/Peanhua/${PN}.git"
	inherit git-r3 autotools
	SRC_URI=""
else
	SRC_URI="http://www.netikka.net/joyr/diamond_girl/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="Single player puzzle game with a time constraint"

HOMEPAGE="http://www.netikka.net/joyr/diamond_girl/index.html"

IUSE="+mixer"

RDEPEND="mixer? ( media-libs/sdl-mixer[vorbis] )
	media-libs/libsndfile
	media-libs/sdl-gfx
	media-libs/sdl-image[png]
	>=media-libs/glew-1.6.0-r1
	media-libs/openal"

DEPEND="${RDEPEND}
	media-libs/assimp
	media-gfx/blender
	>=dev-libs/json-c-0.11
	media-libs/libmikmod
	media-gfx/xcftools
	virtual/pkgconfig"

src_prepare() {
	eapply_user
	if [[ ${PV} == "9999" ]]; then
		eautoreconf
	fi
	sed -i -e 's:Icon=:Icon=/usr/share/pixmaps/:' diamond-girl.desktop
}

src_configure() {
	append-cflags "-DNDEBUG"
	append-cxxflags "-DNDEBUG"
	econf --without-lua
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	domenu diamond-girl.desktop
	doicon themes/default/gfx/diamond-girl.png

	dodoc CREDITS
	dodoc Changelog
	dodoc README
	dodoc README.sfx
	dodoc README.translations

	# CREDITS and Welcome.txt files are necessary in
	# /usr/share/games/diamond_girl
	rm "${D}${DATADIR}"/diamond-girl/Changelog
	rm "${D}${DATADIR}"/diamond-girl/LIC*
	rm "${D}${DATADIR}"/diamond-girl/READM*
	rm -r "${D}${DATADIR}"/pixmaps
	rm -r "${D}${DATADIR}"/applications

	prepgamesdirs
}
