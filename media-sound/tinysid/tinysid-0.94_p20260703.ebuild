# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Console SID file player. Very small and light."
HOMEPAGE="http://www-stud.rbi.informatik.uni-frankfurt.de/~sinsch/new/tinysid.htm"
SRC_URI="https://codeload.github.com/linuxunderground/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="alsa oss"
REQUIRED_USE="alsa? ( !oss )"

RDEPEND="alsa? ( media-libs/alsa-lib )"

DEPEND="${RDEPEND}"

src_compile() {
	# ALSA is the default Sound System
	if use oss; then
		emake SS="OSS"
	else
		emake
	fi
}

src_install() {
	dobin tinysid
	dodoc README.md
}
