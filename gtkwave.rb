class Gtkwave < Formula
  desc "A fully featured GTK+ based wave viewer"
  homepage "http://gtkwave.sourceforge.net/"
  url "http://gtkwave.sourceforge.net/gtkwave-3.3.68.tar.gz"
  sha256 "9846ced0601c32c87bfda236ccadc2c6435a76c3a799b0d17ed54a5d7391343e"

  bottle do
    cellar :any
    sha256 "62fdd1795ed9e8e22f0cd491d338cee12083543fd65a3cf3cb0534f40cee1ce4" => :el_capitan
    sha256 "a98ca9697eb5eab7993ad4d534e5f5a2a85e776916e3b592a9a4c11f7fdca457" => :yosemite
    sha256 "60b0470f23ed6f7fb751a8f905b5c31f9c1f30a405271525a7046ca864ebb0dd" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "xz" # For LZMA support

  def install
    args = ["--disable-dependency-tracking",
            "--disable-silent-rules",
            "--prefix=#{prefix}",
           ]

    unless MacOS::CLT.installed?
      args << "--with-tcl=#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework"
      args << "--with-tk=#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework"
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/gtkwave", "--version"
  end
end
