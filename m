From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 3/3] Add initialization of sampling mode and tx/rx triggers to pci_xr17v35x_setup
Date: Tue, 20 Nov 2012 11:25:40 -0600
Message-ID: <CAJp1Oe6a1s4aiXVfR0yJQSr5rExN1jE7yDhNd2bFwi99z5WA=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56457 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab2KTR0A (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Nov 2012 12:26:00 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so762547vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 20 Nov 2012 09:26:00 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>

Add initialization of sampling mode and tx/rx triggers to pci_xr17v35x_setup

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23

This depends on my previous patch submission:
[PATCH v3] Add support for new devices: Exar's XR17V35x family of
multi-port PCIe UARTs

 drivers/tty/serial/8250/8250_pci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c
b/drivers/tty/serial/8250/8250_pci.c
index 6a7007c..3b5c426 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1192,6 +1192,10 @@ pci_xr17v35x_setup(struct serial_private *priv,
 		writeb(0x00, p + 0x99); /*MPIOSEL[15:8]*/
 		writeb(0x00, p + 0x9a); /*MPIOOD[15:8]*/
 	}
+	writeb(0x00, p + UART_EXAR_8XMODE);
+	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
+	writeb(128, p + UART_EXAR_TXTRG);
+	writeb(128, p + UART_EXAR_RXTRG);
 	iounmap(p);

 	return pci_default_setup(priv, board, port, idx);
-- 
1.7.2.5
