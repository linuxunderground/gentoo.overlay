# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/notepadqq/${PN}.git"
	inherit git-r3
	SRC_URI=""
else
	# Tarball release does not compile at all :-(
	SRC_URI="https://codeload.github.com/${PN}/${PN}/tar.gz/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Qt5 text editor for developers"
HOMEPAGE="http://notepadqq.altervista.org"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtwebkit:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

src_prepare() {
	eapply_user
	sed -i \
		-e 's:/lib/notepadqq/:/bin/:' \
		src/ui/ui.pro || die
	sed -i -e 's:\.\./\.\.:\.\.:' src/ui/notepadqq.cpp || die
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" ${PN}.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	# This should break nothing under Gentoo.
	# If not, I will think about what to do...
	rm "${D}usr/bin/notepadqq" || die
	mv "${D}usr/bin/notepadqq-bin" "${D}usr/bin/notepadqq" || die
}
