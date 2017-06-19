# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools VM Command Module"
HOMEPAGE="https://pypi.python.org/pypi/azure-cli-vm"
SRC_URI="mirror://pypi/a/azure-cli-vm/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-resource[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-network[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-keyvault[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-compute[${PYTHON_USEDEP}]
	dev-python/azure-storage[${PYTHON_USEDEP}]
	dev-python/azure-keyvault[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	# avoiding file collision with net-misc/azure-cli

	python_export PYTHON_SITEDIR
	rm "${D%/}${PYTHON_SITEDIR}/azure/__init__.py" || die
	rm "${D%/}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
	rm "${D%/}${PYTHON_SITEDIR}/azure/cli/command_modules/__init__.py" || die
}
