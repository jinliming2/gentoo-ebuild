# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit golang-build golang-vcs

DESCRIPTION="The terminal utility for Baidu Network Disk (Golang Version)."
HOMEPAGE="https://github.com/iikira/BaiduPCS-Go"
MY_PN="BaiduPCS-Go"
EGO_PN="github.com/iikira/${MY_PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!net-misc/baidupcs-go-bin
"
BDEPEND=""

src_install() {
	newbin ${MY_PN} ${PN}
	dodoc src/${EGO_PN}/README*
}
