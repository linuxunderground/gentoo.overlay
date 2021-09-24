# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure management core library for Python"
HOMEPAGE="https://pypi.org/project/azure-mgmt-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/azure-core-1.18.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/httpretty )"

RESTRICT="test"
# test failed with Python 3.10 because httpretty is not ready for Python 3.10

distutils_enable_tests pytest
