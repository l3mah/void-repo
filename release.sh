#!/bin/sh -e
# Publish built packages from a void-packages checkout into this repository:
# copy each package out of hostdir/binpkgs, re-index, sign, commit, push.
#
#   ./release.sh honey-0.20.1_1 [pkgver...]
#
# Overridable environment: VOID_PACKAGES, PRIVKEY, SIGNEDBY, ARCH.

VOID_PACKAGES=${VOID_PACKAGES:-$HOME/dev/l3mah/void-packages}
PRIVKEY=${PRIVKEY:-$HOME/.ssh/xbps-signing.pem}
SIGNEDBY=${SIGNEDBY:-"Maxence Hamel"}
ARCH=${ARCH:-x86_64}

if [ $# -lt 1 ]; then
	echo "usage: $0 <pkgver> [pkgver...]   e.g. $0 honey-0.20.1_1" >&2
	exit 2
fi
cd "$(dirname "$0")"

for pkgver in "$@"; do
	pkg="$VOID_PACKAGES/hostdir/binpkgs/$pkgver.$ARCH.xbps"
	if [ ! -f "$pkg" ]; then
		echo "not found: $pkg" >&2
		exit 1
	fi
	cp "$pkg" "$ARCH/"
	xbps-rindex --add "$ARCH/$pkgver.$ARCH.xbps"
	xbps-rindex --force --privkey "$PRIVKEY" --sign-pkg "$ARCH/$pkgver.$ARCH.xbps"
done
xbps-rindex --privkey "$PRIVKEY" --sign --signedby "$SIGNEDBY" "$ARCH"

git add "$ARCH"
git commit -m "Publish: $*"
git push
echo "published: $*"
