# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Cosmos DB Management Client Library for Python"
HOMEPAGE="https://pypi.org/project/azure-mgmt-cosmosdb"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/msrestazure-0.5.5[${PYTHON_USEDEP}]
	>=dev-python/azure-common-1.1.21[${PYTHON_USEDEP}]
	!dev-python/azure-mgmt-documentdb"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
