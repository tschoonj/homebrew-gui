class Smartsim < Formula
  homepage "http://smartsim.org.uk"
  url "https://github.com/ashleynewson/SmartSim/archive/v1.4.tar.gz"
  sha256 "a0b088d69835fc85bb4410d03f8e91cdced90e362e4216797c3bd19ac8484b33"
  head "https://github.com/ashleynewson/smartsim"

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
