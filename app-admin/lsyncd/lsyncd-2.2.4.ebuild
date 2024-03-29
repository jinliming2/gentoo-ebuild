# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD="YES_PLEASE_OMG"
LUA_COMPAT=( lua5-4 )
#LUA_REQ_USE="deprecated"

inherit cmake lua-single

DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="https://github.com/lsyncd/lsyncd"
SRC_URI="https://github.com/lsyncd/lsyncd/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"

REQUIRED_USE="${LUA_REQUIRED_USE}"

CDEPEND="${LUA_DEPS}"
DEPEND="${CDEPEND}
	app-text/asciidoc
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	net-misc/rsync"
# Both lua and luac are invoked at build time
BDEPEND="${CDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-2.2.4-cmake_lua_version.patch
	"${FILESDIR}"/${PN}-2.2.4-cmake_test.patch
)

S=${WORKDIR}/${PN}-release-${PV}

src_configure() {
	local mycmakeargs=(
		-DLUA_ABI_VERSION=$(ver_cut 1-2 $(lua_get_version))
	)
	cmake_src_configure
}
