From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 1/3] Add register definitions used in several Exar PCI/PCIe UARTs
Date: Tue, 20 Nov 2012 11:21:17 -0600
Message-ID: <CAJp1Oe4aoeEQnDQWFAVaKNXVMn+294ZhNX6GfYx7F3Ym3ux6xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54559 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab2KTRVj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Nov 2012 12:21:39 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so758011vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 20 Nov 2012 09:21:38 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>

Add register definitions used in several Exar PCI/PCIe UARTs

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23

 include/uapi/linux/serial_reg.h |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index d0b4760..f27aa29 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -368,10 +368,22 @@
 #define UART_OMAP_MDR1_DISABLE		0x07	/* Disable (default state) */

 /*
- * These are definitions for the XR17V35X and XR17D15X
+ * These are definitions for the Exar XR17V35X and XR17(C|D)15X
  */
+#define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
 #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 #define UART_EXAR_DVID		0x8d	/* Device identification */

+#define UART_EXAR_FCTR		0x08	/* Feature Control Register */
+#define UART_FCTR_EXAR_IRDA	0x08	/* IrDa data encode select */
+#define UART_FCTR_EXAR_485	0x10	/* Auto 485 half duplex dir ctl */
+#define UART_FCTR_EXAR_TRGA	0x00	/* FIFO trigger table A */
+#define UART_FCTR_EXAR_TRGB	0x60	/* FIFO trigger table B */
+#define UART_FCTR_EXAR_TRGC	0x80	/* FIFO trigger table C */
+#define UART_FCTR_EXAR_TRGD	0xc0	/* FIFO trigger table D programmable */
+
+#define UART_EXAR_TXTRG		0x0a	/* Tx FIFO trigger level write-only */
+#define UART_EXAR_RXTRG		0x0b	/* Rx FIFO trigger level write-only */
+
 #endif /* _LINUX_SERIAL_REG_H */

-- 
1.7.2.5
