# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Console SID file player. Very small and light."
HOMEPAGE="http://www-stud.rbi.informatik.uni-frankfurt.de/~sinsch/new/tinysid.htm"
SRC_URI="https://web.archive.org/web/20230415151324/https://www.linuxunderground.be/distfiles/${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="alsa"

RDEPEND="alsa? ( media-libs/alsa-oss )"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/do_not_force_compiler.patch"
	"${FILESDIR}/fix_declaration.patch"
	"${FILESDIR}/latest_news.patch"
	)

src_install() {
	dobin tinysid
	dodoc README

	ewarn "If you do not use OSS, you have to use an OSS wrapper."
	ewarn "I only tested alsa OSS wrapper."
	if use alsa; then
		ewarn "$ aoss tinysid my_sid_file.sid"
	fi
}
