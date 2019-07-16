# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure CLI hdinsight Command Module"
HOMEPAGE="https://pypi.org/project/azure-cli-hdinsight"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/azure-mgmt-hdinsight-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-storage-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-network-3.0.0[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# __init__.py are provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/__init__.py" || die

	# Avoid portage file collisions
	rm -r "${ED}${PYTHON_SITEDIR}/azure/__pycache__" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/__pycache__" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/__pycache__" || die
}
