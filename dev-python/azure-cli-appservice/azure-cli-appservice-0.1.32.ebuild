# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools AppService Command Module"
HOMEPAGE="https://pypi.org/project/azure-cli-appservice"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~arm"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/vsts-cd-manager[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.18[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-web-0.35.0[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-containerregistry-2.0.0[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]
	>=dev-python/azure-cli-command-modules-nspkg-2.0.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-nspkg
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-command-modules-nspkg
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/__init__.py" || die
}
