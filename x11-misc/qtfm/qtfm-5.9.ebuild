# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit fdo-mime qmake-utils

DESCRIPTION="A small, lightweight file manager for desktops based on pure Qt"
HOMEPAGE="https://www.linux-apps.com"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1466643163/158787-qtfm.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

LANGS="da de es fr it pl ru sr sv zh zh_TW"
for l in ${LANGS}; do
	IUSE="${IUSE} linguas_${l}"
done

# file is for LIBS += -lmagic
RDEPEND="sys-apps/file
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i \
		-e "/^docs.path/s:qtfm:${PF}:" \
		-e '/^docs.files/s: COPYING::' \
		-e '/^trans.path/s:$:/translations:'\
		${PN}.pro || die
	sed -i \
		-e '/MimeType=/s|$|;|' \
		-e '/Categories=/s|$|;System;FileTools;|' \
		${PN}.desktop || die
	sed -i \
		-e 's:/usr/share/qtfm/qtfm_:/usr/share/qtfm/translations/qtfm_:' \
		src/main.cpp || die

	# Drop langs only if LINGUAS is not empty
	if [[ -n ${LINGUAS} ]]; then
		for l in ${LANGS}; do
			use linguas_${l} && \
				( $(qt5_get_bindir)/lrelease translations/qtfm_${l}.ts || die )
		done
	fi

	eapply_user
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() { fdo-mime_desktop_database_update; }
pkg_postrm() { fdo-mime_desktop_database_update; }
