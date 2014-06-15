# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils games flag-o-matic autotools

if [[ ${PV} == "9999" ]]; then
	ESVN_REPO_URI="http://diamond-girl.googlecode.com/svn/trunk/"
	inherit subversion
	SRC_URI=""
else
	SRC_URI="http://www.netikka.net/joyr/diamond_girl/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="Clone of Boulderdash (a.k.a Emerald Mine on the Amiga)"

HOMEPAGE="http://www.netikka.net/joyr/diamond_girl/index.html"

IUSE="+mhash compressed-data"

RDEPEND="media-libs/sdl-mixer
	media-libs/sdl-gfx
	media-libs/sdl-image[png]
	media-libs/lib3ds
	>=media-libs/glew-1.6.0-r1
	media-libs/openal
	mhash? ( app-crypt/mhash )
	dev-lang/lua"

DEPEND="${RDEPEND}
	>=dev-libs/json-c-0.11
	media-libs/libmikmod
	media-gfx/xcftools
	compressed-data? ( media-sound/vorbis-tools
		media-gfx/optipng )
	virtual/pkgconfig"

src_prepare() {
	if [[ ${PV} == "9999" ]]; then
		sed -i -e '/autoreconf/d' autogen.sh
		./autogen.sh
		eautoreconf
	fi
	sed -i -e 's:\${BINDIR}/::;s:\${PIXMAPSDIR}:/usr/share/pixmaps:;s:Game;:Game;ArcadeGame;:;$d' diamond_girl.desktop.template
}

src_configure() {
	append-cflags "-DNDEBUG"
	append-cxxflags "-DNDEBUG"
	egamesconf $(use_enable compressed-data)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	domenu diamond_girl.desktop
	doicon themes/default/gfx/diamond_girl.png

	dodoc CREDITS
	dodoc Changelog
	dodoc README.settings
	dodoc README.sfx
	dodoc README

	dosym diamond_girl "${GAMES_BINDIR}"/diamond-girl

	# CREDITS and Welcome.txt files are necessary in
	# /usr/share/games/diamond_girl
	rm "${D}${GAMES_DATADIR}"/diamond-girl/Changelog
	rm "${D}${GAMES_DATADIR}"/diamond-girl/LIC*
	rm "${D}${GAMES_DATADIR}"/diamond-girl/READM*
	rm -r "${D}${GAMES_DATADIR}"/pixmaps
	rm -r "${D}${GAMES_DATADIR}"/applications

	prepgamesdirs
}
