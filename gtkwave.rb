class Gtkwave < Formula
  desc "Fully featured GTK+ based wave viewer"
  homepage "http://gtkwave.sourceforge.net/"
  url "http://gtkwave.sourceforge.net/gtkwave-3.3.73.tar.gz"
  sha256 "57bc88efa248c9f76950a49e7ff6a3f4a2062cb512fe7eb2e86976eb7f2be86a"

  bottle do
    cellar :any
    sha256 "cf92e280c519b77a7f1f83262468230c0444fe60d9d1ccc7a14021ced2b07158" => :el_capitan
    sha256 "ee9abb9b8de3d2f459baf453a6df4a9cac831736abbc95c021aee2f498a912a3" => :yosemite
    sha256 "c43f10cff2379630a213a6bb61cd5eaf63d5ebf4d928ec25b4dbc47a91fbf2af" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "xz" # For LZMA support

  def install
    args = ["--disable-dependency-tracking",
            "--disable-silent-rules",
            "--prefix=#{prefix}"]

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
