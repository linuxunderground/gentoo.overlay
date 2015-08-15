# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

SLOT="0"
LICENSE="HPND"
KEYWORDS="~amd64 ~x86 ~arm"
DESCRIPTION="Console SID file player. Very small and light."

SRC_URI="http://www-stud.rbi.informatik.uni-frankfurt.de/~sinsch/new/tinysid-Dateien/downloads/tinysid-linux.tar.gzip -> tinysid-linux.tar.gz"
HOMEPAGE="http://www-stud.rbi.informatik.uni-frankfurt.de/~sinsch/new/tinysid.htm"
IUSE="alsa"

RDEPEND="alsa? ( media-libs/alsa-oss )"

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	sed -i -e '/^C\?L\?D\?FLAGS/s:^:#:' makefile
}

src_install() {
	dobin tinysid

	ewarn "If you do not use OSS, you have to use an OSS wrapper."
	ewarn "I only tested alsa OSS wrapper."
	if use alsa; then
		ewarn "$ aoss tinysid my_sid_file.sid"
	fi
}
