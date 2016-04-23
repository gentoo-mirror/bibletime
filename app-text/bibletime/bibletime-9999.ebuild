# Copyright 1999-2009 Gentoo Foundation
# Copyright 2010-2013 The BibleTime team
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils git-r3

DESCRIPTION="Qt4 Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
EGIT_REPO_URI="https://github.com/bibletime/bibletime.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="
  >=app-text/sword-1.7[curl]
  >=dev-cpp/clucene-0.9.16a
  dev-qt/linguist-tools:5
  dev-qt/qtcore:5
  dev-qt/qtgui:5
  dev-qt/qtnetwork:5
  dev-qt/qtprintsupport:5
  dev-qt/qtscript:5
  dev-qt/qtsvg:5
  dev-qt/qtwebkit:5
  dev-qt/qtwidgets:5
  dev-qt/qtxml:5"
DEPEND="${RDEPEND}
  dev-qt/qttest:5"

DOCS="ChangeLog README.md"

pkg_setup() {
  einfo "Please file bugs for this ebuild to https://github.com/bibletime/bibletime/issues"
}

src_configure() {
  cmake-utils_src_configure
}
