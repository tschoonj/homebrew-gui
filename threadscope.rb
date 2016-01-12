require "language/haskell"

class Threadscope < Formula
  include Language::Haskell::Cabal
  desc "A tool for performance profiling of parallel Haskell programs"
  homepage "https://wiki.haskell.org/ThreadScope"
  url "https://hackage.haskell.org/package/threadscope-0.2.7/threadscope-0.2.7.tar.gz"
  sha256 "cc5653831252d55b3ba7506ea648e770b2c4489cdf4d78828f07dc24ea7ffdb6"

  bottle do
    sha256 "c6852b8d87b9e0004cf94e92a3b19faa35c142f6224b50ed42f282685c4a22d8" => :yosemite
    sha256 "8b430ceeb2b07d4d9442b607537d8ad4bc51ffe06611db25b1c210bed93becb0" => :mavericks
    sha256 "ba0ed2c9b22c9ed5baef6516d0569d21201d529142075eeba0e0ce20968592ec" => :mountain_lion
  end

  depends_on "cabal-install" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "ghc"
  depends_on "glib"
  depends_on "gmp"
  depends_on "gtk+"
  depends_on "pango"

  def install
    cabal_sandbox do
      cabal_install_tools "alex", "happy"
      cabal_install "--only-dependencies", "ghc-events"
      cabal_install "--prefix=#{prefix}", "ghc-events"
      cabal_install_tools "gtk2hs-buildtools"
      cabal_install "glib", "gio", "cairo", "pango"
      cabal_install "-fhave-quartz-gtk", "gtk"
      cabal_install "--only-dependencies"
      cabal_install "--prefix=#{prefix}"
    end
    cabal_clean_lib
  end

  test do
    system "#{bin}/threadscope", "--version"
  end
end
