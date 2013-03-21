# Copyright 1999-2009 Gentoo Foundation
# Copyright 2010-2013 The BibleTime team
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="Qt4 Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="debug"

RDEPEND=">=app-text/sword-1.6.0
	>=dev-cpp/clucene-0.9.16a
	<dev-cpp/clucene-1.0
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-qt/qttest:4"

DOCS="ChangeLog README"

src_configure() {
	mycmakeargs="${mycmakeargs} -DUSE_QT_WEBKIT=ON"
	cmake-utils_src_configure
}
