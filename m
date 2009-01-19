From: Michael Bramer <michael@debsupport.de>
Subject: Re: [PATCH] drivers/serial/8250_pci.c (add support for '8-port RS-232 MIC-3620 from advantech'
Date: Mon, 19 Jan 2009 11:45:26 +0000
Message-ID: <20090119114526.GA1714@deb-support.de>
References: <20090118135359.GA3087@deb-support.de> <20090118141409.3c2d0f95@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h4320.serverkompetenz.net ([81.169.172.102]:57500 "EHLO
	www.deb-support.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757821AbZASLp3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jan 2009 06:45:29 -0500
Content-Disposition: inline
In-Reply-To: <20090118141409.3c2d0f95@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, Jan 18, 2009 at 02:14:09PM +0000, Alan Cox wrote:
> > +               .vendor         =3D PCI_VENDOR_ID_ADVANTECH,
> > +               .device         =3D PCI_DEVICE_ID_ADVANTECH_PCI3620=
,
> > +               .subvendor      =3D PCI_DEVICE_ID_ADVANTECH_PCI3620=
,
> > +               .subdevice      =3D PCI_ANY_ID,
>=20
> This looks odd - the subvendor ought to be a vendor id, and there sho=
uld
> be a device id as well.

the number ist the same... i use now numbers in the patch...

> > can you add this in the next linux kernel?
>=20
> Can you firstly send me an lspci -vvxxx of that device. Also see
> Documentation/SubmittingPatches about Signed-off-by lines and we'll s=
ort
> out merging it.

done:

eps:~# lspci -vvxxx -d 13fe:3620
04:0d.0 Serial controller: Advantech Co. Ltd Device 3620 (rev 01) (prog=
-if 00 [8250])
        Subsystem: Device 3620:0001
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fddff000 (32-bit, non-prefetchable) [size=3D=
128]
        Region 2: I/O ports at df00 [size=3D128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1=
-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [48] CompactPCI hot-swap <?>
        Capabilities: [4c] Vital Product Data <?>
        Kernel modules: 8250_pci-, 8250_pci
00: fe 13 20 36 03 00 90 02 01 00 00 07 10 00 00 00
10: 00 f0 df fd 00 00 00 00 01 df 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 20 36 01 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 01 48 01 48 00 00 00 00 06 4c 00 00 03 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

and now the patch:
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
@@ -789,6 +792,16 @@
                .setup          =3D addidata_apci7800_setup,
        },
        /*
+        * ADVANTECH
+        */
+       {
+               .vendor         =3D PCI_VENDOR_ID_ADVANTECH,
+               .device         =3D PCI_DEVICE_ID_ADVANTECH_PCI3620,
+               .subvendor      =3D 0x3620,
+               .subdevice      =3D PCI_ANY_ID,
+               .setup          =3D pci_default_setup,
+       },
+       /*
         * AFAVLAB cards - these may be called via parport_serial
         *  It is not clear whether this applies to all products.
         */
@@ -2041,6 +2054,9 @@
 #endif

 static struct pci_device_id serial_pci_tbl[] =3D {
+       {       PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI362=
0,
+               PCI_DEVICE_ID_ADVANTECH_PCI3620, PCI_ANY_ID, 0, 0,
+               pbn_b2_8_921600 },
        {       PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
                PCI_SUBVENDOR_ID_CONNECT_TECH,
                PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
--------------

Thanks for your help

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
