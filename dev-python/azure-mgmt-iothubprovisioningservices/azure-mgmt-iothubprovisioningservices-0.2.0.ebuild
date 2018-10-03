# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure IoTHub Provisioning Services Client Library for Python"
HOMEPAGE="https://pypi.org/project/azure-mgmt-iothubprovisioningservices"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/msrestazure-0.4.32[${PYTHON_USEDEP}]
	>=dev-python/azure-common-1.1.6[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	# avoiding file collision with net-misc/azure-cli and
	# dev-python/azure-mgmt-resource

	python_export PYTHON_SITEDIR
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	rm "${ED}${PYTHON_SITEDIR}/azure/mgmt/__init__.py" || die
}
