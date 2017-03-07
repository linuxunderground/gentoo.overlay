# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic linux-info multilib toolchain-funcs wxwidgets eutils pax-utils

MY_P="GostCrypt_Linux_${PV}"

DESCRIPTION="Free open-source disk encryption software"
HOMEPAGE="http://www.gostcrypt.org"
SRC_URI="http://www.gostcrypt.org/download/${PV}/linux/${MY_P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="X"

RDEPEND=">=sys-fs/lvm2-2.02.45
	sys-fs/fuse
	x11-libs/wxGTK:2.8[X?]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	local CONFIG_CHECK="~BLK_DEV_DM ~DM_CRYPT ~FUSE_FS ~CRYPTO ~CRYPTO_XTS"
	linux-info_pkg_setup

	local WX_GTK_VER="2.8"

	if use X; then
		need-wxwidgets unicode
	else
		need-wxwidgets base-unicode
	fi
}

src_prepare() {
	default
	if has_version x11-libs/wxGTK[X]; then
		# Fix linking when NOGUI=1
		sed -e "s/WX_CONFIG_LIBS := base/&,core/" -i Main/Main.make || die "sed Main/Main.make failed"
	fi
	#ARCH detect :
	# Required for assembling asm files. But, there is no longer
	# asm code in GostCrypt.
	#sed -i -e 's:uname -p:uname -m:' Makefile || die
}

src_compile() {
	local EXTRA

	use X || EXTRA+=" NOGUI=1"

	emake \
		${EXTRA} \
		NOASM=1 \
		NOSTRIP=1 \
		NOTEST=1 \
		VERBOSE=1 \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)" \
		TC_EXTRA_CFLAGS="${CFLAGS}" \
		TC_EXTRA_CXXFLAGS="${CXXFLAGS}" \
		TC_EXTRA_LFLAGS="${LDFLAGS}" \
		WX_CONFIG="${WX_CONFIG}"
}

src_test() {
	"${S}/Main/gostcrypt" --text --test || die "tests failed"
}

src_install() {
	dobin Main/gostcrypt
	dodoc Release/Setup\ Files/GostCryptUserGuide.pdf
	exeinto "/$(get_libdir)/rc/sh"
	newexe "${FILESDIR}/${PN}-stop.sh" "${PN}-stop.sh"

	newinitd "${FILESDIR}/${PN}.init" ${PN}

	if use X; then
		newicon Resources/Icons/GostCrypt-48x48.xpm gostcrypt.xpm
		make_desktop_entry ${PN} "GostCrypt" ${PN} "System"
	fi

	pax-mark -m "${D}/usr/bin/gostcrypt"
}

pkg_postinst() {
	elog "There is now an init script for GostCrypt for Baselayout-2."
	elog "If you are a baselayout-2 user and you would like the GostCrypt"
	elog "mappings removed on shutdown in order to prevent other file systems"
	elog "from unmounting then run:"
	elog "rc-update add gostcrypt boot"
	elog
	elog "If you want to mount encrypted volumes as nonroot users, you need"
	elog "to install app-admin/sudo."
	elog

	ewarn "If you're getting errors about DISPLAY while using the terminal"
	ewarn "it's a known upstream bug. To use GostCrypt from the terminal"
	ewarn "all that's necessary is to run: unset DISPLAY"
	ewarn "This will make the display unaccessable from that terminal "
	ewarn "but at least you will be able to access your volumes."
}
