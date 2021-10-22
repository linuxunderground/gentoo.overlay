# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Read and write Commodore disk images"
HOMEPAGE="https://eden.mose.org.uk/gitweb/?p=python-d64.git"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="examples"
SLOT="0"

RDEPEND="dev-python/cbmcodecs2[${PYTHON_USEDEP}]
	dev-python/cmd2[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	if use test; then
		for FILE in test/test_bam.py \
			test/test_bam.py \
			test/test_d64_image.py \
			test/test_d71_bam.py \
			test/test_d80_bam.py \
			test/test_d80_d82_bam_block.py \
			test/test_d81_bam.py \
			test/test_d81_bam_block.py \
			test/test_d81_dir_entry.py \
			test/test_d81_image.py \
			test/test_d81_relative_file.py \
			test/test_dir_entry.py \
			test/test_dos_image.py \
			test/test_dos_path.py \
			test/test_file.py \
			test/test_partition.py \
			test/test_relative_file.py \
			test/test_side_sector.py \
			test/test_subdirectory.py \
			test/test_super_side_sector.py ; do
			sed -i \
				-e 's:from test.mock_block import:from mock_block import:' \
				"${FILE}" || die
		done

		sed -i \
			-e 's:from test.mock_bam import:from mock_bam import:' \
			test/test_dos_image.py || die

		eapply "${FILESDIR}/test-fix.patch"
	fi

	eapply_user
}

python_install_all() {
	if use examples; then
		dodoc -r examples
	fi
}
