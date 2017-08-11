# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools Core Module"
HOMEPAGE="https://pypi.python.org/pypi/azure-cli-core"
SRC_URI="mirror://pypi/a/azure-cli-core/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

IUSE="vanilla"

# https://github.com/Azure/azure-cli/blob/master/requirements.txt
RDEPEND=">=dev-python/vcrpy-1.10.3[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-16.2[${PYTHON_USEDEP}]
	>=dev-python/pylint-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.1.3[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.0.2[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	>=dev-python/humanfriendly-2.4[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.7[${PYTHON_USEDEP}]
	>=dev-python/argcomplete-1.8.0[${PYTHON_USEDEP}]
	dev-python/applicationinsights[${PYTHON_USEDEP}]
	dev-python/adal[${PYTHON_USEDEP}]
	vanilla? ( >=dev-python/pip-9.0.1[${PYTHON_USEDEP}] )
	!vanilla? ( app-portage/gentoolkit[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	eapply_user
	use vanilla || eapply "${FILESDIR}"/gentoolkit.patch
}

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by net-misc/azure-cli
	rm "${D%/}${PYTHON_SITEDIR}/azure/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-nspkg
	rm "${D%/}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
}
