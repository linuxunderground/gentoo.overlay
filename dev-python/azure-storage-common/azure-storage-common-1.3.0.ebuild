# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Azure client library that makes it easy to consume Azure Storage services"
HOMEPAGE="https://pypi.org/project/azure-storage-blob"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	>=dev-python/azure-common-1.1.9[${PYTHON_USEDEP}]
	dev-python/azure-storage-nspkg[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	!!dev-python/azure-storage
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-storage-nspkg
	rm "${ED}${PYTHON_SITEDIR}/azure/storage/__init__.py" || die
}
