# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Policy Insights client library"
HOMEPAGE="https://pypi.org/project/azure-mgmt-policyinsights"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/msrestazure-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/azure-common-1.1.18[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
