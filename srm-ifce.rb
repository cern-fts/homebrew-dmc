class SrmIfce < Formula
  desc "SRM client side library"
  homepage "http://dmc.web.cern.ch/"
  url "https://gitlab.cern.ch/dmc/srm-ifce.git", :branch => "develop"
  version "1.24.3"

  depends_on "cgsi-gsoap"
  depends_on "cmake" => :build
  depends_on "gsoap" => :build
  depends_on "glib"
  depends_on "globus-toolkit"
  depends_on "pkg-config" => :build

  def install
    globus = Formula["globus-toolkit"].opt_prefix

    system "cmake", ".", "-DGLOBUS_PREFIX=#{globus}" , *std_cmake_args
    system "make", "install"
  end

  test do
   system "#{bin}/gfal_srm_ifce_version"
  end
end
