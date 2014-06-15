# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

SLOT="0"
LICENSE="HPND"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Console SID file player. Very small and light."

SRC_URI="http://www.rsinsch.de/data/files/ce4f22308f/tinysid-linux.tar.gzip ->
tinysid-linux.tar.gz"
HOMEPAGE="http://www.rsinsch.de/?id=7298b"

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
