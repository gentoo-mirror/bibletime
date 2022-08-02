# Copyright 1999-2018 Gentoo Authors
# Copyright 2010-2021 The BibleTime team
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Qt5 Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="handbook handbook-pdf howto howto-pdf"

RDEPEND="
	>=app-text/sword-1.8.1[curl]
	>=dev-cpp/clucene-0.9.16a
	>=dev-qt/qtcore-5.6.0:5
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtwebchannel:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5"
DEPEND="${RDEPEND}
	dev-qt/qttest:5"
HTML_DOC_DEPENDS="app-text/docbook-xsl-stylesheets app-text/po4a dev-libs/libxslt"
PDF_DOC_DEPENDS="${HTML_DOC_DEPENDS} dev-java/fop"
BDEPEND="
	dev-qt/linguist-tools:5
	handbook? ( ${HTML_DOC_DEPENDS} )
	handbook-pdf? ( ${PDF_DOC_DEPENDS} )
	howto? ( ${HTML_DOC_DEPENDS} )
	howto-pdf? ( ${PDF_DOC_DEPENDS} )"

DOCS="ChangeLog README.md"

pkg_setup() {
	einfo "Please file bugs for this ebuild to https://github.com/bibletime/bibletime/issues"
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_HANDBOOK_HTML=$(usex handbook)
		-DBUILD_HANDBOOK_PDF=$(usex handbook-pdf)
		-DBUILD_HOWTO_HTML=$(usex howto)
		-DBUILD_HOWTO_PDF=$(usex howto-pdf)
	)
	cmake_src_configure
}
