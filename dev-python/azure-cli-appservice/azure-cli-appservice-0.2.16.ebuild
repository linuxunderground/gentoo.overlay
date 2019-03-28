# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools AppService Command Module"
HOMEPAGE="https://pypi.org/project/azure-cli-appservice"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

# fabric>=2.4 : https://bugs.gentoo.org/show_bug.cgi?id=679268
RDEPEND="virtual/python-cffi[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/vsts-cd-manager[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.18[${PYTHON_USEDEP}]
	dev-python/fabric:2[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-web-0.40.0[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-storage-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-containerregistry-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-applicationinsights-0.1.1[${PYTHON_USEDEP}]
	>=dev-python/azure-functions-devops-build-0.0.11[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]
	!dev-python/azure-cli-command-modules-nspkg"

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
