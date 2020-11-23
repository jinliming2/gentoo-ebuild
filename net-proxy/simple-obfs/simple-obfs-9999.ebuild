# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3
MY_PV="v${PV}"

DESCRIPTION="A simple obfuscating tool"
HOMEPAGE="https://github.com/shadowsocks/simple-obfs"
EGIT_REPO_URI="https://github.com/shadowsocks/simple-obfs.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

if [[ ${MY_PV} == *9999 ]]; then
	EGIT_BRANCH="master"
	KEYWORDS="-* ~amd64 ~x86"
else
	EGIT_COMMIT="${MY_PV}"
	KEYWORDS="-* amd64 x86"
fi

DEPEND="
	sys-devel/autoconf
	sys-devel/libtool
	dev-libs/openssl
	dev-libs/libpcre
	dev-libs/libev
	app-text/asciidoc
	app-text/xmlto
	sys-devel/automake
"
RDEPEND="${DEPEND}"

src_compile() {
	./autogen.sh
	econf
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
