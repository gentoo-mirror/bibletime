# Copyright 1999-2018 Gentoo Authors
# Copyright 2010-2025 The BibleTime team
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake git-r3

DESCRIPTION="Qt Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
EGIT_REPO_URI="https://github.com/bibletime/bibletime.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="handbook handbook-pdf howto howto-pdf"

RDEPEND="
	>=app-text/sword-1.8.1[curl,icu]
	>=dev-cpp/clucene-0.9.16a
	dev-qt/qtbase[gui,network,widgets,xml]
	dev-qt/qtdeclarative:6[widgets]
	dev-qt/qtsvg:6"
DEPEND="${RDEPEND}"
HTML_DOC_DEPENDS="app-text/docbook-xsl-stylesheets app-text/po4a dev-libs/libxslt"
PDF_DOC_DEPENDS="${HTML_DOC_DEPENDS} dev-java/fop"
BDEPEND="
	dev-qt/qttools[linguist]
	handbook? ( ${HTML_DOC_DEPENDS} )
	handbook-pdf? ( ${PDF_DOC_DEPENDS} )
	howto? ( ${HTML_DOC_DEPENDS} )
	howto-pdf? ( ${PDF_DOC_DEPENDS} )"

DOCS="README.md"

pkg_setup() {
	einfo "Please file bugs for this ebuild to https://github.com/bibletime/bibletime/issues"
}

src_configure() {
	local mycmakeargs=(
		-DUSE_QT6=ON
		-DBUILD_HANDBOOK_HTML=$(usex handbook)
		-DBUILD_HANDBOOK_PDF=$(usex handbook-pdf)
		-DBUILD_HOWTO_HTML=$(usex howto)
		-DBUILD_HOWTO_PDF=$(usex howto-pdf)
	)
	cmake_src_configure
}
