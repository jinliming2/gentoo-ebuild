# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )
inherit python-r1 git-r3

DESCRIPTION="A compositor for X, and a fork of xcompmgr-dana"
HOMEPAGE="https://github.com/chjj/compton"
EGIT_REPO_URI="https://github.com/chjj/compton.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus +drm +libconfig opengl +pcre xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXrandr
	xinerama? ( x11-libs/libXinerama )
	pcre? ( dev-libs/libpcre:3 )
	libconfig? ( dev-libs/libconfig:= )
	opengl? ( virtual/opengl )
	dbus? ( sys-apps/dbus )"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xprop
	x11-apps/xwininfo"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
	drm? ( x11-libs/libdrm )
	app-text/asciidoc"

nobuildit() { use $1 || echo yes ; }

pkg_setup() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		tc-export CC
	fi
}

src_compile() {
	emake docs

	NO_DBUS=$(nobuildit dbus) \
	NO_XINERAMA=$(nobuildit xinerama) \
	NO_VSYNC_DRM=$(nobuildit drm) \
	NO_LIBCONFIG=$(nobuildit libconfig) \
	NO_VSYNC_OPENGL=$(nobuildit opengl) \
	NO_REGEX_PCRE=$(nobuildit pcre) \
		emake compton
}

src_install() {
	NO_DBUS=$(nobuildit dbus) \
	NO_XINERAMA=$(nobuildit xinerama) \
	NO_VSYNC_DRM=$(nobuildit drm) \
	NO_LIBCONFIG=$(nobuildit libconfig) \
	NO_VSYNC_OPENGL=$(nobuildit opengl) \
	NO_REGEX_PCRE=$(nobuildit pcre) \
		default
	docinto examples
	dodoc compton.sample.conf dbus-examples/*
	python_foreach_impl python_newscript bin/compton-convgen.py compton-convgen
}
