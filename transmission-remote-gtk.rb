class TransmissionRemoteGtk < Formula
  desc "GTK remote interface to the Transmission BT client"
  homepage "https://github.com/transmission-remote-gtk/transmission-remote-gtk"
  url "https://github.com/transmission-remote-gtk/transmission-remote-gtk/releases/download/1.3.0/transmission-remote-gtk-1.3.0.tar.xz"
  sha256 "6fe30b4561681458500e61cc6db10c3b4b3771f69e2f6a74dbb7a20b03a3cbe6"

  bottle do
    sha256 "31152453f9a1f37be6a8a9708f4fe7700c0c2beab0a7df17b0bc7697b57b8981" => :el_capitan
    sha256 "71e03421172b0db9022536fd86b9df676773f1b34bd904107a689bcbba1791d2" => :yosemite
    sha256 "fda18813fe8c12f406748e5f2b1976777cb8df579474b10ccbdfe80a6cca7acb" => :mavericks
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
