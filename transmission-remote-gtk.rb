class TransmissionRemoteGtk < Formula
  homepage "https://code.google.com/p/transmission-remote-gtk/"
  url "https://transmission-remote-gtk.googlecode.com/files/transmission-remote-gtk-1.1.1.tar.gz"
  sha256 "9f5ac2de623d633bcaacb6362bb6d8fb468c6dff278b867f65809c48ea1570c9"

  bottle do
    sha256 "43bb2154c2ae72de79d279622fcba23b1891404c8ad1bcc047335faad59291b5" => :el_capitan
    sha256 "31d4aa3cba2fa14a36f1a1e727402e46ed3e7757763ebd9da6c8b8060751df80" => :yosemite
    sha256 "66f9c3d4ae7ac5949a4f9d6d72c1ccfde14ae2d761e141f68d5014d9b13879eb" => :mavericks
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
