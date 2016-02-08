class Smartsim < Formula
  homepage "http://smartsim.org.uk"
  url "https://github.com/ashleynewson/SmartSim/archive/v1.4.tar.gz"
  sha256 "a0b088d69835fc85bb4410d03f8e91cdced90e362e4216797c3bd19ac8484b33"
  head "https://github.com/ashleynewson/smartsim"

  bottle do
    sha256 "7fbb9ae95a846f794cf6c3d8603bf002374e7a221c59f540a417fa0755eaf282" => :el_capitan
    sha256 "e4b52a9c959b131f6a88a9386eeb5792005e6a512448867d3a0c048e46d29675" => :yosemite
    sha256 "6dc1cbbf12bc1a41f019dc161d33740f80446744d72f180028869c3c476e32f8" => :mavericks
  end

  depends_on "gtk+3"
  depends_on "librsvg"
  depends_on "libxml2"
  depends_on "glib"
  depends_on "pkg-config" => :build
  depends_on "gettext"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/smartsim", "--version"
  end
end
