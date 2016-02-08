class Kernagic < Formula
  homepage "https://github.com/hodefoting/kernagic/"
  url "https://github.com/hodefoting/kernagic/archive/v0.2.tar.gz"
  sha256 "41c328a2c177fd2c41f094641cdce4931115c34e69f140512d1461d42da502c2"
  head "https://github.com/hodefoting/kernagic.git"

  bottle do
    cellar :any
    sha256 "65891dbc2169da37b31eb2433e3636e37cd668a9f69d10406975934b0668b68b" => :el_capitan
    sha256 "a9e51ff4ad2ddc2ee348e5f3062e049ba19be87962a6f04a7816107daf79a65b" => :yosemite
    sha256 "c49fb0afcd88658cd5007fba4cf2d97b1b35458ce6479c69b1d8d484c5ede869" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "gtk+"

  # removes option not provided by older clangs
  patch :DATA

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/kernagic -h"
  end
end
__END__
diff --git a/.mm/magic b/.mm/magic
index 088e5d9..d9e0a47 100644
--- a/.mm/magic
+++ b/.mm/magic
@@ -6,7 +6,7 @@ CFLAGS += -Wall -Wextra
 #CFLAGS += -g -O2 -rdynamic
 CFLAGS += -fPIC
 #CFLAGS += -fomit-frame-pointer
-CFLAGS += -funroll-loops -fforce-addr -ftracer -fpeel-loops -fmerge-all-constants
+CFLAGS += -funroll-loops -fforce-addr -ftracer -fmerge-all-constants
 CFLAGS += -Wno-unused-parameter  -Wno-sign-compare
 CFLAGS +=  -I. -D_XOPEN_SOURCE=500
 CFLAGS += -std=c99
