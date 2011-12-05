From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 2/2] serial: bfin-uart: remove redundant CTS check for hardware CTS control.
Date: Mon, 5 Dec 2011 18:13:11 +0800
Message-ID: <1323079991-4855-2-git-send-email-sonic.adi@gmail.com>
References: <1323079991-4855-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:57312 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1LEKUR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Dec 2011 05:20:17 -0500
In-Reply-To: <1323079991-4855-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Blackfin hardware CTS control generate interrupt for both CTS on and off.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 2afd307..cf2d927 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -119,12 +119,10 @@ static irqreturn_t bfin_serial_mctrl_cts_int(int irq, void *dev_id)
 	unsigned int status;
 
 	status = bfin_serial_get_mctrl(&uart->port);
-	uart_handle_cts_change(&uart->port, status & TIOCM_CTS);
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	uart->scts = 1;
 	UART_CLEAR_SCTS(uart);
-	UART_CLEAR_IER(uart, EDSSI);
 #endif
+	uart_handle_cts_change(&uart->port, status & TIOCM_CTS);
 
 	return IRQ_HANDLED;
 }
@@ -175,13 +173,6 @@ static void bfin_serial_start_tx(struct uart_port *port)
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
 	struct tty_struct *tty = uart->port.state->port.tty;
 
-#ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	if (uart->scts && !(bfin_serial_get_mctrl(&uart->port) & TIOCM_CTS)) {
-		uart->scts = 0;
-		uart_handle_cts_change(&uart->port, uart->scts);
-	}
-#endif
-
 	/*
 	 * To avoid losting RX interrupt, we reset IR function
 	 * before sending data.
@@ -380,12 +371,6 @@ static irqreturn_t bfin_serial_tx_int(int irq, void *dev_id)
 {
 	struct bfin_serial_port *uart = dev_id;
 
-#ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	if (uart->scts && !(bfin_serial_get_mctrl(&uart->port) & TIOCM_CTS)) {
-		uart->scts = 0;
-		uart_handle_cts_change(&uart->port, uart->scts);
-	}
-#endif
 	spin_lock(&uart->port.lock);
 	if (UART_GET_LSR(uart) & THRE)
 		bfin_serial_tx_chars(uart);
@@ -531,13 +516,6 @@ static irqreturn_t bfin_serial_dma_tx_int(int irq, void *dev_id)
 	struct bfin_serial_port *uart = dev_id;
 	struct circ_buf *xmit = &uart->port.state->xmit;
 
-#ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
-	if (uart->scts && !(bfin_serial_get_mctrl(&uart->port)&TIOCM_CTS)) {
-		uart->scts = 0;
-		uart_handle_cts_change(&uart->port, uart->scts);
-	}
-#endif
-
 	spin_lock(&uart->port.lock);
 	if (!(get_dma_curr_irqstat(uart->tx_dma_channel)&DMA_RUN)) {
 		disable_dma(uart->tx_dma_channel);
-- 
1.7.0.4


