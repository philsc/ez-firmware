#!/bin/bash

# http://www.nongnu.org/avr-libc/user-manual/install_tools.html
# Inspired by https://gist.github.com/zkemble/edec6914ba719bf339b1b85c1fa792dc

set -e
set -u
set -o pipefail

# For optimum compile time this should generally be set to the number of CPU cores your machine has
readonly JOBCOUNT=$(nproc)

# Output locations for built toolchains
readonly PREFIX_LINUX=/tmp/avr-gcc/linux
readonly PREFIX_LIBC=/tmp/avr-gcc/libc

readonly NAME_BINUTILS="binutils-2.30"
readonly NAME_GCC="gcc-7.3.0"
readonly NAME_LIBC="avr-libc-2.0.0"

readonly -a OPTS_BINUTILS=(
	--target=avr
	--disable-nls
)

readonly -a OPTS_GCC=(
	--target=avr
	--enable-languages=c,c++
	--disable-nls
	--disable-libssp
	--disable-libada
	--with-dwarf2
	--disable-shared
	--enable-static
)

readonly -a OPTS_LIBC=()

readonly TIME_START="$SECONDS"

makeDir() {
	rm -rf "$1/"
	mkdir -p "$1"
}

echo "Clearing output directories..."
makeDir "$PREFIX_LINUX"
makeDir "$PREFIX_LIBC"

PATH="$PATH":"$PREFIX_LINUX"/bin
export PATH

CC=""
export CC

echo "Downloading sources..."
rm -rf $NAME_BINUTILS/
wget -c ftp://ftp.mirrorservice.org/sites/ftp.gnu.org/gnu/binutils/$NAME_BINUTILS.tar.xz
rm -rf $NAME_GCC/
wget -c ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/$NAME_GCC/$NAME_GCC.tar.xz
rm -rf $NAME_LIBC/
wget -c ftp://ftp.mirrorservice.org/sites/download.savannah.gnu.org/releases/avr-libc/$NAME_LIBC.tar.bz2

confMake() {
	local prefix="$1"
	shift
	../configure --prefix="$prefix" "$@"
	make -j "$JOBCOUNT"
	make install-strip
	rm -rf *
}

# Make AVR-Binutils
echo "Making Binutils..."
echo "Extracting..."
tar xf $NAME_BINUTILS.tar.xz
mkdir -p $NAME_BINUTILS/obj-avr
cd $NAME_BINUTILS/obj-avr
confMake "$PREFIX_LINUX" "${OPTS_BINUTILS[@]}"
cd ../../

# Make AVR-GCC
echo "Making GCC..."
echo "Extracting..."
tar xf $NAME_GCC.tar.xz
mkdir -p $NAME_GCC/obj-avr
cd $NAME_GCC
./contrib/download_prerequisites
cd obj-avr
confMake "$PREFIX_LINUX" "${OPTS_GCC[@]}"
cd ../../

# Make AVR-LibC
echo "Making AVR-LibC..."
echo "Extracting..."
bunzip2 -c $NAME_LIBC.tar.bz2 | tar xf -
mkdir -p $NAME_LIBC/obj-avr
cd $NAME_LIBC/obj-avr
confMake "$PREFIX_LIBC" "${OPTS_LIBC[@]}" --host=avr --build=`../config.guess`
cd ../../

readonly TIME_END="$SECONDS"
readonly TIME_RUN=$((TIME_END - TIME_START))

tar -cvaf "avr-$NAME_GCC.tar" --transform 's,^\.,./usr,' --mtime=@0 --owner=root --group=root -C "$PREFIX_LINUX" .
tar -rvaf "avr-$NAME_GCC.tar" --transform 's,^\.,./usr,' --mtime=@0 --owner=root --group=root -C "$PREFIX_LIBC" .
xz --compress -9 "avr-$NAME_GCC.tar"

echo ""
echo "Done in $TIME_RUN seconds"

exit 0
