From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: [PATCH] 8250: Add UPF_NO_EFR flag
Date: Wed, 24 Sep 2008 16:05:51 +0300
Message-ID: <20080924130551.14866.87310.stgit@Programuotojas.82-135-208-232.ip.zebra.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailhub.zebra.lt ([212.59.31.77]:1622 "EHLO mh.zebra.lt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbYIXNeY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Sep 2008 09:34:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mh.zebra.lt (Postfix) with ESMTP id F0F4823536B
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2008 16:05:44 +0300 (EEST)
Received: from mh.zebra.lt ([127.0.0.1])
	by localhost (ispmailfe124.internal.zebra.lt [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvYyQbMRiU1W for <linux-serial@vger.kernel.org>;
	Wed, 24 Sep 2008 16:05:44 +0300 (EEST)
Received: from mailhub.zebra.lt (unknown [192.168.3.105])
	by mh.zebra.lt (Postfix) with ESMTP id C36D123531F
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2008 16:05:44 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by mailhub.zebra.lt (Postfix) with ESMTP id C538F59DBA
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2008 16:05:52 +0300 (EEST)
Received: from mailhub.zebra.lt ([127.0.0.1])
	by localhost (ispmailfe105.internal.zebra.lt [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ad6p5pPFH4ju for <linux-serial@vger.kernel.org>;
	Wed, 24 Sep 2008 16:05:52 +0300 (EEST)
Received: from Programuotojas.82-135-208-232.ip.zebra.lt (82-135-208-232.static.zebra.lt [82.135.208.232])
	by mailhub.zebra.lt (Postfix) with ESMTP id 77A8A59DB4
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2008 16:05:52 +0300 (EEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Gemini SoC UART has aditional prescaler register at the same
address as EFR accessible only when DLAB=1.
We need this flag for autodetection to work correctly.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
---

 drivers/serial/8250.c       |   12 +++++++++---
 include/linux/serial_core.h |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)


diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 9ccc563..0ca1f9d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -843,6 +843,9 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
 
+	if (up->port.flags & UPF_NO_EFR)
+		goto skip_efr;
+
 	/*
 	 * Check for presence of the EFR when DLAB is set.
 	 * Only ST16C650V1 UARTs pass this test.
@@ -872,6 +875,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 		return;
 	}
 
+skip_efr:
 	/*
 	 * Check for a National Semiconductor SuperIO chip.
 	 * Attempt to switch to bank 2, read the value of the LOOP bit
@@ -1076,9 +1080,11 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	 * We also initialise the EFR (if any) to zero for later.  The
 	 * EFR occupies the same register location as the FCR and IIR.
 	 */
-	serial_outp(up, UART_LCR, 0xBF);
-	serial_outp(up, UART_EFR, 0);
-	serial_outp(up, UART_LCR, 0);
+	if (!(up->port.flags & UPF_NO_EFR)) {
+		serial_outp(up, UART_LCR, 0xBF);
+		serial_outp(up, UART_EFR, 0);
+		serial_outp(up, UART_LCR, 0);
+	}
 
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 	scratch = serial_in(up, UART_IIR) >> 6;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3b2f6c0..7a87ba6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -285,6 +285,7 @@ struct uart_port {
 #define UPF_HARDPPS_CD		((__force upf_t) (1 << 11))
 #define UPF_LOW_LATENCY		((__force upf_t) (1 << 13))
 #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
+#define UPF_NO_EFR		((__force upf_t) (1 << 15))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))

