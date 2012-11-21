From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 1/2 - Resubmit] tty/8250: Add sleep capability to XR17D15X ports
Date: Wed, 21 Nov 2012 09:39:07 -0600
Message-ID: <CAJp1Oe7w__kcpKy8t8zKkM+ZXD3Dbq338pKwzim_c0iwf-uf-g@mail.gmail.com>
References: <CAJp1Oe4UiEpt4fXMD5X=bPR8q4-y3RsLGgFa3MGxbvvDauiwbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63158 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab2KUPj3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 10:39:29 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1747273vbb.19
        for <linux-serial@vger.kernel.org>; Wed, 21 Nov 2012 07:39:28 -0800 (PST)
In-Reply-To: <CAJp1Oe4UiEpt4fXMD5X=bPR8q4-y3RsLGgFa3MGxbvvDauiwbg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>

Add sleep capability to XR17D15X ports

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
[PATCH 1/2] tty/8250: Add sleep capability to XR17D15X ports
Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23

This depends on my previous patch submission:
[PATCH v3] Add support for new devices: Exar's XR17V35x family of
multi-port PCIe UARTs

 drivers/tty/serial/8250/8250.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index df7f433..44be636 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -280,7 +280,8 @@ static const struct serial8250_config uart_config[] = {
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR |
+				  UART_CAP_SLEEP,
 	},
 	[PORT_XR17V35X] = {
 		.name		= "XR17V35X",
@@ -591,7 +592,8 @@ static void serial8250_set_sleep(struct
uart_8250_port *p, int sleep)
 	 * offset but the UART channel may only write to the corresponding
 	 * bit.
 	 */
-	if (p->port.type == PORT_XR17V35X) {
+	if ((p->port.type == PORT_XR17V35X) ||
+	   (p->port.type == PORT_XR17D15X)) {
 		serial_out(p, UART_EXAR_SLEEP, 0xff);
 		return;
 	}
@@ -1056,8 +1058,12 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * Exar uarts have EFR in a weird location
 	 */
 	if (up->port.flags & UPF_EXAR_EFR) {
+		DEBUG_AUTOCONF("Exar XR17D15x ");
 		up->port.type = PORT_XR17D15X;
-		up->capabilities |= UART_CAP_AFE | UART_CAP_EFR;
+		up->capabilities |= UART_CAP_AFE | UART_CAP_EFR |
+				    UART_CAP_SLEEP;
+
+		return;
 	}

 	/*
-- 
1.7.2.5
