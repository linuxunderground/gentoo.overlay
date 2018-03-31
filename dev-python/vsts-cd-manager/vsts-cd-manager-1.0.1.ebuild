# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Python wrapper around some of the VSTS APIs"
HOMEPAGE="https://pypi.python.org/pypi/vsts-cd-manager"
SRC_URI="mirror://pypi/v/vsts-cd-manager/${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~arm"
LICENSE="MIT"
SLOT="0"

RDEPEND=""

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
