# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="vim plugin: Gentoo and Portage syntax highlighting"
HOMEPAGE="https://github.com/mattia72/vim-delphi"
SRC_URI="https://www.linuxunderground.be/download/${P}.zip"

LICENSE="vim"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DOCS=( README.md )

VIM_PLUGIN_HELPFILES="delphi"
VIM_PLUGIN_MESSAGES="filetype"

S="${WORKDIR}/vim-delphi-master"

src_prepare() {
	default
	mv ftplugin/match_words.vim ftplugin/matchwords.vim || die
	cp "${FILESDIR}/Makefile" . || die
}
