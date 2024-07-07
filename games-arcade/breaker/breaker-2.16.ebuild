# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Arkanoid clone written with the SDL library"
HOMEPAGE="https://oldschoolprg.x10.mx"
SRC_URI="https://downloads.sourceforge.net/breaker10/breaker${PV//.}.tar.gz"
S=${WORKDIR}/breaker3264

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	eapply "${FILESDIR}/${PV}/0001-install.patch"
	eapply "${FILESDIR}/${PV}/0002-dot_breaker_dir.patch"
	export PREFIX="/usr"
	export BINDIR="/usr/bin"
	export DATADIR="/usr/share/breaker"
}

src_install() {
	export PREFIX="${ED}/usr"
	export BINDIR="${ED}$/usr/bin"
	export DATADIR="${ED}/usr/share/breaker"

	emake DESTDIR="${ED}" install || die "emake install failed"

	newdoc _README.txt README.TXT
	if has ${LINGUAS} fr fr_FR; then
		newdoc _LISEZMOI.txt LISEZMOI.TXT
	fi
}
