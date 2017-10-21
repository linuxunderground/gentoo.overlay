# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="ADAL Python library"
HOMEPAGE="https://pypi.python.org/pypi/adal"
SRC_URI="mirror://pypi/a/adal/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/cryptography-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.0.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
