From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] serial: amba-pl011: Use __releases/__acquires annotations
Date: Fri,  9 Aug 2013 17:58:51 -0300
Message-ID: <1376081931-19491-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:41992 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031117Ab3HIU7Z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Aug 2013 16:59:25 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so1606848yhn.26
        for <linux-serial@vger.kernel.org>; Fri, 09 Aug 2013 13:59:25 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux@arm.linux.org.uk, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following sparse warnings:

drivers/tty/serial/amba-pl011.c:687:20: warning: context imbalance in 'pl011_dma_flush_buffer' - unexpected unlock
drivers/tty/serial/amba-pl011.c:1200:13: warning: context imbalance in 'pl011_rx_chars' - unexpected unlock

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/amba-pl011.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index eb38fb8..aaa2286 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -677,6 +677,8 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
  * Locking: called with port lock held and IRQs disabled.
  */
 static void pl011_dma_flush_buffer(struct uart_port *port)
+__releases(&uap->port.lock)
+__acquires(&uap->port.lock)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 
@@ -1198,6 +1200,8 @@ static void pl011_enable_ms(struct uart_port *port)
 }
 
 static void pl011_rx_chars(struct uart_amba_port *uap)
+__releases(&uap->port.lock)
+__acquires(&uap->port.lock)
 {
 	pl011_fifo_to_tty(uap);
 
-- 
1.8.1.2

