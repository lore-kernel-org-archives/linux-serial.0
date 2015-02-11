From: Aurelien BOUIN <a.bouin@gmail.com>
Subject: [PATCH 1/2] serial: imx: Add rs485 support to imx thanks to rs485 functions in serial_core
Date: Wed, 11 Feb 2015 16:30:34 +0100
Message-ID: <1423668635-30838-1-git-send-email-a.bouin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, sascha@saschahauer.de
Cc: festevam@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Aurelien BOUIN <a.bouin@gmail.com>
List-Id: linux-serial@vger.kernel.org

This is a patch to add rs485 support with imx freescale processor
It allows to set the transmit pin used in the structure padding (rs485.padding[0])

Signed-off-by: Aurelien BOUIN <a.bouin@gmail.com>

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4c5e909..a086eef 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -53,6 +53,8 @@
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
 #include <linux/platform_data/dma-imx.h>
+#include <linux/uaccess.h>
+#include <linux/gpio.h>
 
 /* Register definitions */
 #define URXD0 0x0  /* Receiver Register */
@@ -280,6 +282,56 @@ static struct of_device_id imx_uart_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
 
+static inline struct imx_port *to_imx_port(struct uart_port *uart)
+{
+	return container_of(uart, struct imx_port, port);
+}
+
+static void imx_rs485_stop_tx(struct imx_port *imx_uart_port)
+{
+	/*
+	 * Deactivate transmit pin configured in the structure padding
+	 */
+	gpio_set_value(imx_uart_port->port.rs485.padding[0], 0);
+}
+
+static void imx_rs485_start_tx(struct imx_port *imx_uart_port)
+{
+	/*
+	 * Activate transmit pin configured in the structure padding
+	 */
+	gpio_set_value(imx_uart_port->port.rs485.padding[0], 1);
+}
+
+/* Enable or disable the rs485 support */
+static int imx_config_rs485(struct uart_port *port,
+		struct serial_rs485 *rs485conf)
+{
+	port->rs485 = *rs485conf;
+	if (rs485conf->flags & SER_RS485_ENABLED) {
+		int ret;
+
+		dev_dbg(port->dev, "Setting UART /dev/ttymxc%d with the pin 0x%x to RS485\n",
+				port->line, port->rs485.padding[0]);
+		/*
+		 * Set the transmit pin configured in the structure padding
+		 * in GPIO output
+		 */
+		ret = gpio_request(port->rs485.padding[0], "RS485 transmit");
+		if (ret)
+			dev_err(port->dev, "Unable to request the RS485 transmit %d\n",
+					port->rs485.padding[0]);
+		gpio_direction_output(port->rs485.padding[0], 0);
+
+	} else {
+		dev_dbg(port->dev, "Setting UART /dev/ttymxc%d to RS232\n",
+				port->line);
+		if (port->rs485.padding[0])
+			gpio_free(port->rs485.padding[0]);
+	}
+	return 0;
+}
+
 static inline unsigned uts_reg(struct imx_port *sport)
 {
 	return sport->devdata->uts_reg;
@@ -580,6 +632,15 @@ static void imx_start_tx(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
 
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		imx_rs485_start_tx(sport);
+		/*
+		 * Transmit complete interrupt change to receiver mode
+		 */
+		temp = readl(sport->port.membase + UCR4);
+		writel(temp | UCR4_TCEN, sport->port.membase + UCR4);
+	}
+
 	if (USE_IRDA(sport)) {
 		/* half duplex in IrDA mode; have to disable receive mode */
 		temp = readl(sport->port.membase + UCR4);
@@ -693,8 +754,10 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
 					goto out;
 				continue;
 			}
-
-			rx &= sport->port.read_status_mask;
+			/*
+			 * Preserve characters with parity or framing errors
+			 */
+			rx &= sport->port.read_status_mask | 0xFF;
 
 			if (rx & URXD_BRK)
 				flg = TTY_BREAK;
@@ -747,8 +810,30 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int sts;
 	unsigned int sts2;
+	unsigned int cr1, cr2, cr3, cr4;
 
 	sts = readl(sport->port.membase + USR1);
+	sts2 = readl(sport->port.membase + USR2);
+	cr1 = readl(sport->port.membase + UCR1);
+	cr2 = readl(sport->port.membase + UCR2);
+	cr3 = readl(sport->port.membase + UCR3);
+	cr4 = readl(sport->port.membase + UCR4);
+
+	if (sport->port.rs485.flags & SER_RS485_ENABLED)	{
+		/*
+		 * Check if the transmit is complete
+		 */
+		if ((cr4 & UCR4_TCEN) && (sts2 & USR2_TXDC)) {
+			unsigned long temp;
+
+			imx_rs485_stop_tx(sport);
+			/*
+			 * Transmit complete interrupt disabled
+			 */
+			temp = readl(sport->port.membase + UCR4);
+			writel(temp & ~UCR4_TCEN, sport->port.membase + UCR4);
+		}
+	}
 
 	if (sts & USR1_RRDY) {
 		if (sport->dma_is_enabled)
@@ -1072,6 +1157,17 @@ static int imx_startup(struct uart_port *port)
 	struct imx_port *sport = (struct imx_port *)port;
 	int retval, i;
 	unsigned long flags, temp;
+	int reset_time = 100;
+
+	/* reset fifo's and state machines to be sure
+	 * to start the UART in correct conditions */
+	temp = readl(sport->port.membase + UCR2);
+	temp &= ~UCR2_SRST;
+	writel(temp, sport->port.membase + UCR2);
+	while (!(readl(sport->port.membase + UCR2) & UCR2_SRST) &&
+	    (--reset_time > 0)) {
+		udelay(1);
+	}
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
@@ -1225,6 +1321,14 @@ static void imx_shutdown(struct uart_port *port)
 
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+	/*
+	 * Deactivate RS485 mode
+	 */
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		imx_rs485_stop_tx(sport);
+		port->rs485.flags &= ~SER_RS485_ENABLED;
+		imx_config_rs485(port, &port->rs485);
+	}
 
 	clk_disable_unprepare(sport->clk_per);
 	clk_disable_unprepare(sport->clk_ipg);
@@ -1318,8 +1422,10 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Characters to ignore
 	 */
 	sport->port.ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		sport->port.ignore_status_mask |= URXD_PRERR;
+	if (termios->c_iflag & IGNPAR) {
+		/* Ignore Framing errors when IGNPAR is set */
+		sport->port.ignore_status_mask |= URXD_PRERR | URXD_FRMERR;
+	}
 	if (termios->c_iflag & IGNBRK) {
 		sport->port.ignore_status_mask |= URXD_BRK;
 		/*
@@ -1560,8 +1666,8 @@ static void
 imx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct imx_port *sport = imx_ports[co->index];
-	struct imx_port_ucrs old_ucr;
 	unsigned int ucr1;
+	unsigned int old_ucr1, old_ucr2;
 	unsigned long flags = 0;
 	int locked = 1;
 	int retval;
@@ -1583,10 +1689,10 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 		spin_lock_irqsave(&sport->port.lock, flags);
 
 	/*
-	 *	First, save UCR1/2/3 and then disable interrupts
+	 *	First, save UCR1/2 and then disable interrupts
 	 */
-	imx_port_ucrs_save(&sport->port, &old_ucr);
-	ucr1 = old_ucr.ucr1;
+	ucr1 = old_ucr1 = readl(sport->port.membase + UCR1);
+	old_ucr2 = readl(sport->port.membase + UCR2);
 
 	if (is_imx1_uart(sport))
 		ucr1 |= IMX1_UCR1_UARTCLKEN;
@@ -1595,17 +1701,18 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 
 	writel(ucr1, sport->port.membase + UCR1);
 
-	writel(old_ucr.ucr2 | UCR2_TXEN, sport->port.membase + UCR2);
+	writel(old_ucr2 | UCR2_TXEN, sport->port.membase + UCR2);
 
 	uart_console_write(&sport->port, s, count, imx_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-	 *	and restore UCR1/2/3
+	 *	and restore UCR1/2
 	 */
 	while (!(readl(sport->port.membase + USR2) & USR2_TXDC));
 
-	imx_port_ucrs_restore(&sport->port, &old_ucr);
+	writel(old_ucr1, sport->port.membase + UCR1);
+	writel(old_ucr2, sport->port.membase + UCR2);
 
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
@@ -1873,6 +1980,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.type = PORT_IMX,
 	sport->port.iotype = UPIO_MEM;
 	sport->port.irq = platform_get_irq(pdev, 0);
+	sport->port.rs485_config = imx_config_rs485;
 	sport->rxirq = platform_get_irq(pdev, 0);
 	sport->txirq = platform_get_irq(pdev, 1);
 	sport->rtsirq = platform_get_irq(pdev, 2);
-- 
1.9.1
