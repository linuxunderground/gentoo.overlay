# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/NagyD/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://codeload.github.com/NagyD/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Open-source port of Prince of Persia, based on the disassembly of DOS version."
HOMEPAGE="https://www.princed.org/"
S="${WORKDIR}/${P}/src"
LICENSE="GPL-3"
SLOT="0"

DOCS=( doc/Readme.txt doc/ChangeLog.txt doc/bugs.txt doc/mod.ini )

BDEPEND="dev-build/ninja"

RDEPEND="media-libs/sdl2-image
	media-libs/sdl2-mixer"

DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}/gcc-fix.patch"

	sed -i \
		-e 's:"SDLPoP.ini":"/usr/share/SDLPoP/SDLPoP.ini":' \
		options.c || die
	sed -i \
		-e 's:"data/icon.png:"/usr/share/pixmaps/SDLPoP.png:' \
		-e 's:"data/:"/usr/share/SDLPoP/data/:' \
		-e 's:"mods/:"/usr/share/SDLPoP/mods/:' \
		seg009.c || die

	cmake_src_prepare
}

src_configure() {
	SDL2="${EPREFIX}/usr"
	cmake_src_configure
}

src_install() {
	cd ..

	mv data/icon.png "${PN}.png" || die
	doicon "${PN}.png"
	make_desktop_entry "prince" "Prince of Persia" "${PN}"

	insinto /usr/share/${PN}
	doins SDLPoP.ini
	doins -r data
	doins -r mods

	dobin prince

	einfo "You'll find config file at /usr/share/SDLPoP/SDLPoP.ini"
}
