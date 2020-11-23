# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools udev user

DESCRIPTION="A socket daemon to multiplex connections from and to iOS devices"
HOMEPAGE="http://www.libimobiledevice.org"
EGIT_REPO_URI="https://github.com/libimobiledevice/usbmuxd.git"
EGIT_COMMIT="8a69f1a78a58476f77b66916091d2405d0cd815f"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RDEPEND="
	>=app-pda/libimobiledevice-20200210
	>=app-pda/libplist-20191218
	virtual/libusb
"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig
"

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure(){
	use systemd && ewarn "systemd functionally was not tested. Please report bugs if any"
	econf $(use_with systemd)
}
