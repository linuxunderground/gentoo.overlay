# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Qt-based multi-purpose text editor"
HOMEPAGE="http://hugo.pereira.free.fr/software/index.php?page=software"
SRC_URI="http://hugo.pereira.free.fr/software/tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="aspell"

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtprintsupport:5
		dev-qt/qtxml:5
		aspell? ( app-text/aspell ) "
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_ASPELL=$(usex aspell)
	)
	cmake-utils_src_configure
}
