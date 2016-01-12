class Cardpeek < Formula
  homepage "http://pannetrat.com/Cardpeek/"
  url "http://downloads.pannetrat.com/install/cardpeek-0.8.4.tar.gz"
  mirror "https://github.com/DomT4/LibreMirror/raw/d1dff2e5714953308864a606618a85cbde2375a2/Cardpeek/cardpeek-0.8.4.tar.gz"
  sha256 "9c78dfdf84493c551b49447e4bb46c8d7b33f0785b93893222b70b6115013a85"

  bottle do
    cellar :any
    sha256 "e74308982f81ae050d341c8fd93473124570289d9ba7f0d4392b0b22eeddad94" => :yosemite
    sha256 "2901819124ad9f0d2ed67bf6eace436f02d3c6b590790aac3cbfe78db94602f4" => :mavericks
    sha256 "6c97f5322f10e240c7b27efdc7d13e289c6f147e3a4a88db301cc32eec94ebce" => :mountain_lion
  end

  head "https://cardpeek.googlecode.com/svn/trunk/"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "lua"
  depends_on "openssl"

  def install
    # always run autoreconf, needed to generate configure for --HEAD,
    # and otherwise needed to reflect changes to configure.ac
    system "autoreconf", "-i"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"cardpeek", "-v"
  end
end
