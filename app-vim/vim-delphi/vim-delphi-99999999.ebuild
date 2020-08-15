# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 vim-plugin

DESCRIPTION="vim plugin: Gentoo and Portage syntax highlighting"
HOMEPAGE="https://github.com/mattia72/vim-delphi"
EGIT_REPO_URI="https://github.com/mattia72/vim-delphi.git"

LICENSE="vim"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=( README.md )

VIM_PLUGIN_HELPFILES="delphi"
VIM_PLUGIN_MESSAGES="filetype"

src_prepare() {
	default
	mv ftplugin/match_words.vim ftplugin/matchwords.vim || die
	cp "${FILESDIR}/Makefile" . || die
}
