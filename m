From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 3/3] tty: serial: xuartps: Wait for rx and tx reset done status
Date: Thu, 15 Sep 2016 14:45:31 +0530
Message-ID: <1473930931-1034-3-git-send-email-navam@xilinx.com>
References: <1473930931-1034-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473930931-1034-1-git-send-email-navam@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, punnaia@xilinx.com
Cc: Nava kishore Manne <navam@xilinx.com>
List-Id: linux-serial@vger.kernel.org

After issuing the reset, driver is not checking the rx and tx reset
done status. So, modified driver to wait for the reset done status.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v2:
		-Added New patch

 drivers/tty/serial/xilinx_uartps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 527526e..b69dea3 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -694,6 +694,10 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	ctrl_reg |= CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST;
 	writel(ctrl_reg, port->membase + CDNS_UART_CR);
 
+	while (readl(port->membase + CDNS_UART_CR) &
+		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
+		cpu_relax();
+
 	/*
 	 * Clear the RX disable and TX disable bits and then set the TX enable
 	 * bit and RX enable bit to enable the transmitter and receiver.
@@ -797,6 +801,10 @@ static int cdns_uart_startup(struct uart_port *port)
 	writel(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST,
 			port->membase + CDNS_UART_CR);
 
+	while (readl(port->membase + CDNS_UART_CR) &
+		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
+		cpu_relax();
+
 	/*
 	 * Clear the RX disable bit and then set the RX enable bit to enable
 	 * the receiver.
-- 
2.1.2
