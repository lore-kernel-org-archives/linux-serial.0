From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] serial: sirf: add support for new SiRFmarco SMP SoC
Date: Tue, 25 Dec 2012 17:32:04 +0800
Message-ID: <1356427924-7785-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:52466 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab2LYJdC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Dec 2012 04:33:02 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

CSR SiRFmarco's UART IP is same with SiRFprimaII except that
it has two more uart ports.
this patch makes the old driver support new SiRFmarco as well:
1. add .compatible = "sirf,marco-uart" to OF match table
2. add two ports in the port table
3. take spin_lock in isr to avoid the conflict of threads opening
uart on CPU1 and isr running on CPU0.
For 3, we did see some problems on SiRFmarco as SiRFmarco is a
SMP SoC but the old SiRFprimaII is UP.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |   19 +++++++++++++++++++
 drivers/tty/serial/sirfsoc_uart.h |    2 +-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 5da5cb9..142217c 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -75,6 +75,20 @@ static struct sirfsoc_uart_port sirfsoc_uart_ports[SIRFSOC_UART_NR] = {
 			.line		= 2,
 		},
 	},
+	[3] = {
+		.port = {
+			.iotype		= UPIO_MEM,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 3,
+		},
+	},
+	[4] = {
+		.port = {
+			.iotype		= UPIO_MEM,
+			.flags		= UPF_BOOT_AUTOCONF,
+			.line		= 4,
+		},
+	},
 };
 
 static inline struct sirfsoc_uart_port *to_sirfport(struct uart_port *port)
@@ -245,6 +259,7 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 	struct uart_port *port = &sirfport->port;
 	struct uart_state *state = port->state;
 	struct circ_buf *xmit = &port->state->xmit;
+	spin_lock(&port->lock);
 	intr_status = rd_regl(port, SIRFUART_INT_STATUS);
 	wr_regl(port, SIRFUART_INT_STATUS, intr_status);
 	intr_status &= rd_regl(port, SIRFUART_INT_EN);
@@ -254,6 +269,7 @@ static irqreturn_t sirfsoc_uart_isr(int irq, void *dev_id)
 				goto recv_char;
 			uart_insert_char(port, intr_status,
 					SIRFUART_RX_OFLOW, 0, TTY_BREAK);
+			spin_unlock(&port->lock);
 			return IRQ_HANDLED;
 		}
 		if (intr_status & SIRFUART_RX_OFLOW)
@@ -286,6 +302,7 @@ recv_char:
 		sirfsoc_uart_pio_rx_chars(port, SIRFSOC_UART_IO_RX_MAX_CNT);
 	if (intr_status & SIRFUART_TX_INT_EN) {
 		if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+			spin_unlock(&port->lock);
 			return IRQ_HANDLED;
 		} else {
 			sirfsoc_uart_pio_tx_chars(sirfport,
@@ -296,6 +313,7 @@ recv_char:
 				sirfsoc_uart_stop_tx(port);
 		}
 	}
+	spin_unlock(&port->lock);
 	return IRQ_HANDLED;
 }
 
@@ -729,6 +747,7 @@ static int sirfsoc_uart_resume(struct platform_device *pdev)
 
 static struct of_device_id sirfsoc_uart_ids[] = {
 	{ .compatible = "sirf,prima2-uart", },
+	{ .compatible = "sirf,marco-uart", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sirfsoc_serial_of_match);
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 6e207fd..6431640 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -139,7 +139,7 @@
 #define SIRFSOC_UART_MINOR			0
 #define SIRFUART_PORT_NAME			"sirfsoc-uart"
 #define SIRFUART_MAP_SIZE			0x200
-#define SIRFSOC_UART_NR				3
+#define SIRFSOC_UART_NR				5
 #define SIRFSOC_PORT_TYPE			0xa5
 
 /* Baud Rate Calculation */
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
