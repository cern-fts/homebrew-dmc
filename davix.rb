class Davix < Formula
  desc "Library and tools for advanced file I/O with HTTP-based protocols"
  homepage "https://dmc.web.cern.ch/projects/davix/home"
  url "https://github.com/cern-it-sdc-id/davix.git",
    :branch => "devel"
  version "0.6.5-1"

  head "https://github.com/cern-it-sdc-id/davix.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gsoap"
  depends_on "openssl"
  depends_on "ossp-uuid"
  depends_on "pkg-config" => :build
 
  def install
    ENV.libcxx

    system "cmake", "-DENABLE_THIRD_PARTY_COPY=ON", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/davix-get", "http://www.google.com"
  end
end
