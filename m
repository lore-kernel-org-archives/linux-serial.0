From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: [PATCH] serial: 8250_pci: Remove bridge device Oxford 9511
Date: Tue, 07 Sep 2010 08:29:31 +0200
Message-ID: <4C85DBCB.5000408@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:64525 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab0IGGjP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Sep 2010 02:39:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

The following patch removes the device ID 0x9511 from Oxford
Semiconductors from this driver. This device is a local bus bridge and
not a serial device:

01:05.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART)
function 1
 (8bit bus) (rev 01)

01:05.1 0680: 1415:9511 (rev 01)
        Subsystem: 1415:0000

So there is no need to try to use the bridge as UARTs. :-)

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
---
--- linux-2.6/drivers/serial/8250_pci.c 2010-08-11 09:58:02.000000000 +=
0200
+++ patch/drivers/serial/8250_pci.c     2010-09-07 08:13:18.000000000 +=
0200
@@ -3205,9 +3205,6 @@
                PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_=
PG6,
                0, 0, pbn_computone_6 },

-       {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
-               PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-               pbn_oxsemi },
        {       PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
                PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0,
                pbn_b0_bt_1_921600 },


--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. TSP WPS R&D SW OSE

=46ujitsu Technology Solutions
B=FCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
