From: Michael Bramer <michael@debsupport.de>
Subject: Re: [PATCH] drivers/serial/8250_pci.c (add support for '8-port RS-232 MIC-3620 from advantech'
Date: Thu, 22 Jan 2009 16:44:53 +0000
Message-ID: <20090122164453.GA11553@deb-support.de>
References: <6E0880DF84464BF2AA0275ABFFCCDAF2@acksys.local> <49783679.8010005@wincor-nixdorf.com> <20090122110003.GA24450@deb-support.de> <49785CD7.6020800@teltonika.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757455AbZAVQpi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49785CD7.6020800@teltonika.lt>
Sender: linux-kernel-owner@vger.kernel.org
To: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: Niels de Vos <niels.devos@wincor-nixdorf.com>, Tosoni <jp.tosoni@acksys.fr>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 22, 2009 at 01:47:35PM +0200, Paulius Zaleckas wrote:
> > Is the patch now ok?
>=20
> No :)
>=20
> > ----
> > This Patch add the device information for the
> > MIC-3620 8-port RS-232 cPCI card from Advantech Co. Ltd.
> >=20
> > Signed-off-by: Michael Bramer <grisu@deb-support.de>
> > --- a/drivers/serial/8250_pci.c	2008-07-13 23:51:29.000000000 +0200
> > +++ b/drivers/serial/8250_pci.c	2009-01-17 21:37:37.000000000 +0100
> > @@ -769,6 +768,8 @@
> >  #define PCI_SUBDEVICE_ID_OCTPRO422	0x0208
> >  #define PCI_SUBDEVICE_ID_POCTAL232	0x0308
> >  #define PCI_SUBDEVICE_ID_POCTAL422	0x0408
> > +#define PCI_VENDOR_ID_ADVANTECH         0x13fe
> > +#define PCI_DEVICE_ID_ADVANTECH_PCI3620 0x3620
>=20
> Use TABs for indentation here.

ok:

-----
This Patch add the device information for the
MIC-3620 8-port RS-232 cPCI card from Advantech Co. Ltd.

Signed-off-by: Michael Bramer <grisu@deb-support.de>
--- a/drivers/serial/8250_pci.c	2008-07-13 23:51:29.000000000 +0200
+++ b/drivers/serial/8250_pci.c	2009-01-17 21:37:37.000000000 +0100
@@ -769,6 +768,8 @@
 #define PCI_SUBDEVICE_ID_OCTPRO422	0x0208
 #define PCI_SUBDEVICE_ID_POCTAL232	0x0308
 #define PCI_SUBDEVICE_ID_POCTAL422	0x0408
+#define PCI_VENDOR_ID_ADVANTECH	0x13fe
+#define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
=20
 /*
  * Master list of serial port init/setup/exit quirks.
@@ -2054,6 +2041,10 @@
 #endif
=20
 static struct pci_device_id serial_pci_tbl[] =3D {
+	// Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUB=
VENDOR_ID'
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
+		PCI_DEVICE_ID_ADVANTECH_PCI3620, 1, 0, 0,
+		pbn_b2_8_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
-----

Gruss
Grisu
--=20
Michael Bramer  -- http://www.feuerwehr.kreuzau.de/wiki/
PGP: finger grisu@db.debian.org  -- Linux Sysadmin   -- Use Debian Linu=
x
"Wenn ich die Folgen geahnt h=E4tte, w=E4re ich Uhrmacher geworden!"
                                                 --- Albert Einstein
