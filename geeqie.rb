class Geeqie < Formula
  desc "A lightweight Gtk+ based image viewer"
  homepage "http://geeqie.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/geeqie/geeqie/geeqie-1.1/geeqie-1.1.tar.gz"
  sha256 "5544e81c29917a647f19bfe800d9f0dd1cd5b890329feebd9abd80927e1afecf"
  revision 2

  bottle do
    sha256 "66ebef31e8351dd86e3121d5574a429547dd7f9f8e6c87058e3c69c8675a7e0b" => :yosemite
    sha256 "ee20b9403c52f9a7f448d2fab5270bcec0e3787fc3a8fe6cac9dbf18d65fced3" => :mavericks
    sha256 "278d6700b28fcccbc3c90d9af308ea298ce5cad7a3c5b72910a31998e8763ed8" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gnu-getopt"
  depends_on "imagemagick" => :recommended
  depends_on "exiv2" => :recommended
  depends_on "little-cms" => :recommended
  depends_on "fbida" => :recommended

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--disable-gtktest"
    system "make", "install"
  end

  test do
    system "#{bin}/geeqie", "--version"
  end
end
