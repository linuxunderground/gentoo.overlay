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

RDEPEND="dev-python/azure-cli-vm[${PYTHON_USEDEP}]
	dev-python/azure-cli-storage[${PYTHON_USEDEP}]
	dev-python/azure-cli-sql[${PYTHON_USEDEP}]
	dev-python/azure-cli-role[${PYTHON_USEDEP}]
	dev-python/azure-cli-resource[${PYTHON_USEDEP}]
	dev-python/azure-cli-profile[${PYTHON_USEDEP}]
	dev-python/azure-cli-nspkg[${PYTHON_USEDEP}]
	dev-python/azure-cli-network[${PYTHON_USEDEP}]
	dev-python/azure-cli-keyvault[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]
	dev-python/azure-cli-configure[${PYTHON_USEDEP}]
	dev-python/azure-cli-component[${PYTHON_USEDEP}]
	dev-python/azure-cli-cloud[${PYTHON_USEDEP}]
	dev-python/azure-cli-billing[${PYTHON_USEDEP}]
	dev-python/azure-cli-batch[${PYTHON_USEDEP}]
	dev-python/azure-cli-appservice[${PYTHON_USEDEP}]
	dev-python/azure-cli-acs[${PYTHON_USEDEP}]
	dev-python/azure-cli-acr[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare
	rm az.bat || die
	sed -i -e '/az.bat/ d' setup.py || die
}

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by dev-python/azure-cli-nspkg
	rm "${D%/}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
}
