class TarsnapGui < Formula
  desc "Cross platform GUI for the Tarsnap command-line client"
  homepage "https://github.com/Tarsnap/tarsnap-gui/wiki"
  url "https://github.com/Tarsnap/tarsnap-gui/archive/v0.9.tar.gz"
  sha256 "e47e1e611f2c7bb5111bcc1d2d86fa2c045ba4af23f8430bbc3c72f546572cb8"
  head "https://github.com/Tarsnap/tarsnap-gui.git"

  bottle do
    sha256 "0d55fc625e4a1dd54ec5a70b927bf6012611fd7f3f454e65a8d5441103509bc5" => :el_capitan
    sha256 "4bbf409ded62deba8b0f22a610d103d1a203102f608ee0a74df6c6f5aa0a40dc" => :yosemite
    sha256 "6d9a259ea44bec1bece9540315aa74b7cb423bcee4d6f6c43b5d9ff94c30c52c" => :mavericks
  end

  depends_on "qt5"
  depends_on "tarsnap"

  def install
    system "qmake"
    system "make"
    system "macdeployqt", "Tarsnap.app"
    prefix.install "Tarsnap.app"
  end

  test do
    system "#{opt_prefix}/Tarsnap.app/Contents/MacOS/Tarsnap", "--version"
  end
end
