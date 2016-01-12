class TransmissionRemoteGtk < Formula
  homepage "https://code.google.com/p/transmission-remote-gtk/"
  url "https://transmission-remote-gtk.googlecode.com/files/transmission-remote-gtk-1.1.1.tar.gz"
  sha256 "9f5ac2de623d633bcaacb6362bb6d8fb468c6dff278b867f65809c48ea1570c9"

  depends_on :x11
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+3"
  depends_on "json-glib"

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-gtk3"
    system "make", "install"
  end
end
