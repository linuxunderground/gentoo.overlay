# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Read and write Commodore disk images"
HOMEPAGE="https://eden.mose.org.uk/gitweb/?p=python-d64.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples extra"

RDEPEND="dev-python/petscii-codecs[${PYTHON_USEDEP}]
	extra? ( dev-python/cmd2[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	default

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
		for FILE in test/test_dos_image.py \
			test/test_subdirectory.py ; do
			sed -i \
				-e 's:from test.mock_bam import:from mock_bam import:' \
				"${FILE}" || die
		done
	fi

	if use examples; then
		for FILES in examples/*py ; do
			sed -i -e '1i \#!/usr/bin/env python3\n' "${FILES}" || die
		done
	fi
}

python_install_all() {
	if use examples; then
		dodoc -r examples
	fi
}
