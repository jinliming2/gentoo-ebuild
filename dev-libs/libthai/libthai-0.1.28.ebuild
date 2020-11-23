# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="LibThai is a set of Thai language support routines"
HOMEPAGE="https://linux.thai.net/projects/libthai"
SRC_URI="https://linux.thai.net/pub/thailinux/software/libthai/libthai-${PV}.tar.xz"

LICENSE="GNU LESSER GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doxygen"

RDEPEND=""
DEPEND="${RDPEND}
	doxygen? ( app-doc/doxygen )
	>=dev-libs/libdatrie-0.2.12"
