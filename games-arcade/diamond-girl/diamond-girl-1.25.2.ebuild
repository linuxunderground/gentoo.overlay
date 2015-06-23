# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils games flag-o-matic autotools

if [[ ${PV} == "9999" ]]; then
	ESVN_REPO_URI="http://diamond-girl.googlecode.com/svn/trunk/"
	inherit subversion
	SRC_URI=""
else
	SRC_URI="http://www.netikka.net/joyr/diamond_girl/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="Single player puzzle game with a time constraint"

HOMEPAGE="http://www.netikka.net/joyr/diamond_girl/index.html"

IUSE="+mixer compressed-data"

RDEPEND="mixer? ( media-libs/sdl-mixer[vorbis] )
	media-libs/libsndfile
	media-libs/sdl-gfx
	media-libs/sdl-image[png]
	media-libs/lib3ds
	>=media-libs/glew-1.6.0-r1
	media-libs/openal"

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
	sed -i -e 's:Icon=:Icon=/usr/share/pixmaps/:' diamond-girl.desktop
}

src_configure() {
	append-cflags "-DNDEBUG"
	append-cxxflags "-DNDEBUG"
	egamesconf --without-lua
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

	#dosym diamond_girl "${GAMES_BINDIR}"/diamond-girl

	# CREDITS and Welcome.txt files are necessary in
	# /usr/share/games/diamond_girl
	rm "${D}${GAMES_DATADIR}"/diamond-girl/Changelog
	rm "${D}${GAMES_DATADIR}"/diamond-girl/LIC*
	rm "${D}${GAMES_DATADIR}"/diamond-girl/READM*
	rm -r "${D}${GAMES_DATADIR}"/pixmaps
	rm -r "${D}${GAMES_DATADIR}"/applications

	prepgamesdirs
}
