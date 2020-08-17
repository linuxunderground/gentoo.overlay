# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="Firebird program user"
ACCT_USER_ID=450
ACCT_USER_GROUPS=( firebird )
acct-user_add_deps
