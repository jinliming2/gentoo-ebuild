# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1 git-r3

DESCRIPTION="mitmproxy is a free and open source interactive HTTPS proxy"
HOMEPAGE="https://mitmproxy.org/"

EGIT_REPO_URI="https://github.com/mitmproxy/mitmproxy.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-python/blinker-1.4
	:q
"
RDEPEND="${DEPEND}"
BDEPEND=""
