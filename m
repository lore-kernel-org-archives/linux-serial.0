From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-serial@rere.qmqm.pl>
Subject: [PATCH] serial: Comment typo fix for include/linux/serial_reg.h
Date: Sun, 5 Feb 2006 12:52:14 +0100
Message-ID: <20060205115212.GA27445@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from host-86-63-132-164.pronet.lublin.pl ([86.63.132.164]:2191 "EHLO
	rere.qmqm.pl") by vger.kernel.org with ESMTP id S1751727AbWBELw3
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Feb 2006 06:52:29 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

=46ix typo and cut-n-paste error in serial_reg.h comments for 16C950 AC=
R.

Signed-off-by: Micha=B3 Miros=B3aw <mirq-serial@rere.qmqm.pl>
---

diff -urN linux-2.6.16-rc1-mq12/include/linux/serial_reg.h linux-2.6.16=
-rc1-mq123/include/linux/serial_reg.h
--- linux-2.6.16-rc1-mq12/include/linux/serial_reg.h	2006-01-03 04:21:1=
0.000000000 +0100
+++ linux-2.6.16-rc1-mq123/include/linux/serial_reg.h	2006-01-22 00:29:=
50.458495618 +0100
@@ -247,10 +247,10 @@
 #define UART_CTR	0xFF
=20
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
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
