From: Michael Bramer <michael@debsupport.de>
Subject: [PATCH] drivers/serial/8250_pci.c (add support for '8-port RS-232 MIC-3620 from advantech'
Date: Sun, 18 Jan 2009 13:53:59 +0000
Message-ID: <20090118135359.GA3087@deb-support.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h4320.serverkompetenz.net ([81.169.172.102]:52401 "EHLO
	www.deb-support.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758522AbZAROE4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Jan 2009 09:04:56 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org

Hello

This is my first mail to this list... sorry for all my mistakes

We use a 8-port RS-232 MIC-3620 from advantech (see
http://www.advantech.com/products/8-port-RS-232-Communication-CPCI-Card=
/mod_1-2MLG80.aspx)
and need linux support for this card.

This patch add is:
-------------------------------------
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -768,6 +769,8 @@
 #define PCI_SUBDEVICE_ID_OCTPRO422      0x0208
 #define PCI_SUBDEVICE_ID_POCTAL232      0x0308
 #define PCI_SUBDEVICE_ID_POCTAL422      0x0408
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
+               .subvendor      =3D PCI_DEVICE_ID_ADVANTECH_PCI3620,
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
-------------------------------------

can you add this in the next linux kernel?

Thanks for linux!

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
