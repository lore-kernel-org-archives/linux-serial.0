From: Maciej Szmigiero <mhej@o2.pl>
Subject: [SERIAL]blacklist si3052 chip
Date: Tue, 26 Oct 2010 21:48:21 +0200
Message-ID: <4CC73085.2070304@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[SERIAL]blacklist si3052 chip

Si3052-based softmodems aren't serial ports so don't bind serial driver to them.
Allows proper driver to bind to them.

Signed-off-by: Maciej Szmigiero <mhej@o2.pl>

--- a/drivers/serial/8250_pci.c	2010-10-26 20:59:32.000000000 +0200
+++ b/drivers/serial/8250_pci.c	2010-10-26 21:12:56.000000000 +0200
@@ -2275,6 +2275,8 @@
 
 static const struct pci_device_id softmodem_blacklist[] = {
 	{ PCI_VDEVICE(AL, 0x5457), }, /* ALi Corporation M5457 AC'97 Modem */
+	{ PCI_VDEVICE(MOTOROLA, 0x3052), }, /* Motorola Si3052-based modem */
+	{ PCI_DEVICE(0x1543, 0x3052), }, /* Si3052-based modem, default IDs */
 };
 
 /*
