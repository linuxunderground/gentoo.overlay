# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Texas Instruments Home Computer Emulator"
HOMEPAGE="https://www.mrousseau.org/programs/ti99sim/"
SRC_URI="https://www.mrousseau.org/programs/ti99sim/archives/${P}.src.tar.xz
	roms? (
	https://ftp.whtech.com/System%20ROMs/MAME/pre_0.174/ti99_complete.zip
	https://ftp.whtech.com/System%20ROMs/MAME/ti99_gkracker.zip
	https://ftp.whtech.com/emulators/mess/mess_modules.zip
	)"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc +roms"

BDEPEND="app-arch/unzip"

RDEPEND="media-libs/libsdl2[sound,video]"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack "${P}.src.tar.xz"
	if use roms; then
		# See scripts/setup file in tarball archive
		unpack ti99_complete.zip
		mkdir {console,roms} || die
		cd console || die
		mv "${S}/roms/cf7a+.bin" . || die
		unpack ../ti99_4a.zip
		unpack ../ti99_4qi.zip
		unpack ../ti99_fdc.zip
		unpack ../ti99_pcode.zip
		unpack ../ti99_speech.zip
		unpack ti99_gkracker.zip
		cd ../roms || die
		unpack mess_modules.zip
		mv minimem*.bin ../console/ || die
	fi
}

src_prepare() {
	eapply "${FILESDIR}/rules_CFLAGS-16.0.patch"
	eapply "${FILESDIR}/fix-declaration.patch"

	# Gentoo QA :
	# https://bugs.gentoo.org/show_bug.cgi?id=331933
	# https://wiki.gentoo.org/wiki/Project:Quality_Assurance/As-needed
	sed -i \
		-e 's:$(LFLAGS):$(LFLAGS) $(LDFLAGS):' \
		src/console/Makefile || die
	sed -i \
		-e 's:$(LFLAGS):$(LFLAGS) $(LDFLAGS):' \
		src/util/Makefile || die
	sed -i \
		-e 's:$(LFLAGS):$(LFLAGS) $(LDFLAGS):' \
		src/sdl/Makefile || die

	eapply_user
}

src_configure() {
	export BIN_DIR=/usr/bin
	export DATA_DIR=/usr/share/ti99sim
}

src_install() {
	export SYS_BIN=${ED}/usr/bin
	export BIN_DIR=${ED}/usr/bin
	export DATA_DIR=${ED}/usr/share/ti99sim

	if use doc; then
		insinto "/usr/share/doc/${PF}"
		doins -r doc
	fi

	if use roms; then
		cd "${WORKDIR}/console" || die
		"${S}"/bin/convert-ctg -v "${S}/roms/cf7+.dat" || die
		"${S}"/bin/convert-ctg -v "${S}/roms/gram-kracker.dat" || die
		"${S}"/bin/convert-ctg -v "${S}/roms/ti-994a.dat" || die
		"${S}"/bin/convert-ctg -v "${S}/roms/ti-994a-qi.dat" || die
		"${S}"/bin/convert-ctg -v "${S}/roms/ti-disk.dat" || die
		"${S}"/bin/convert-ctg -v "${S}/roms/ti-pcard.dat" || die
		"${S}"/bin/convert-ctg -v "${S}/roms/mini-memory.dat" || die
		insinto /usr/share/ti99sim/console/
		doins *.ctg
		doins spchrom.bin

		cd ../roms || die
		"${S}"/bin/mkcart -v . || die
		insinto /usr/share/ti99sim/cartridges/
		doins *.ctg

		cd "${S}" || die
	else
		ewarn "In order to run the emulator, you need to create a cartridge"
		ewarn "that contains the console ROM & GROMs from the TI-99/4A."
		ewarn "See https://www.mrousseau.org/programs/ti99sim/README.html."
	fi
	emake DESTDIR="${ED}" install || die "emake install failed"
}
