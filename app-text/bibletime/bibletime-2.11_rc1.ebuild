# Copyright 1999-2009 Gentoo Foundation
# Copyright 2010-2013 The BibleTime team
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="Qt5 Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND="
  >=app-text/sword-1.7[curl]
  >=dev-cpp/clucene-0.9.16a
  dev-qt/linguist-tools:5
  || ( ( <dev-qt/qtcore-5.6.0:5
         dev-qt/qtwebkit:5 )
       ( >=dev-qt/qtcore-5.6.0:5
         dev-qt/qtwebengine:5[widgets]
         dev-qt/qtwebchannel:5 )
     )
  dev-qt/qtgui:5
  dev-qt/qtnetwork:5
  dev-qt/qtprintsupport:5
  dev-qt/qtscript:5
  dev-qt/qtsvg:5
  dev-qt/qtwidgets:5
  dev-qt/qtxml:5"
DEPEND="${RDEPEND}
  dev-qt/qttest:5"

DOCS="ChangeLog README.md"

pkg_setup() {
  einfo "Please file bugs for this ebuild to https://github.com/bibletime/bibletime/issues"
}

src_configure() {
    local mycmakeargs=(
    )
    if use debug; then
        mycmakeargs+=(
            -DCMAKE_BUILD_TYPE=Debug
        )
    else
        mycmakeargs+=(
            -DCMAKE_BUILD_TYPE=Release
        )
    fi
    cmake-utils_src_configure
}
