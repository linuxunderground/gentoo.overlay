# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="scp module for paramiko"
HOMEPAGE="https://pypi.python.org/pypi/scp"
SRC_URI="mirror://pypi/s/scp/${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~arm"
LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="dev-python/paramiko[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
