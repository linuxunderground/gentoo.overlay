# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="AutoRest swagger generator Python client runtime. Azure-specific module"
HOMEPAGE="https://pypi.python.org/pypi/msrestazure"
SRC_URI="mirror://pypi/m/msrestazure/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/adal-0.4.5[${PYTHON_USEDEP}]
	>=dev-python/keyring-5.6[${PYTHON_USEDEP}]
	>=dev-python/msrest-0.4.10[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
