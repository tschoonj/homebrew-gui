class Kernagic < Formula
  homepage "https://github.com/hodefoting/kernagic/"
  url "https://github.com/hodefoting/kernagic/archive/v0.2.tar.gz"
  sha256 "41c328a2c177fd2c41f094641cdce4931115c34e69f140512d1461d42da502c2"
  head "https://github.com/hodefoting/kernagic.git"

  depends_on :x11
  depends_on "pkg-config" => :build
  depends_on "gtk+"

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/kernagic -h"
  end
end
