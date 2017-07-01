# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure CLI Command Modules Namespace Package"
HOMEPAGE="https://pypi.python.org/pypi/azure-cli-command-modules-nspkg"
SRC_URI="mirror://pypi/a/azure-cli-command-modules-nspkg/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/azure-cli-nspkg[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
