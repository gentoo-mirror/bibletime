# Copyright 1999-2013 Gentoo Foundation
# Copyright 2014 The BibleTime team
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils

DESCRIPTION="Library for Bible reading software."
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/${PN}/source/v${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="clucene curl examples icu internal-zlib static-libs test utils zlib"
REQUIRED_USE="^^ ( internal-zlib zlib )"

CMAKE_MIN_VERSION=2.6.0
RDEPEND="
  clucene? ( dev-cpp/clucene )
  curl? ( net-misc/curl )
  icu? ( dev-libs/icu )
  zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND} virtual/pkgconfig"

DOCS="AUTHORS ChangeLog CODINGSTYLE LICENSE NEWS README"

pkg_setup() {
  einfo "Please file bugs for this ebuild to http://bugs.bibletime.info/"
}

src_prepare() {
  sed -i -e '/CMAKE_C_FLAGS/d' -e '/CMAKE_CXXFLAGS/d' CMakeLists.txt || die

  cat <<-EOF > "${T}"/${PN}.conf
[Install]
DataPath=${EPREFIX}/usr/share/${PN}/
EOF
}

src_configure() {
  local mycmakeargs=()
  use static-libs || mycmakeargs+=( -DLIBSWORD_LIBRARY_TYPE=Shared )
  use clucene || mycmakeargs+=( -DSWORD_NO_CLUCENE=Yes )
  use curl || mycmakeargs+=( -DSWORD_NO_CURL=Yes )
  use examples && mycmakeargs+=( -DSWORD_BUILD_EXAMPLES=Yes )
  use icu || mycmakeargs+=( -DSWORD_NO_ICU=No ) # Bug with <=sword-1.7.2
  use internal-zlib && mycmakeargs+=( -DSWORD_USE_INTERNAL_ZLIB=No )
  use test && mycmakeargs+=( -DSWORD_BUILD_TESTS=Yes )
  use utils || mycmakeargs+=( -DSWORD_BUILD_UTILS=No )
  use zlib || use internal-zlib || mycmakeargs+=( -DSWORD_NO_ZLIB=Yes )
  cmake-utils_src_configure
}

src_install() {
  cmake-utils_src_install

#  find "${ED}" -name '*.la' -exec rm -f {} +

  if use examples; then
    rm -rf examples/.cvsignore
    rm -rf examples/cmdline/.cvsignore
    rm -rf examples/cmdline/.deps
    cp -R samples examples "${ED}"/usr/share/doc/${PF}/
  fi

  insinto /etc
  doins "${T}"/${PN}.conf
}

pkg_postinst() {
  elog "Check out http://www.crosswire.org/sword/modules/"
  elog "to download modules that you would like to use with SWORD."
  elog "Follow module installation instructions found on"
  elog "the web or in ${EROOT}/usr/share/doc/${PF}/"
}
