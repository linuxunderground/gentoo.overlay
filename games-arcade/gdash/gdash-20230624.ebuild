# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

MY_P="czirkoszoltan-gdash-f980da7f4318"

DESCRIPTION="Clone of Boulderdash (a.k.a Emerald Mine on the Amiga)"
HOMEPAGE="https://bitbucket.org/czirkoszoltan/gdash/"
SRC_URI="https://bitbucket.org/czirkoszoltan/gdash/get/f980da7f4318.zip -> ${P}.zip"
S="${WORKDIR}/${MY_P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="media-libs/sdl2-mixer[vorbis]
	media-libs/sdl2-image[png]
	x11-libs/gtk+:3"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

BDEPEND="app-arch/unzip"

src_install() {
	default

	domenu gdash.desktop
	doicon gdash.png
}
