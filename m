From: Bjorn Helgaas <bjorn-helgaas@comcast.net>
Subject: [PATCH] [SERIAL] add TP560 data/fax/modem support
Date: Mon, 07 Feb 2005 12:39:42 -0700
Message-ID: <1107805182.8074.35.camel@piglet>
Reply-To: bjorn.helgaas@hp.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from sccrmhc11.comcast.net ([204.127.202.55]:47592 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261283AbVBGTj6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Feb 2005 14:39:58 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Claim Topic TP560 data/fax/voice modem.  This device reports as class 0x0780,
so we don't claim it by default:

	00:0d.0 Class 0780: 151f:0000
		Subsystem: 151f:0000
		Interrupt: pin A routed to IRQ 11
		Region 0: I/O ports at a400 [size=8]
	00: 1f 15 00 00 01 00 00 02 00 00 80 07 00 00 00 00
	10: 01 a4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	20: 00 00 00 00 00 00 00 00 00 00 00 00 1f 15 00 00
	30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

Some rc.serial scripts extract IRQ and I/O port information from
/proc/pci and stuff it into an unused port using setserial.  That
doesn't work reliably anymore because pci_enable_device() is never
called, so the IRQ may not be enabled.

Thanks to Evan Clarke for reporting and helping debug this problem.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/serial/8250_pci.c 1.48 vs edited =====
--- 1.48/drivers/serial/8250_pci.c	2004-11-21 23:42:29 -07:00
+++ edited/drivers/serial/8250_pci.c	2005-02-07 12:00:32 -07:00
@@ -2212,6 +2212,13 @@
 		0, pbn_exar_XR17C158 },
 
 	/*
+	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
+	 */
+	{	PCI_VENDOR_ID_TOPIC, PCI_DEVICE_ID_TOPIC_TP560,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_1_115200 },
+
+	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
 	 */
===== include/linux/pci_ids.h 1.200 vs edited =====
--- 1.200/include/linux/pci_ids.h	2005-01-30 23:33:43 -07:00
+++ edited/include/linux/pci_ids.h	2005-02-07 11:56:14 -07:00
@@ -1972,6 +1972,9 @@
 #define PCI_DEVICE_ID_BCM4401		0x4401
 #define PCI_DEVICE_ID_BCM4401B0		0x4402
 
+#define PCI_VENDOR_ID_TOPIC		0x151f
+#define PCI_DEVICE_ID_TOPIC_TP560	0x0000
+
 #define PCI_VENDOR_ID_ENE		0x1524
 #define PCI_DEVICE_ID_ENE_1211		0x1211
 #define PCI_DEVICE_ID_ENE_1225		0x1225


