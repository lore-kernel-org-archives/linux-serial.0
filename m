From: Ralf Baechle <ralf@linux-mips.org>
Subject: [SERIAL] Fix modpost warning in serial driver.
Date: Thu, 23 Aug 2007 15:13:39 +0100
Message-ID: <20070823141339.GA2419@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:41347 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758830AbXHWONm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Aug 2007 10:13:42 -0400
Received: from localhost.localdomain ([127.0.0.1]:64929 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023786AbXHWONl (ORCPT <rfc822;linux-serial@vger.kernel.org>
	+ 1 other); Thu, 23 Aug 2007 15:13:41 +0100
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

This is triggered if PCI && !HOTPLUG.

  MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0xc910): Section mismatch: reference to .init.text:pci_ite887x_init (between 'pci_serial_quirks' and 'serial_pci_tbl')

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index bd66339..1ea1ed8 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -610,7 +610,7 @@ static int pci_netmos_init(struct pci_dev *dev)
 /* enable IO_Space bit */
 #define ITE_887x_POSIO_ENABLE		(1 << 31)
 
-static int __devinit pci_ite887x_init(struct pci_dev *dev)
+static int pci_ite887x_init(struct pci_dev *dev)
 {
 	/* inta_addr are the configuration addresses of the ITE */
 	static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0,
