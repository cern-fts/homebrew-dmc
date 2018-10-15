class Gfal2Python < Formula
  desc "Grid file access library 2"
  homepage "http://dmc.web.cern.ch/"
  url "https://gitlab.cern.ch/dmc/gfal2-bindings.git", :branch => "develop"
  version "1.9.5"

  depends_on "boost-python"
  depends_on "cmake" => :build
  depends_on "gfal2"
  depends_on "pkg-config" => :build
  depends_on "python@2"

  def install
    py_exec = `/usr/bin/which python`.strip
    py_version = `python -c "from __future__ import print_function; import sys; print('%d.%d' % sys.version_info[0:2])"`.strip
    py_prefix = `python -c "from __future__ import print_function; import sys; print(sys.prefix)"`.strip
    py_include = `python -c "from __future__ import print_function; import distutils.sysconfig; print(distutils.sysconfig.get_python_inc(True))"`.strip
    py_site_packages = `python -c "from __future__ import print_function; from distutils.sysconfig import get_python_lib; print(get_python_lib(True))"`.strip

    system "cmake", "-DSKIP_DOC=ON",
        "-DPYTHON_LIBRARIES=#{py_prefix}/lib/libpython#{py_version}.dylib",
        "-DPYTHON_INCLUDE_PATH=#{py_include}",
        "-DPYTHON_EXECUTABLE=#{py_exec}",
        "-DPYTHON_SITE_PACKAGES=#{prefix}",
        "-DBOOST_LIBRARYDIR=/Users/jenkins/Builds/homebrew/Cellar/boost-python/1.67.0/lib",
        ".", *std_cmake_args
    system "make", "install"
    (lib/"python2.7/site-packages").install_symlink "#{prefix}/gfal2.so"
  end

  test do
    ENV["PYTHONPATH"] = lib+"python2.7/site-packages"
    system "python", "-c", "import gfal2; print gfal2.__version__"
  end
end

