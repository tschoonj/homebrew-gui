class Cardpeek < Formula
  desc "Linux/Windows/OSX tool to read the contents of ISO7816 smart cards"
  homepage "http://pannetrat.com/Cardpeek/"
  url "http://downloads.pannetrat.com/install/cardpeek-0.8.4.tar.gz"
  mirror "https://github.com/DomT4/LibreMirror/raw/d1dff2e5714953308864a606618a85cbde2375a2/Cardpeek/cardpeek-0.8.4.tar.gz"
  sha256 "9c78dfdf84493c551b49447e4bb46c8d7b33f0785b93893222b70b6115013a85"

  head "https://cardpeek.googlecode.com/svn/trunk/"

  bottle do
    cellar :any
    sha256 "5a370f77494e2dadb16bf37bf7838fed6c26841b8354a6c92323e9553cc5e3f0" => :el_capitan
    sha256 "7b2e3f1d05316f6f7d001898bfe6028ef98a9f40b561e4bd89bc1d77531d7dce" => :yosemite
    sha256 "16993be903b7a9c5e8cd64f930aa221837dcd387dc3af4e88c508cee585fed17" => :mavericks
  end

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
