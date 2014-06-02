#!/bin/sh

# Source Prezto color config.
if [[ -f "${ZDOTDIR:-$HOME}/.zprezto/modules/spectrum/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/modules/spectrum/init.zsh"
fi

NAME=${NAME:-torbrowser}
VERSION=${VERSION:-3.6.1}
TMPDIR=${TMPDIR:-/tmp}
INSTALLDIR=${INSTALLDIR:-/opt}
DESKTOPDIR=${DESKTOPDIR:-$HOME/.local/share/applications}
echo "$FG[green]--> begin install $NAME $VERSION into $INSTALLDIR $FG[none]"

# ---- config ---------------------------------------------------------
GPGFP=0x416F061063FEE659
# use archive as is contains old *and* current bundles
DLPREFIX=${DLPREFIX:-https://archive.torproject.org/tor-package-archive}
DLURL=$DLPREFIX/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_en-US.tar.xz
DLSIGURL=$DLPREFIX/torbrowser/${VERSION}/tor-browser-linux64-${VERSION}_en-US.tar.xz.asc

# ---- check if version is the newest----------------------------------
# TODO

# ---- download files -------------------------------------------------
echo "$FG[yellow]--> downloading $DLURL$FG[none]"
local tmpdlfile=${TMPDIR}/$(basename $DLURL)
curl -C - -# -o $tmpdlfile $DLURL
echo "$FG[yellow]--> downloading signature file $DLSIGURL$FG[none]"
local tmpdlsigfile=${TMPDIR}/$(basename $DLSIGURL)
curl -C - -# -o $tmpdlsigfile $DLSIGURL
# TODO fail if downloads failed/incomplete

# ---- verify files ---------------------------------------------------
echo "$FG[yellow]--> download signing key$FG[none]"
gpg --keyserver x-hkp://pool.sks-keyservers.net --recv-keys $GPGFP
gpg --fingerprint $GPGFP
echo "$FG[yellow]--> verifying file$FG[none]"
gpg --verify $tmpdlsigfile $tmpdlfile
# TODO fail if verify failed

# ---- get sudo privileges --------------------------------------------
echo "$FG[yellow]--> need sudo for install$FG[none]"
sudo echo "got sudo" > /dev/null
# TODO fail if sudo failed

# ---- install files --------------------------------------------------
echo "$FG[yellow]--> install $NAME into $INSTALLDIR$FG[none]"
sudo tar -C $INSTALLDIR -xvf $tmpdlfile
# TODO fail if tar failed

# ---- clean up tmp files ---------------------------------------------
echo "$FG[yellow]--> clean tmp files$FG[none]"
rm $tmpdlfile
rm $tmpdlsigfile

# ---- install desktop integration ------------------------------------
echo "$FG[yellow]--> create $NAME.deskop in $INSTALLDIR$FG[none]"
# TODO check if already available
cat >> ${DESKTOPDIR}/$NAME.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Torbrowser
Comment=Browse the World Wide Web
GenericName=Web Browser
X-GNOME-FullName=Torbrowser Web Browser
Exec=${INSTALLDIR}/tor-browser_en-US/start-tor-browser %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=${INSTALLDIR}/tor-browser_en-US/Browser/browser/icons/mozicon128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupWMClass=Torbrowser
StartupNotify=true
EOF

echo ""
echo "$FG[green]--> end install $NAME. no errors logged.$FG[none]"
