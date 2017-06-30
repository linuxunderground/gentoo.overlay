# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools"
HOMEPAGE="https://pypi.python.org/pypi/azure-cli"
SRC_URI="mirror://pypi/a/azure-cli/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

# https://pypi.python.org/pypi/azure
AZUREDEPEND="dev-python/azure-storage[${PYTHON_USEDEP}]
	dev-python/azure-servicemanagement-legacy[${PYTHON_USEDEP}]
	dev-python/azure-servicefabric[${PYTHON_USEDEP}]
	dev-python/azure-servicebus[${PYTHON_USEDEP}]
	dev-python/azure-keyvault[${PYTHON_USEDEP}]
	dev-python/azure-graphrbac[${PYTHON_USEDEP}]
	dev-python/azure-datalake-store[${PYTHON_USEDEP}]
	dev-python/azure-batch[${PYTHON_USEDEP}]"

# https://pypi.python.org/pypi/azure-mgmt
AZUREMGMTDEPEND="dev-python/azure-mgmt-web[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-trafficmanager[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-storage[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-sql[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-scheduler[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-resource[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-redis[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-rdbms[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-network[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-monitor[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-logic[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-keyvault[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-iothub[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-documentdb[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-dns[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-devtestlabs[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-datalake-store[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-datalake-analytics[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-containerregistry[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-compute[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-cognitiveservices[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-cdn[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-batch[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-authorization[${PYTHON_USEDEP}]"

RDEPEND="${AZUREDEPEND}
	${AZUREMGMTDEPEND}
	dev-python/azure-cli-vm[${PYTHON_USEDEP}]
	dev-python/azure-cli-storage[${PYTHON_USEDEP}]
	dev-python/azure-cli-sql[${PYTHON_USEDEP}]
	dev-python/azure-cli-profile[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]
	dev-python/azure-cli-configure[${PYTHON_USEDEP}]
	dev-python/azure-cli-cloud[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare
	rm az.bat || die
	sed -i -e '/az.bat/ d' setup.py || die
}
