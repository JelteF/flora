# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils

# Major version
MV=${PV/\.*}

DESCRIPTION="All-In-One Solution for Remote Access and Support over the Internet"
HOMEPAGE="http://www.teamviewer.com"
SRC_URI="http://www.teamviewer.com/download/${PN}_linux.tar.gz -> ${P}.tar.gz"

LICENSE="TeamViewer"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="app-emulation/wine"
DEPEND="${RDEPEND}"

S="${WORKDIR}/teamviewer${MV}"

pkg_setup() {
	elog "This ebuild installs the TeamViewer binary and libraries and relies on"
	elog "Funtoo's wine package to run the actual program."
	elog
	elog "If you encounter any problems, consider running TeamViewer with the"
	elog "bundled wine package manually."
}

src_install () {
	rm ${PN}
	echo "#!/bin/bash" > ${PN}
	echo "wine /opt/${PN}/TeamViewer.exe" >> ${PN}

	insinto /opt/${PN}/
	doins .wine/drive_c/Program\ Files/TeamViewer/Version7/*
	doins ${PN}

	fperms 755 /opt/${PN}/${PN}
	dosym /opt/${PN}/${PN} /opt/bin/${PN}

	doicon -s 48 .tvscript/${PN}.png

	dodoc linux_FAQ_{EN,DE}.txt
	dodoc CopyRights_{EN,DE}.txt

	make_desktop_entry ${PN} TeamViewer \
	/opt/${PN}/.tvscript/${PN}.png 'Network;'

}
