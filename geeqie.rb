class Geeqie < Formula
  desc "A lightweight Gtk+ based image viewer"
  homepage "http://geeqie.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/geeqie/geeqie/geeqie-1.1/geeqie-1.1.tar.gz"
  sha256 "5544e81c29917a647f19bfe800d9f0dd1cd5b890329feebd9abd80927e1afecf"
  revision 2

  bottle do
    sha256 "0e66dc0230ed6f10a29e7f9e14a4fe17cb8513ca868e55935783613eadd440ab" => :el_capitan
    sha256 "b5aca2da01efe158d87adbd9c9a31865b9ea8c779d5f469484486ace8f931c51" => :yosemite
    sha256 "25f034fd0ad78011464619acfacb550ca81e1d4ba27362136cab15b108603831" => :mavericks
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
