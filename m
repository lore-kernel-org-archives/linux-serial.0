From: Michael Bramer <michael@debsupport.de>
Subject: Re: [PATCH] drivers/serial/8250_pci.c (add support for '8-port RS-232 MIC-3620 from advantech'
Date: Wed, 21 Jan 2009 23:42:41 +0000
Message-ID: <20090121234241.GB10645@deb-support.de>
References: <20090118135359.GA3087@deb-support.de> <20090119145101.GA16732@ports.donpac.ru> <20090119235122.GE21026@deb-support.de> <20090120151216.GB16732@ports.donpac.ru> <20090121075212.GA18485@deb-support.de> <4976DA3D.7050201@teltonika.lt> <4976DF6F.2010509@wincor-nixdorf.com> <20090121123215.1b3acc4d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h4320.serverkompetenz.net ([81.169.172.102]:42743 "EHLO
	www.deb-support.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754087AbZAUXmr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jan 2009 18:42:47 -0500
Content-Disposition: inline
In-Reply-To: <20090121123215.1b3acc4d@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Niels de Vos <niels.devos@wincor-nixdorf.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Jan 21, 2009 at 12:32:15PM +0000, Alan Cox wrote:
> > >>  static struct pci_device_id serial_pci_tbl[] =3D {
> > >> +       {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH=
_PCI3620,
> > >> +               0x3620, PCI_ANY_ID, 0, 0,
> >=20
> > Why not use PCI_VENDOR_ID_ADVANTECH as PCI_SUBVENDOR_ID too?
>=20
> The Advantech vendor id is not 0x3620. This confused me as well which=
 is
> why I asked for an lspci. Advantech has stuck the device id in the
> subvendor bits and '1' in the subdevice (so it should be 1 not
> PCI_ANY_ID).

is this better?

+       {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI362=
0,
+               PCI_DEVICE_ID_ADVANTECH_PCI3620, 1, 0, 0,


Gruss
Grisu
--=20
Michael Bramer  -- http://www.feuerwehr.kreuzau.de/wiki/
PGP: finger grisu@db.debian.org  -- Linux Sysadmin   -- Use Debian Linu=
x
"Wenn ich die Folgen geahnt h=E4tte, w=E4re ich Uhrmacher geworden!"
                                                 --- Albert Einstein
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
