# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs

DESCRIPTION="Simple screen locker"
HOMEPAGE="https://i3wm.org/i3lock/"
SRC_URI="https://i3wm.org/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

RDEPEND="
	>=x11-libs/libxkbcommon-0.5.0[X]
	dev-libs/libev
	sys-libs/pam
	x11-libs/cairo[X,xcb(+)]
	x11-libs/libxcb[xkb]
	x11-libs/xcb-util
	x11-libs/xcb-util-xrm
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"
DOCS=( CHANGELOG README.md )
PATCHES=(
	"${FILESDIR}"/${PN}-2.13-r0-clock.patch
)

src_prepare() {
	default

	sed -i -e 's:login:system-auth:g' pam/${PN} || die
}

src_configure() {
	tc-export CC
	default
}

src_install() {
	default
	doman ${PN}.1
}