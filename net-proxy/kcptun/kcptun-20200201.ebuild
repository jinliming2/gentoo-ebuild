# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PV="v${PV}"

DESCRIPTION="A Stable & Secure Tunnel based on KCP with N:M multiplexing and FEC"
HOMEPAGE="https://github.com/xtaci/kcptun"

LICENSE="MIT"
SLOT="0"
IUSE="client server"
REQUIRED_USE="|| ( client server )"

if [[ ${MY_PV} != *9999 ]]; then
	inherit golang-build
	EGO_BUILD_FLAGS='-ldflags "-X main.VERSION=$(date -u +%Y%m%d) -s -w"'
	if use client && use server; then
		EGO_PN="github.com/xtaci/kcptun"
	elif use client; then
		EGO_PN="github.com/xtaci/kcptun/client"
	else
		EGO_PN="github.com/xtaci/kcptun/server"
	fi
	KEYWORDS="-* ~amd64 ~x86 ~mips ~arm"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xtaci/kcptun.git"
	EGIT_BRANCH="master"
	EGIT_COMMIT="${MY_PV}"
	KEYWORDS="-* amd64 x86 mips arm"
fi

src_compile() {
	./autogen.sh
	econf
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
