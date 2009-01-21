From: Michael Bramer <michael@debsupport.de>
Subject: Re: [PATCH] drivers/serial/8250_pci.c (add support for '8-port RS-232 MIC-3620 from advantech'
Date: Wed, 21 Jan 2009 07:52:13 +0000
Message-ID: <20090121075212.GA18485@deb-support.de>
References: <20090118135359.GA3087@deb-support.de> <20090119145101.GA16732@ports.donpac.ru> <20090119235122.GE21026@deb-support.de> <20090120151216.GB16732@ports.donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h4320.serverkompetenz.net ([81.169.172.102]:36554 "EHLO
	www.deb-support.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751801AbZAUHwR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Jan 2009 02:52:17 -0500
Content-Disposition: inline
In-Reply-To: <20090120151216.GB16732@ports.donpac.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tue, Jan 20, 2009 at 06:12:16PM +0300, Andrey Panin wrote:
> On 019, 01 19, 2009 at 11:51:22PM +0000, Michael Bramer wrote:
> > On Mon, Jan 19, 2009 at 05:51:01PM +0300, Andrey Panin wrote:
> > > On 018, 01 18, 2009 at 01:53:59PM +0000, Michael Bramer wrote:
> > > > +        * ADVANTECH
> > > > +        */
> > > > +       {
> > > > +               .vendor         =3D PCI_VENDOR_ID_ADVANTECH,
> > > > +               .device         =3D PCI_DEVICE_ID_ADVANTECH_PCI=
3620,
> > > > +               .subvendor      =3D PCI_DEVICE_ID_ADVANTECH_PCI=
3620,
> > > > +               .subdevice      =3D PCI_ANY_ID,
> > > > +               .setup          =3D pci_default_setup,
> > > > +       },
> > > > +       /*
> > > >          * AFAVLAB cards - these may be called via parport_seri=
al
> > > >          *  It is not clear whether this applies to all product=
s.
> > > >          */
> > >=20
> > > This part is not needed at all, pci_default_setup() will be used =
by default.
> >=20
> > ok. I don't test this. But you are right. The last entry in
> > pci_serial_quirks should catch it.=20
> >=20
> > Should I post a new patch, without this 10 lines?
>=20
> Yes and add Signed-off-by: line please.


the new patch:
--------------
This Patch add the device information for the=20
MIC-3620 8-port RS-232 cPCI card from Advantech Co. Ltd.

Signed-off-by: Michael Bramer <grisu@deb-support.de>
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -31,6 +31,7 @@
 #include "8250.h"

 #undef SERIAL_DEBUG_PCI
+#define SERIAL_DEBUG_PCI

 /*
  * init function returns:
@@ -768,6 +769,8 @@
 #define PCI_SUBDEVICE_ID_OCTPRO422     0x0208
 #define PCI_SUBDEVICE_ID_POCTAL232     0x0308
 #define PCI_SUBDEVICE_ID_POCTAL422     0x0408
+#define PCI_VENDOR_ID_ADVANTECH         0x13fe
+#define PCI_DEVICE_ID_ADVANTECH_PCI3620 0x3620

 /*
  * Master list of serial port init/setup/exit quirks.
@@ -2041,6 +2054,9 @@
 #endif

 static struct pci_device_id serial_pci_tbl[] =3D {
+       {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI362=
0,
+               0x3620, PCI_ANY_ID, 0, 0,
+               pbn_b2_8_921600 },
        {       PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
                PCI_SUBVENDOR_ID_CONNECT_TECH,
                PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
--------------

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
