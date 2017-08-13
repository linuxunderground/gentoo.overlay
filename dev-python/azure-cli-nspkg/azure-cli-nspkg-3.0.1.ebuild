# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure CLI Namespace Package"
HOMEPAGE="https://pypi.python.org/pypi/azure-cli-nspkg"
SRC_URI="mirror://pypi/a/azure-cli-nspkg/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

# https://pypi.python.org/pypi/azure
AZUREDEPEND="dev-python/azure-servicemanagement-legacy[${PYTHON_USEDEP}]
	dev-python/azure-servicefabric[${PYTHON_USEDEP}]
	dev-python/azure-servicebus[${PYTHON_USEDEP}]
	dev-python/azure-keyvault[${PYTHON_USEDEP}]
	dev-python/azure-graphrbac[${PYTHON_USEDEP}]
	dev-python/azure-datalake-store[${PYTHON_USEDEP}]
	dev-python/azure-batch[${PYTHON_USEDEP}]"

# https://pypi.python.org/pypi/azure-mgmt
AZUREMGMTDEPEND="dev-python/azure-mgmt-web[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-sql[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-scheduler[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-redis[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-rdbms[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-monitor[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-logic[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-keyvault[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-iothub[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-documentdb[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-devtestlabs[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-datalake-store[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-datalake-analytics[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-containerregistry[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-compute[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-cognitiveservices[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-cdn[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-billing[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-batch[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-authorization[${PYTHON_USEDEP}]"

RDEPEND="${AZUREDEPEND}
	${AZUREMGMTDEPEND}"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
