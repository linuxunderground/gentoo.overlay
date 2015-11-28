# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

# Try to remove any dm-crypt mappings
if [ -x /usr/bin/gostcrypt ]; then
	ebegin "Removing GostCrypt mappings"
	! /usr/bin/gostcrypt -l > /dev/null 2>&1  || /usr/bin/gostcrypt -d
	eend $?
fi
