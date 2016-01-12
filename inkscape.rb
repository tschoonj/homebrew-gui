class Inkscape < Formula
  desc "A professional vector graphics editor"
  homepage "https://inkscape.org/"
  url "https://inkscape.org/en/gallery/item/3854/inkscape-0.91.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/i/inkscape/inkscape_0.91.orig.tar.gz"
  sha256 "2ca3cfbc8db53e4a4f20650bf50c7ce692a88dcbf41ebc0c92cd24e46500db20"
  revision 3

  bottle do
    sha256 "3f1bfd7da97196137bf821c5fc54b469fecfe1566271b7052c180d3a21e683f9" => :el_capitan
    sha256 "e33308369ed08c0100a3ec9a76db120bbde324d3ab5b9f0309f2da7c0bde56c1" => :yosemite
    sha256 "efa88b262412e0663b30709c430dbefb44b6f9930d849a00971d14d45647e2a9" => :mavericks
  end

  head do
    url "lp:inkscape", :using => :bzr
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "boost-build" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "poppler" => :optional
  depends_on "bdw-gc"
  depends_on "boost"
  depends_on "cairomm"
  depends_on "gettext"
  depends_on "glibmm"
  depends_on "gsl"
  depends_on "gtkmm"
  depends_on "hicolor-icon-theme"
  depends_on "little-cms"
  depends_on "pango"
  depends_on "popt"

  needs :cxx11

  if MacOS.version < :mavericks
    fails_with :clang do
      cause "inkscape's dependencies will be built with libstdc++ and fail to link."
    end
  end

  def install
    ENV.cxx11
    ENV.append "LDFLAGS", "-liconv"

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-strict-build
      --enable-lcms
      --without-gnome-vfs
    ]
    args << "--disable-poppler-cairo" if build.without? "poppler"

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/inkscape", "-x"
  end
end
