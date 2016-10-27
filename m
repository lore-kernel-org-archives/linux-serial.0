From: Ed Blake <ed.blake@imgtec.com>
Subject: [PATCH 2/2] serial: 8250_dw: Add support for IrDA SIR mode
Date: Thu, 27 Oct 2016 17:38:06 +0100
Message-ID: <1477586286-15748-1-git-send-email-ed.blake@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com, heikki.krogerus@linux.intel.com, noamc@ezchip.com, annie.wang@amd.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, james.hartley@imgtec.com, Ed Blake <ed.blake@imgtec.com>
List-Id: linux-serial@vger.kernel.org

Add a set_ldisc function to enable/disable IrDA SIR mode according to
the new line discipline.

Signed-off-by: Ed Blake <ed.blake@imgtec.com>
---
 drivers/tty/serial/8250/8250_dw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 459d726..7dd5369 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -53,6 +53,8 @@
 /* Helper for fifo size calculation */
 #define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
 
+/* DesignWare specific register fields */
+#define DW_UART_MCR_SIRE		BIT(6)
 
 struct dw8250_data {
 	u8			usr_reg;
@@ -254,6 +256,20 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	serial8250_do_set_termios(p, termios, old);
 }
 
+static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
+{
+	unsigned int mcr = p->serial_in(p, UART_MCR);
+
+	if (termios->c_line == N_IRDA)
+		mcr |= DW_UART_MCR_SIRE;
+	else
+		mcr &= ~DW_UART_MCR_SIRE;
+
+	p->serial_out(p, UART_MCR, mcr);
+
+	serial8250_do_set_ldisc(p, termios);
+}
+
 /*
  * dw8250_fallback_dma_filter will prevent the UART from getting just any free
  * channel on platforms that have DMA engines, but don't have any channels
@@ -392,6 +408,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->iotype	= UPIO_MEM;
 	p->serial_in	= dw8250_serial_in;
 	p->serial_out	= dw8250_serial_out;
+	p->set_ldisc	= dw8250_set_ldisc;
 
 	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!p->membase)
-- 
1.9.1
