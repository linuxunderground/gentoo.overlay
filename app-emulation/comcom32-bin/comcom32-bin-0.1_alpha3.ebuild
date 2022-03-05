# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"

DESCRIPTION="32 bit command.com"
HOMEPAGE="https://github.com/dosemu2/comcom32"
SRC_URI="
amd64? ( https://ppa.launchpadcontent.net/dosemu2/ppa/ubuntu/pool/main/c/comcom32/comcom32_0.1~alpha3-163-a33cf51+202201061039~ubuntu22.04.1_amd64.deb )
x86? ( https://ppa.launchpadcontent.net/dosemu2/ppa/ubuntu/pool/main/c/comcom32/comcom32_0.1~alpha3-163-a33cf51+202201011632~ubuntu18.04.1_i386.deb )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.xz
}

src_prepare() {
	# To recompress it with gentoo tools
	gunzip usr/share/doc/${MY_PN}/changelog.Debian.gz || die

	default
}

src_install() {
	dodoc usr/share/doc/${MY_PN}/*
	cd usr/share/${MY_PN} || die
	insinto /usr/share/${MY_PN}
	doins comcom32.exe
	dosym comcom32.exe /usr/share/${MY_PN}/command.com
}
