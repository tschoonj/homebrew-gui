class TarsnapGui < Formula
  desc "Cross platform GUI for the Tarsnap command-line client"
  homepage "https://github.com/Tarsnap/tarsnap-gui/wiki/Tarsnap"
  url "https://github.com/Tarsnap/tarsnap-gui/archive/v0.9.tar.gz"
  sha256 "e47e1e611f2c7bb5111bcc1d2d86fa2c045ba4af23f8430bbc3c72f546572cb8"
  head "https://github.com/Tarsnap/tarsnap-gui.git"

  bottle do
    cellar :any
    sha256 "c329601b4de7b81a896bbb80c15386e36d9f8fcc03d626896507527e1fe7f53f" => :el_capitan
    sha256 "bf0325aec8de7d72de14a484b96adfd852e01b0d0324a5b414367cdbf418feee" => :yosemite
    sha256 "8fd12215e86c7c8e9e1ac31b4ce866d85728193ceeccc74b5310a1bc37e57eef" => :mavericks
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
