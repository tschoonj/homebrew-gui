class Klavaro < Formula
  desc "A free touch typing tutor program"
  homepage "http://klavaro.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/klavaro/klavaro-3.01.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/k/klavaro/klavaro_3.01.orig.tar.bz2"
  sha256 "ed71d522c29113d5d6517a65cbf95dafbe85ca4bb978139b804b98f128015e85"

  bottle do
    revision 1
    sha256 "ca9fadbcc99ea26944e4704496e5b4dbaba5aa9d12e189a14238aa67c348f16c" => :yosemite
    sha256 "2f6457e0d5dd320fac6ccd0e4bd0f83a685035df647db7a0353d1c10d03b2308" => :mavericks
    sha256 "23e5f78422715b7083eab33788821e64c5d244ba9fd3a5fd408ace93260dc5b1" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gtk+3"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"klavaro", "--help-gtk"
  end
end
