# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="A client library to multiplex connections from and to iOS devices"
HOMEPAGE="http://www.libimobiledevice.org"
EGIT_REPO_URI="https://github.com/libimobiledevice/libusbmuxd.git"
EGIT_COMMIT="5cbf7635e34b68125b01dbc71b333525ad3cea40"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kernel_linux static-libs"

# >=app-pda/usbmuxd-20200121
RDEPEND="
	>=app-pda/libplist-20191218
	virtual/libusb
"
DEPEND="${RDEPEND}
	virtual/os-headers
"
BEPEND="
	virtual/pkgconfig
"

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh || die
	eautoreconf
	default
}

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use kernel_linux || myeconfargs+=( --without-inotify )

	econf "${myeconfargs[@]}"
}
