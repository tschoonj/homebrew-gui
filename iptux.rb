class Iptux < Formula
  desc "Software for sharing in LAN"
  homepage "https://github.com/iptux-src/iptux"
  url "https://github.com/iptux-src/iptux/archive/v0.6.3.tar.gz"
  sha256 "91f4e478a4adfbfdb67be155fb68d01aa58cff9b2b27cd1dfe0dd1d4a4c26d93"

  bottle do
    sha256 "b867d2b3e9a0109ffe2dce855088f1dc2ddc5f038bbace01e530ce187527f746" => :el_capitan
    sha256 "a2cc902c05ec939a80aedd9f22c437fa7511a7cd2f21a4d2452d70426cf2fbab" => :yosemite
    sha256 "d250d2e82be2130d0d7b47410f0dadbb002d7b769072ce1babc17571ff7ed52f" => :mavericks
  end

  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gconf"
  depends_on "hicolor-icon-theme"
  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/iptux", "--version"
  end
end
