class Klavaro < Formula
  desc "Free touch typing tutor program"
  homepage "http://klavaro.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/klavaro/klavaro-3.02.tar.bz2"
  sha256 "5f77730a8c1c8dfd4443ec8390c7226e3f82537df0882cd1222b140f0d0fcd6c"

  bottle do
    sha256 "de768a3f78c290d1ac3f2277ebc05f4b48aa6992fe71a04c4af26181a5e8f01e" => :el_capitan
    sha256 "63232843043cf0df5f6a12e6efccf777cad786f548cf86b4579b72c218b50eef" => :yosemite
    sha256 "e911fc1b9d095e647d6a62e1c7bc6c390ccbe6fb7e6313de0c268c11ce5fc59c" => :mavericks
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
