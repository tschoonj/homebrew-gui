class TransmissionRemoteGtk < Formula
  desc "GTK remote interface to the Transmission BT client"
  homepage "https://github.com/transmission-remote-gtk/transmission-remote-gtk"
  url "https://github.com/transmission-remote-gtk/transmission-remote-gtk/releases/download/1.3.1/transmission-remote-gtk-1.3.1.tar.xz"
  sha256 "1b29c573b1e205e3e7c2433dc4a48f9574278d97e033845d19bbffa1d7f75345"

  bottle do
    sha256 "34fa40fca4ab814d305a086534ded7c969c4e2a3442ba5cfed4aa95cae27aee9" => :el_capitan
    sha256 "e9fd55c23924db49a9189712e7b5b3aa53353f55da25638bbeb70244b8d0a5d5" => :yosemite
    sha256 "0f9a9b18466c05566d54eb099ba719aa173240c243d4b5004e2d4a0f4180a898" => :mavericks
  end

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+3"
  depends_on "json-glib"

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-gtk3"
    system "make", "install"
  end
end
