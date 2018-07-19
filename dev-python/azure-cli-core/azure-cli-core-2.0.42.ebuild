# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools Core Module"
HOMEPAGE="https://pypi.org/project/azure-cli-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

IUSE=""

# dev-python/tabulate is a knack dependency
# dev-python/six is a knack dependency
# dev-python/pyyaml is a knack dependency
# dev-python/pygments is a knack dependency
# dev-python/msrest is a msrestazure dependency
# dev-python/jmespath is a knack dependency
# dev-python/colorama is a knack dependency
# dev-python/argcomplete is a knack dependency

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.1[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	>=dev-python/msrestazure-0.4.25[${PYTHON_USEDEP}]
	>=dev-python/knack-0.4.1[${PYTHON_USEDEP}]
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	dev-python/azure-cli-nspkg[${PYTHON_USEDEP}]
	>=dev-python/applicationinsights-0.11.1[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-nspkg
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
}
