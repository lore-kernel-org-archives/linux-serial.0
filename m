From: Noam Camus <noamc@ezchip.com>
Subject: [v4 2/2] serial: 8250_dw: dw8250_setup_port() use endianness aware read.
Date: Fri, 21 Aug 2015 13:33:43 +0300
Message-ID: <1440153223-25712-3-git-send-email-noamc@ezchip.com>
References: <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1440153223-25712-1-git-send-email-noamc@ezchip.com>
 <1440153223-25712-2-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440153223-25712-2-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

readl() for UCV and CPR will not work for port type UPIO_MEM32BE.
Instead we use the serial_in32() accessor which is initialized
properly according to endianness.

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 drivers/tty/serial/8250/8250_dw.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f479433..62f766a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -310,7 +310,8 @@ static bool dw8250_dma_filter(struct dma_chan *chan, void *param)
 static void dw8250_setup_port(struct uart_8250_port *up)
 {
 	struct uart_port	*p = &up->port;
-	u32			reg = readl(p->membase + DW_UART_UCV);
+	struct dw8250_data	*d = p->private_data;
+	u32			reg = d->serial_in(p->membase + DW_UART_UCV);
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -322,7 +323,7 @@ static void dw8250_setup_port(struct uart_8250_port *up)
 	dev_dbg_ratelimited(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
-	reg = readl(p->membase + DW_UART_CPR);
+	reg = d->serial_in(p->membase + DW_UART_CPR);
 	if (!reg)
 		return;
 
-- 
1.7.1
