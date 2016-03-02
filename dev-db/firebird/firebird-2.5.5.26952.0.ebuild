# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils flag-o-matic multilib user versionator

MY_P=${PN/f/F}-$(replace_version_separator 4 -)
#MY_P=${PN/f/F}-${PV/_rc/-ReleaseCandidate}

DESCRIPTION="A relational database offering many ANSI SQL:2003 and some SQL:2008 features"
HOMEPAGE="http://www.firebirdsql.org/"
SRC_URI="
	mirror://sourceforge/firebird/${MY_P}.tar.bz2
	doc? (	ftp://ftpc.inprise.com/pub/interbase/techpubs/ib_b60_doc.zip )"

LICENSE="IDPL Interbase-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug doc client superserver xinetd"
REQUIRED_USE="^^ ( client superserver xinetd )"

CDEPEND="
	dev-libs/libedit
	dev-libs/icu:=
"
DEPEND="${CDEPEND}
	>=dev-util/btyacc-3.0-r2
	doc? ( app-arch/unzip )
"
RDEPEND="${CDEPEND}
	xinetd? ( virtual/inetd )
	!sys-cluster/ganglia
"

RESTRICT="userpriv"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup firebird 450
	enewuser firebird 450 /bin/sh /usr/$(get_libdir)/firebird firebird
}

check_sed() {
	MSG="sed of $3, required $2 lines modified $1"
	einfo "${MSG}"
	[[ $1 -ge $2 ]] || die "${MSG}"
}

src_unpack() {
	unpack "${MY_P}.tar.bz2"
	if use doc; then
		# Unpack docs
		mkdir "manuals" || die
		cd "manuals" || die
		unpack ib_b60_doc.zip
	fi
}

src_prepare() {
	# This patch might be portable, and not need to be duplicated per version
	# also might no longer be necessary to patch deps or libs, just flags
	epatch "${FILESDIR}"/${PN}-2.5.3.26780.0-deps-flags.patch

	use client && epatch "${FILESDIR}"/${PN}-2.5.1.26351.0-client.patch
	use superserver || epatch "${FILESDIR}"/${PN}-2.5.1.26351.0-superclassic.patch

	# Rename references to isql to fbsql
	# sed vs patch for portability and addtional location changes
	check_sed "$(sed -i -e 's:"isql :"fbsql :w /dev/stdout' \
		src/isql/isql.epp | wc -l)" "1" "src/isql/isql.epp" # 1 line
	check_sed "$(sed -i -e 's:isql :fbsql :w /dev/stdout' \
		src/msgs/history2.sql | wc -l)" "4" "src/msgs/history2.sql" # 4 lines
	check_sed "$(sed -i -e 's:--- ISQL:--- FBSQL:w /dev/stdout' \
		-e 's:isql :fbsql :w /dev/stdout' \
		-e 's:ISQL :FBSQL :w /dev/stdout' \
		src/msgs/messages2.sql | wc -l)" "6" "src/msgs/messages2.sql" # 6 lines

	find "${S}" -name \*.sh -exec chmod +x {} + || die
	rm -r "${S}"/extern/{btyacc,editline,icu} || die

	eautoreconf
}

src_configure() {
	filter-flags -fprefetch-loop-arrays -fomit-frame-pointer
	append-flags -fno-omit-frame-pointer
	filter-mfpmath sse

	econf \
		--prefix=/usr/$(get_libdir)/firebird \
		$(use_enable superserver) \
		$(use_enable debug) \
		--with-editline \
		--with-system-editline \
		--with-system-icu \
		--with-fbbin=/usr/bin \
		--with-fbsbin=/usr/sbin \
		--with-fbconf=/etc/${PN} \
		--with-fblib=/usr/$(get_libdir) \
		--with-fbinclude=/usr/include \
		--with-fbdoc=/usr/share/doc/${P} \
		--with-fbudf=/usr/$(get_libdir)/${PN}/UDF \
		--with-fbsample=/usr/share/doc/${P}/examples \
		--with-fbsample-db=/usr/share/doc/${P}/examples/db \
		--with-fbhelp=/usr/$(get_libdir)/${PN}/help \
		--with-fbintl=/usr/$(get_libdir)/${PN}/intl \
		--with-fbmisc=/usr/share/${PN} \
		--with-fbsecure-db=/etc/${PN} \
		--with-fbmsg=/usr/$(get_libdir)/${PN} \
		--with-fblog=/var/log/${PN}/ \
		--with-fbglock=/var/run/${PN} \
		--with-fbplugins=/usr/$(get_libdir)/${PN}/plugins \
		--with-gnu-ld \
		${myconf}
}

src_compile() {
	MAKEOPTS="${MAKEOPTS/-j*/-j1} ${MAKEOPTS/-j/CPU=}"
	emake
}

src_install() {
	cd "gen/${PN}" || die

	if use doc; then
		dodoc "${S}"/doc/*.pdf
		find "${WORKDIR}"/manuals -type f -iname "*.pdf" -exec dodoc '{}' + || die
	fi

	doheader include/*

	rm lib/libfbstatic.a || die "failed to remove libfbstatic.a"

	insinto /usr/$(get_libdir)
	dolib.so lib/*.so*

	# links for backwards compatibility
	dosym libfbclient.so /usr/$(get_libdir)/libgds.so
	dosym libfbclient.so /usr/$(get_libdir)/libgds.so.0
	dosym libfbclient.so /usr/$(get_libdir)/libfbclient.so.1

	insinto /usr/$(get_libdir)/${PN}
	doins *.msg

	use client && return

	einfo "Renaming isql -> fbsql"
	mv bin/isql bin/fbsql || die "failed to rename isql -> fbsql"

	local bins="fbsql fbsvcmgr fbtracemgr gbak gdef gfix gpre gsec gstat nbackup qli"
	for bin in ${bins}; do
		dobin bin/${bin}
	done

	dosbin bin/fb_lock_print
	# SuperServer
	if use superserver ; then
		dosbin bin/{fbguard,fbserver}
	# ClassicServer
	elif use xinetd ; then
		dosbin bin/fb_inet_server
	# SuperClassic
	else
		dosbin bin/{fbguard,fb_smp_server}

		#Temp should not be necessary, need to patch/fix
		dosym /usr/$(get_libdir)/libib_util.so /usr/$(get_libdir)/${PN}/lib/libib_util.so
	fi

	insinto /usr/$(get_libdir)/${PN}/help
	doins help/help.fdb

	exeinto /usr/$(get_libdir)/firebird/intl
	dolib.so intl/libfbintl.so
	dosym /usr/$(get_libdir)/libfbintl.so /usr/$(get_libdir)/${PN}/intl/fbintl
	dosym /etc/firebird/fbintl.conf /usr/$(get_libdir)/${PN}/intl/fbintl.conf

	exeinto /usr/$(get_libdir)/${PN}/plugins
	dolib.so plugins/libfbtrace.so
	dosym /usr/$(get_libdir)/libfbtrace.so /usr/$(get_libdir)/${PN}/plugins/libfbtrace.so

	exeinto /usr/$(get_libdir)/${PN}/UDF
	doexe UDF/*.so

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	insinto /etc/${PN}
	doins ../install/misc/*.conf
	insopts -m0660 -o firebird -g firebird
	doins security2.fdb
	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/${PN}.xinetd" ${PN}
	else
		newinitd "${FILESDIR}/${PN}.init.d" ${PN}
	fi
}

pkg_config() {
	use client && return

	einfo "If you're using UDFs, please remember to move them"
	einfo "to /usr/lib/firebird/UDF"
}
