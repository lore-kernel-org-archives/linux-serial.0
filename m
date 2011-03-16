From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 59/76] pch_uart: fix auto flow control miss-setting issue
Date: Wed, 16 Mar 2011 14:12:29 -0700
Message-ID: <1300309966-5745-59-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33007 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab1CPVPC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:02 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Currently, auto-flow control setting processing is not set correctly.
This patch fixes the issue.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 1898861..0c95051 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -218,6 +218,7 @@ struct eg20t_port {
 	struct pch_uart_buffer rxbuf;
 	unsigned int dmsr;
 	unsigned int fcr;
+	unsigned int mcr;
 	unsigned int use_dma;
 	unsigned int use_dma_flag;
 	struct dma_async_tx_descriptor	*desc_tx;
@@ -1007,7 +1008,6 @@ static unsigned int pch_uart_get_mctrl(struct uart_port *port)
 static void pch_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	u32 mcr = 0;
-	unsigned int dat;
 	struct eg20t_port *priv = container_of(port, struct eg20t_port, port);
 
 	if (mctrl & TIOCM_DTR)
@@ -1017,11 +1017,11 @@ static void pch_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (mctrl & TIOCM_LOOP)
 		mcr |= UART_MCR_LOOP;
 
-	if (mctrl) {
-		dat = pch_uart_get_mctrl(port);
-		dat |= mcr;
-		iowrite8(dat, priv->membase + UART_MCR);
-	}
+	if (priv->mcr & UART_MCR_AFE)
+		mcr |= UART_MCR_AFE;
+
+	if (mctrl)
+		iowrite8(mcr, priv->membase + UART_MCR);
 }
 
 static void pch_uart_stop_tx(struct uart_port *port)
@@ -1215,6 +1215,13 @@ static void pch_uart_set_termios(struct uart_port *port,
 	} else {
 		parity = PCH_UART_HAL_PARITY_NONE;
 	}
+
+	/* Only UART0 has auto hardware flow function */
+	if ((termios->c_cflag & CRTSCTS) && (priv->fifo_size == 256))
+		priv->mcr |= UART_MCR_AFE;
+	else
+		priv->mcr &= ~UART_MCR_AFE;
+
 	termios->c_cflag &= ~CMSPAR; /* Mark/Space parity is not supported */
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
-- 
1.7.4.1

