From: Ed Blake <ed.blake@imgtec.com>
Subject: [PATCH v2 2/2] serial: 8250_dw: Add support for IrDA SIR mode
Date: Fri, 28 Oct 2016 18:04:34 +0100
Message-ID: <1477674274-16283-3-git-send-email-ed.blake@imgtec.com>
References: <1477674274-16283-1-git-send-email-ed.blake@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477674274-16283-1-git-send-email-ed.blake@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com, heikki.krogerus@linux.intel.com, noamc@ezchip.com, annie.wang@amd.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, peter@hurleysoftware.com, alexander.sverdlin@nokia.com, yegorslists@googlemail.com, matwey@sai.msu.ru, yamada.masahiro@socionext.com, tthayer@opensource.altera.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, james.hartley@imgtec.com, Ed Blake <ed.blake@imgtec.com>
List-Id: linux-serial@vger.kernel.org

Add a set_ldisc function to enable/disable IrDA SIR mode according to
the new line discipline, if IrDA SIR mode is supported by the hardware
configuration.

Signed-off-by: Ed Blake <ed.blake@imgtec.com>
---
 drivers/tty/serial/8250/8250_dw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 459d726..d6d41d6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -53,6 +53,8 @@
 /* Helper for fifo size calculation */
 #define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
 
+/* DesignWare specific register fields */
+#define DW_UART_MCR_SIRE		BIT(6)
 
 struct dw8250_data {
 	u8			usr_reg;
@@ -66,6 +68,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		sir_mode_supported:1;
 };
 
 static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
@@ -254,6 +257,22 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	serial8250_do_set_termios(p, termios, old);
 }
 
+static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
+{
+	struct dw8250_data *data = p->private_data;
+	unsigned int mcr = p->serial_in(p, UART_MCR);
+
+	if (data->sir_mode_supported) {
+		if (termios->c_line == N_IRDA)
+			mcr |= DW_UART_MCR_SIRE;
+		else
+			mcr &= ~DW_UART_MCR_SIRE;
+
+		p->serial_out(p, UART_MCR, mcr);
+	}
+	serial8250_do_set_ldisc(p, termios);
+}
+
 /*
  * dw8250_fallback_dma_filter will prevent the UART from getting just any free
  * channel on platforms that have DMA engines, but don't have any channels
@@ -324,6 +343,7 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 static void dw8250_setup_port(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
+	struct dw8250_data *data = p->private_data;
 	u32 reg;
 
 	/*
@@ -357,6 +377,9 @@ static void dw8250_setup_port(struct uart_port *p)
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
 		up->capabilities |= UART_CAP_AFE;
+
+	if (reg & DW_UART_CPR_SIR_MODE)
+		data->sir_mode_supported = true;
 }
 
 static int dw8250_probe(struct platform_device *pdev)
@@ -392,6 +415,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->iotype	= UPIO_MEM;
 	p->serial_in	= dw8250_serial_in;
 	p->serial_out	= dw8250_serial_out;
+	p->set_ldisc	= dw8250_set_ldisc;
 
 	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!p->membase)
-- 
1.9.1
