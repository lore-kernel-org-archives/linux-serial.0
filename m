From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH 4/4] serial: 8250_dw: use serial_in() and not readl()
Date: Wed, 22 Jul 2015 12:34:59 +0300
Message-ID: <1437557699-25722-5-git-send-email-noamc@ezchip.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437557699-25722-2-git-send-email-noamc@ezchip.com>
 <1437557699-25722-3-git-send-email-noamc@ezchip.com>
 <1437557699-25722-4-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437557699-25722-4-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, gregkh@linuxfoundation.org, jslaby@suse.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

This is now matches device endianness.

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 drivers/tty/serial/8250/8250_dw.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 620f983..a64197c 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -291,7 +291,9 @@ static bool dw8250_dma_filter(struct dma_chan *chan, void *param)
 static void dw8250_setup_port(struct uart_8250_port *up)
 {
 	struct uart_port	*p = &up->port;
-	u32			reg = readl(p->membase + DW_UART_UCV);
+	u32			reg = (p->iotype == UPIO_MEM32BE) ?
+					ioread32be(p->membase + DW_UART_UCV) :
+					readl(p->membase + DW_UART_UCV);
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -303,7 +305,9 @@ static void dw8250_setup_port(struct uart_8250_port *up)
 	dev_dbg_ratelimited(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
-	reg = readl(p->membase + DW_UART_CPR);
+	reg = (p->iotype == UPIO_MEM32BE) ?
+		ioread32be(p->membase + DW_UART_CPR) :
+		readl(p->membase + DW_UART_CPR);
 	if (!reg)
 		return;
 
-- 
1.7.1
