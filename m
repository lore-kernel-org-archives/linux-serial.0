From: Jonathan Woithe <jwoithe@just42.net>
Subject: [PATCH] [RESEND] serial: 8250: Fix initialisation of Quatech cards
 with the AMCC PCI chip
Date: Mon, 9 Dec 2013 16:33:08 +1030
Message-ID: <20131209060308.GH3689@marvin.atrad.com.au>
References: <20131031051340.GG927@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:45334 "EHLO
	server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3LIGNO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 01:13:14 -0500
Content-Disposition: inline
In-Reply-To: <20131031051340.GG927@marvin.atrad.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: jwoithe@just42.net

Fix the initialisation of older Quatech serial cards which are fitted with
the AMCC PCI Matchmaker interface chip.

Signed-off-by: Jonathan Woithe (jwoithe@just42.net)
---
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c810da7..710f6d7 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1260,10 +1260,10 @@ static int pci_quatech_init(struct pci_dev *dev)
 		unsigned long base = pci_resource_start(dev, 0);
 		if (base) {
 			u32 tmp;
-			outl(inl(base + 0x38), base + 0x38);
+			outl(inl(base + 0x38) | 0x00002000, base + 0x38);
 			tmp = inl(base + 0x3c);
 			outl(tmp | 0x01000000, base + 0x3c);
-			outl(tmp, base + 0x3c);
+			outl(tmp &= ~0x01000000, base + 0x3c);
 		}
 	}
 	return 0;
