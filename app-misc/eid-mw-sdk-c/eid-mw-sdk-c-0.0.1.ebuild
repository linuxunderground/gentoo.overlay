# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/linuxunderground/${PN}.git
		https://github.com/linuxunderground/${PN}.git"
	inherit git-2 autotools
	SRC_URI=""
else
	SRC_URI="http://www.linuxunderground.be/download/${P}.tar.xz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

SLOT="0"
LICENSE="LGPL-3"
DESCRIPTION="Simple GNU package which aims to show how to use the autotools with Fedict C examples"

HOMEPAGE="https://github.com/linuxunderground/eid-mw-sdk-c"

IUSE=""

RDEPEND=">=app-crypt/eid-mw-4.1.4"

DEPEND="${RDEPEND}"

src_prepare() {
	if [[ ${PV} == "9999" ]]; then
		eautoreconf
	fi
}
