From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-serial@rere.qmqm.pl>
Subject: [SERIAL] Comment typo fix for include/linux/serial_reg.h
Date: Sun, 22 Jan 2006 01:03:21 +0100
Message-ID: <20060122000321.GA19574@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host-86-63-132-164.pronet.lublin.pl ([86.63.132.164]:6630 "EHLO
	rere.qmqm.pl") by vger.kernel.org with ESMTP id S1751237AbWAVADX
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Jan 2006 19:03:23 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

Hi,

This is a trivial typo fix. I sent it about a month ago, but it never
got to the kernel.

  -- Michal Miroslaw

diff -urN linux-2.6.16-rc1-mq12/include/linux/serial_reg.h linux-2.6.16-rc1-mq123/include/linux/serial_reg.h
--- linux-2.6.16-rc1-mq12/include/linux/serial_reg.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc1-mq123/include/linux/serial_reg.h	2006-01-22 00:29:50.458495618 +0100
@@ -247,10 +247,10 @@
 #define UART_CTR	0xFF
 
 /*
- * The 16C950 Additional Control Reigster
+ * The 16C950 Additional Control Register
  */
 #define UART_ACR_RXDIS	0x01	/* Receiver disable */
-#define UART_ACR_TXDIS	0x02	/* Receiver disable */
+#define UART_ACR_TXDIS	0x02	/* Transmitter disable */
 #define UART_ACR_DSRFC	0x04	/* DSR Flow Control */
 #define UART_ACR_TLENB	0x20	/* 950 trigger levels enable */
 #define UART_ACR_ICRRD	0x40	/* ICR Read enable */
