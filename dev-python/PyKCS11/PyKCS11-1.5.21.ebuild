# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="A complete PKCS#11 wrapper for Python"
HOMEPAGE="https://github.com/LudovicRousseau/PyKCS11"
SRC_URI="https://codeload.github.com/LudovicRousseau/${PN}/tar.gz/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="examples"

BDEPEND="dev-lang/swig
		test? (
			dev-python/iniconfig[${PYTHON_USEDEP}]
			dev-python/asn1crypto[${PYTHON_USEDEP}]
			dev-libs/softhsm
		)"

DOCS=( README.md )

distutils_enable_tests pytest

src_prepare() {
	default
	if use test; then
		# See /etc/softhsm2.conf
cat <<_EOF_ > softhsm2.conf
directories.tokendir = ${S}/tokens/
objectstore.backend = file
objectstore.umask = 0077
log.level = ERROR
slots.removable = false
slots.mechanisms = ALL
library.reset_on_fork = false
_EOF_

		export SOFTHSM2_CONF="${S}/softhsm2.conf"
		mkdir tokens || die

		# see https://github.com/LudovicRousseau/PyKCS11/blob/master/test/reset_softHSM.sh
		softhsm2-util --init-token --label "A token" --pin 1234 --so-pin 123456 --slot 0 || die
		softhsm2-util --show-slots || die

		# See https://github.com/LudovicRousseau/PyKCS11/blob/master/run_pytest.py
		# and https://github.com/LudovicRousseau/PyKCS11/blob/master/get_PYKCS11LIB.py
cat <<_EOF_ > conftest.py
import os
os.environ["PYKCS11LIB"] = "/usr/$(get_libdir)/softhsm/libsofthsm2.so"
_EOF_

	fi
}

python_install_all() {
	if use examples; then
		insinto "/usr/share/doc/${PF}/"
		doins -r samples
	fi

	distutils-r1_python_install_all
}
