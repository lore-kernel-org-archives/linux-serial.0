From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/3] serial: max310x: Driver rework
Date: Sat, 29 Jun 2013 09:24:17 +0400
Message-ID: <1372483459-11836-2-git-send-email-shc_work@mail.ru>
References: <1372483459-11836-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:41414 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3F2FZH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 29 Jun 2013 01:25:07 -0400
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 6669CD6B8511
	for <linux-serial@vger.kernel.org>; Sat, 29 Jun 2013 09:25:03 +0400 (MSK)
In-Reply-To: <1372483459-11836-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch rework max310x driver.
Major changes have been made:
- Prepare driver to support ICs with more than one UART.
- Prepare driver to support work with I2C-bus.
The patch changes almost every function and can not be divided into parts.
---
 drivers/tty/serial/Kconfig            |   4 +-
 drivers/tty/serial/max310x.c          | 918 +++++++++++++++++-----------------
 include/linux/platform_data/max310x.h |   5 +-
 3 files changed, 454 insertions(+), 473 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5e3d689..25772c1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -291,9 +291,9 @@ config SERIAL_MAX3100
 
 config SERIAL_MAX310X
 	bool "MAX310X support"
-	depends on SPI
+	depends on SPI_MASTER
 	select SERIAL_CORE
-	select REGMAP_SPI if SPI
+	select REGMAP_SPI if SPI_MASTER
 	default n
 	help
 	  This selects support for an advanced UART from Maxim (Dallas).
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8941e64..4620289 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1,7 +1,7 @@
 /*
  *  Maxim (Dallas) MAX3107/8 serial driver
  *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *  Copyright (C) 2012-2013 Alexander Shiyan <shc_work@mail.ru>
  *
  *  Based on max3100.c, by Christian Pellegrin <chripell@evolware.org>
  *  Based on max3110.c, by Feng Tang <feng.tang@intel.com>
@@ -17,7 +17,9 @@
 /* TODO: MAX14830 support (Quad) */
 
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/bitops.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
@@ -25,8 +27,10 @@
 #include <linux/regmap.h>
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
+
 #include <linux/platform_data/max310x.h>
 
+#define MAX310X_NAME			"max310x"
 #define MAX310X_MAJOR			204
 #define MAX310X_MINOR			209
 
@@ -37,7 +41,8 @@
 #define MAX310X_IRQSTS_REG		(0x02) /* IRQ status */
 #define MAX310X_LSR_IRQEN_REG		(0x03) /* LSR IRQ enable */
 #define MAX310X_LSR_IRQSTS_REG		(0x04) /* LSR IRQ status */
-#define MAX310X_SPCHR_IRQEN_REG		(0x05) /* Special char IRQ enable */
+#define MAX310X_REG_05			(0x05)
+#define MAX310X_SPCHR_IRQEN_REG		MAX310X_REG_05 /* Special char IRQ en */
 #define MAX310X_SPCHR_IRQSTS_REG	(0x06) /* Special char IRQ status */
 #define MAX310X_STS_IRQEN_REG		(0x07) /* Status IRQ enable */
 #define MAX310X_STS_IRQSTS_REG		(0x08) /* Status IRQ status */
@@ -63,8 +68,15 @@
 #define MAX310X_BRGDIVLSB_REG		(0x1c) /* Baud rate divisor LSB */
 #define MAX310X_BRGDIVMSB_REG		(0x1d) /* Baud rate divisor MSB */
 #define MAX310X_CLKSRC_REG		(0x1e) /* Clock source */
-/* Only present in MAX3107 */
-#define MAX3107_REVID_REG		(0x1f) /* Revision identification */
+#define MAX310X_REG_1F			(0x1f)
+
+#define MAX310X_REVID_REG		MAX310X_REG_1F /* Revision ID */
+
+#define MAX310X_GLOBALIRQ_REG		MAX310X_REG_1F /* Global IRQ (RO) */
+#define MAX310X_GLOBALCMD_REG		MAX310X_REG_1F /* Global Command (WO) */
+
+/* Extended registers */
+#define MAX310X_REVID_EXTREG		MAX310X_REG_05 /* Revision ID */
 
 /* IRQ register bits */
 #define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
@@ -246,58 +258,139 @@
 #define MAX310X_CLKSRC_EXTCLK_BIT	(1 << 4) /* External clock enable */
 #define MAX310X_CLKSRC_CLK2RTS_BIT	(1 << 7) /* Baud clk to RTS pin */
 
+/* Global commands */
+#define MAX310X_EXTREG_ENBL		(0xce)
+#define MAX310X_EXTREG_DSBL		(0xcd)
+
 /* Misc definitions */
 #define MAX310X_FIFO_SIZE		(128)
+#define MAX310x_REV_MASK		(0xfc)
 
 /* MAX3107 specific */
 #define MAX3107_REV_ID			(0xa0)
-#define MAX3107_REV_MASK		(0xfe)
-
-/* IRQ status bits definitions */
-#define MAX310X_IRQ_TX			(MAX310X_IRQ_TXFIFO_BIT | \
-					 MAX310X_IRQ_TXEMPTY_BIT)
-#define MAX310X_IRQ_RX			(MAX310X_IRQ_RXFIFO_BIT | \
-					 MAX310X_IRQ_RXEMPTY_BIT)
-
-/* Supported chip types */
-enum {
-	MAX310X_TYPE_MAX3107	= 3107,
-	MAX310X_TYPE_MAX3108	= 3108,
+
+struct max310x_devtype {
+	char	name[9];
+	int	nr;
+	int	(*detect)(struct device *);
+	void	(*power)(struct uart_port *, int);
 };
 
-struct max310x_port {
-	struct uart_driver	uart;
+struct max310x_one {
 	struct uart_port	port;
+	struct work_struct	tx_work;
+};
 
-	const char		*name;
-	int			uartclk;
-
-	unsigned int		nr_gpio;
+struct max310x_port {
+	struct uart_driver	uart;
+	struct max310x_devtype	*devtype;
+	struct regmap		*regmap;
+	struct regmap_config	regcfg;
+	struct mutex		mutex;
+	struct max310x_pdata	*pdata;
+	int			gpio_used;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gpio;
 #endif
+	struct max310x_one	p[0];
+};
 
-	struct regmap		*regmap;
-	struct regmap_config	regcfg;
+static u8 max310x_port_read(struct uart_port *port, u8 reg)
+{
+	struct max310x_port *s = dev_get_drvdata(port->dev);
+	unsigned int val = 0;
 
-	struct workqueue_struct	*wq;
-	struct work_struct	tx_work;
+	regmap_read(s->regmap, port->iobase + reg, &val);
 
-	struct mutex		max310x_mutex;
+	return val;
+}
 
-	struct max310x_pdata	*pdata;
+static void max310x_port_write(struct uart_port *port, u8 reg, u8 val)
+{
+	struct max310x_port *s = dev_get_drvdata(port->dev);
+
+	regmap_write(s->regmap, port->iobase + reg, val);
+}
+
+static void max310x_port_update(struct uart_port *port, u8 reg, u8 mask, u8 val)
+{
+	struct max310x_port *s = dev_get_drvdata(port->dev);
+
+	regmap_update_bits(s->regmap, port->iobase + reg, mask, val);
+}
+
+static int max3107_detect(struct device *dev)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_read(s->regmap, MAX310X_REVID_REG, &val);
+	if (ret)
+		return ret;
+
+	if (((val & MAX310x_REV_MASK) != MAX3107_REV_ID)) {
+		dev_err(dev,
+			"%s ID 0x%02x does not match\n", s->devtype->name, val);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int max3108_detect(struct device *dev)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+	unsigned int val = 0;
+	int ret;
+
+	/* MAX3108 have not REV ID register, we just check default value
+	 * from clocksource register to make sure everything works.
+	 */
+	ret = regmap_read(s->regmap, MAX310X_CLKSRC_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val != (MAX310X_CLKSRC_EXTCLK_BIT | MAX310X_CLKSRC_PLLBYP_BIT)) {
+		dev_err(dev, "%s not present\n", s->devtype->name);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void max310x_power(struct uart_port *port, int on)
+{
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_FORCESLEEP_BIT,
+			    on ? 0 : MAX310X_MODE1_FORCESLEEP_BIT);
+	if (on)
+		msleep(50);
+}
+
+static const struct max310x_devtype max3107_devtype = {
+	.name	= "MAX3107",
+	.nr	= 1,
+	.detect	= max3107_detect,
+	.power	= max310x_power,
 };
 
-static bool max3107_8_reg_writeable(struct device *dev, unsigned int reg)
+static const struct max310x_devtype max3108_devtype = {
+	.name	= "MAX3108",
+	.nr	= 1,
+	.detect	= max3108_detect,
+	.power	= max310x_power,
+};
+
+static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
+	switch (reg & 0x1f) {
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
 	case MAX310X_STS_IRQSTS_REG:
 	case MAX310X_TXFIFOLVL_REG:
 	case MAX310X_RXFIFOLVL_REG:
-	case MAX3107_REVID_REG: /* Only available on MAX3107 */
 		return false;
 	default:
 		break;
@@ -308,7 +401,7 @@ static bool max3107_8_reg_writeable(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
+	switch (reg & 0x1f) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_LSR_IRQSTS_REG:
@@ -317,6 +410,9 @@ static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 	case MAX310X_TXFIFOLVL_REG:
 	case MAX310X_RXFIFOLVL_REG:
 	case MAX310X_GPIODATA_REG:
+	case MAX310X_BRGDIVLSB_REG:
+	case MAX310X_REG_05:
+	case MAX310X_REG_1F:
 		return true;
 	default:
 		break;
@@ -327,7 +423,7 @@ static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
 
 static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
+	switch (reg & 0x1f) {
 	case MAX310X_RHR_REG:
 	case MAX310X_IRQSTS_REG:
 	case MAX310X_SPCHR_IRQSTS_REG:
@@ -340,42 +436,25 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
-static void max310x_set_baud(struct max310x_port *s, int baud)
+static void max310x_set_baud(struct uart_port *port, int baud)
 {
-	unsigned int mode = 0, div = s->uartclk / baud;
+	unsigned int mode = 0, div = port->uartclk / baud;
 
 	if (!(div / 16)) {
 		/* Mode x2 */
 		mode = MAX310X_BRGCFG_2XMODE_BIT;
-		div = (s->uartclk * 2) / baud;
+		div = (port->uartclk * 2) / baud;
 	}
 
 	if (!(div / 16)) {
 		/* Mode x4 */
 		mode = MAX310X_BRGCFG_4XMODE_BIT;
-		div = (s->uartclk * 4) / baud;
+		div = (port->uartclk * 4) / baud;
 	}
 
-	regmap_write(s->regmap, MAX310X_BRGDIVMSB_REG,
-		     ((div / 16) >> 8) & 0xff);
-	regmap_write(s->regmap, MAX310X_BRGDIVLSB_REG, (div / 16) & 0xff);
-	regmap_write(s->regmap, MAX310X_BRGCFG_REG, (div % 16) | mode);
-}
-
-static void max310x_wait_pll(struct max310x_port *s)
-{
-	int tryes = 1000;
-
-	/* Wait for PLL only if crystal is used */
-	if (!(s->pdata->driver_flags & MAX310X_EXT_CLK)) {
-		unsigned int sts = 0;
-
-		while (tryes--) {
-			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &sts);
-			if (sts & MAX310X_STS_CLKREADY_BIT)
-				break;
-		}
-	}
+	max310x_port_write(port, MAX310X_BRGDIVMSB_REG, (div / 16) >> 8);
+	max310x_port_write(port, MAX310X_BRGDIVLSB_REG, div / 16);
+	max310x_port_write(port, MAX310X_BRGCFG_REG, (div % 16) | mode);
 }
 
 static int max310x_update_best_err(unsigned long f, long *besterr)
@@ -449,49 +528,49 @@ static int max310x_set_ref_clk(struct max310x_port *s)
 
 	regmap_write(s->regmap, MAX310X_CLKSRC_REG, clksrc);
 
-	if (pllcfg)
-		max310x_wait_pll(s);
-
-	dev_dbg(s->port.dev, "Reference clock set to %lu Hz\n", bestfreq);
+	/* Wait for crystal */
+	if (pllcfg && !(s->pdata->driver_flags & MAX310X_EXT_CLK))
+		msleep(10);
 
 	return (int)bestfreq;
 }
 
-static void max310x_handle_rx(struct max310x_port *s, unsigned int rxlen)
+static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 {
-	unsigned int sts = 0, ch = 0, flag;
+	unsigned int sts, ch, flag;
 
-	if (unlikely(rxlen >= MAX310X_FIFO_SIZE)) {
-		dev_warn(s->port.dev, "Possible RX FIFO overrun %d\n", rxlen);
+	if (unlikely(rxlen >= port->fifosize)) {
+		dev_warn_ratelimited(port->dev,
+				     "Port %i: Possible RX FIFO overrun\n",
+				     port->line);
+		port->icount.buf_overrun++;
 		/* Ensure sanity of RX level */
-		rxlen = MAX310X_FIFO_SIZE;
+		rxlen = port->fifosize;
 	}
 
-	dev_dbg(s->port.dev, "RX Len = %u\n", rxlen);
-
 	while (rxlen--) {
-		regmap_read(s->regmap, MAX310X_RHR_REG, &ch);
-		regmap_read(s->regmap, MAX310X_LSR_IRQSTS_REG, &sts);
+		ch = max310x_port_read(port, MAX310X_RHR_REG);
+		sts = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
 
 		sts &= MAX310X_LSR_RXPAR_BIT | MAX310X_LSR_FRERR_BIT |
 		       MAX310X_LSR_RXOVR_BIT | MAX310X_LSR_RXBRK_BIT;
 
-		s->port.icount.rx++;
+		port->icount.rx++;
 		flag = TTY_NORMAL;
 
 		if (unlikely(sts)) {
 			if (sts & MAX310X_LSR_RXBRK_BIT) {
-				s->port.icount.brk++;
-				if (uart_handle_break(&s->port))
+				port->icount.brk++;
+				if (uart_handle_break(port))
 					continue;
 			} else if (sts & MAX310X_LSR_RXPAR_BIT)
-				s->port.icount.parity++;
+				port->icount.parity++;
 			else if (sts & MAX310X_LSR_FRERR_BIT)
-				s->port.icount.frame++;
+				port->icount.frame++;
 			else if (sts & MAX310X_LSR_RXOVR_BIT)
-				s->port.icount.overrun++;
+				port->icount.overrun++;
 
-			sts &= s->port.read_status_mask;
+			sts &= port->read_status_mask;
 			if (sts & MAX310X_LSR_RXBRK_BIT)
 				flag = TTY_BREAK;
 			else if (sts & MAX310X_LSR_RXPAR_BIT)
@@ -502,129 +581,129 @@ static void max310x_handle_rx(struct max310x_port *s, unsigned int rxlen)
 				flag = TTY_OVERRUN;
 		}
 
-		if (uart_handle_sysrq_char(s->port, ch))
+		if (uart_handle_sysrq_char(port, ch))
 			continue;
 
-		if (sts & s->port.ignore_status_mask)
+		if (sts & port->ignore_status_mask)
 			continue;
 
-		uart_insert_char(&s->port, sts, MAX310X_LSR_RXOVR_BIT,
-				 ch, flag);
+		uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT, ch, flag);
 	}
 
-	tty_flip_buffer_push(&s->port.state->port);
+	tty_flip_buffer_push(&port->state->port);
 }
 
-static void max310x_handle_tx(struct max310x_port *s)
+static void max310x_handle_tx(struct uart_port *port)
 {
-	struct circ_buf *xmit = &s->port.state->xmit;
-	unsigned int txlen = 0, to_send;
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned int txlen, to_send;
 
-	if (unlikely(s->port.x_char)) {
-		regmap_write(s->regmap, MAX310X_THR_REG, s->port.x_char);
-		s->port.icount.tx++;
-		s->port.x_char = 0;
+	if (unlikely(port->x_char)) {
+		max310x_port_write(port, MAX310X_THR_REG, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&s->port))
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return;
 
 	/* Get length of data pending in circular buffer */
 	to_send = uart_circ_chars_pending(xmit);
 	if (likely(to_send)) {
 		/* Limit to size of TX FIFO */
-		regmap_read(s->regmap, MAX310X_TXFIFOLVL_REG, &txlen);
-		txlen = MAX310X_FIFO_SIZE - txlen;
+		txlen = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
+		txlen = port->fifosize - txlen;
 		to_send = (to_send > txlen) ? txlen : to_send;
 
-		dev_dbg(s->port.dev, "TX Len = %u\n", to_send);
-
 		/* Add data to send */
-		s->port.icount.tx += to_send;
+		port->icount.tx += to_send;
 		while (to_send--) {
-			regmap_write(s->regmap, MAX310X_THR_REG,
-				     xmit->buf[xmit->tail]);
+			max310x_port_write(port, MAX310X_THR_REG,
+					   xmit->buf[xmit->tail]);
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		};
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&s->port);
+		uart_write_wakeup(port);
 }
 
-static irqreturn_t max310x_ist(int irq, void *dev_id)
+static void max310x_port_irq(struct max310x_port *s, int portno)
 {
-	struct max310x_port *s = (struct max310x_port *)dev_id;
-	unsigned int ists = 0, lsr = 0, rxlen = 0;
+	struct uart_port *port = &s->p[portno].port;
 
-	mutex_lock(&s->max310x_mutex);
+	do {
+		unsigned int ists, lsr, rxlen;
 
-	for (;;) {
 		/* Read IRQ status & RX FIFO level */
-		regmap_read(s->regmap, MAX310X_IRQSTS_REG, &ists);
-		regmap_read(s->regmap, MAX310X_LSR_IRQSTS_REG, &lsr);
-		regmap_read(s->regmap, MAX310X_RXFIFOLVL_REG, &rxlen);
-		if (!ists && !(lsr & MAX310X_LSR_RXTO_BIT) && !rxlen)
+		ists = max310x_port_read(port, MAX310X_IRQSTS_REG);
+		rxlen = max310x_port_read(port, MAX310X_RXFIFOLVL_REG);
+		if (!ists && !rxlen)
 			break;
 
-		dev_dbg(s->port.dev, "IRQ status: 0x%02x\n", ists);
-
-		if (rxlen)
-			max310x_handle_rx(s, rxlen);
-		if (ists & MAX310X_IRQ_TX)
-			max310x_handle_tx(s);
-		if (ists & MAX310X_IRQ_CTS_BIT)
-			uart_handle_cts_change(&s->port,
+		if (ists & MAX310X_IRQ_CTS_BIT) {
+			lsr = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
+			uart_handle_cts_change(port,
 					       !!(lsr & MAX310X_LSR_CTS_BIT));
-	}
+		}
+		if (rxlen)
+			max310x_handle_rx(port, rxlen);
+		if (ists & MAX310X_IRQ_TXEMPTY_BIT) {
+			mutex_lock(&s->mutex);
+			max310x_handle_tx(port);
+			mutex_unlock(&s->mutex);
+		}
+	} while (1);
+}
 
-	mutex_unlock(&s->max310x_mutex);
+static irqreturn_t max310x_ist(int irq, void *dev_id)
+{
+	struct max310x_port *s = (struct max310x_port *)dev_id;
+
+	if (s->uart.nr > 1) {
+		do {
+			unsigned int val = ~0;
+
+			WARN_ON_ONCE(regmap_read(s->regmap,
+						 MAX310X_GLOBALIRQ_REG, &val));
+			val = ((1 << s->uart.nr) - 1) & ~val;
+			if (!val)
+				break;
+			max310x_port_irq(s, fls(val) - 1);
+		} while (1);
+	} else
+		max310x_port_irq(s, 0);
 
 	return IRQ_HANDLED;
 }
 
 static void max310x_wq_proc(struct work_struct *ws)
 {
-	struct max310x_port *s = container_of(ws, struct max310x_port, tx_work);
+	struct max310x_one *one = container_of(ws, struct max310x_one, tx_work);
+	struct max310x_port *s = dev_get_drvdata(one->port.dev);
 
-	mutex_lock(&s->max310x_mutex);
-	max310x_handle_tx(s);
-	mutex_unlock(&s->max310x_mutex);
+	mutex_lock(&s->mutex);
+	max310x_handle_tx(&one->port);
+	mutex_unlock(&s->mutex);
 }
 
 static void max310x_start_tx(struct uart_port *port)
 {
-	struct max310x_port *s = container_of(port, struct max310x_port, port);
+	struct max310x_one *one = container_of(port, struct max310x_one, port);
 
-	queue_work(s->wq, &s->tx_work);
-}
-
-static void max310x_stop_tx(struct uart_port *port)
-{
-	/* Do nothing */
-}
-
-static void max310x_stop_rx(struct uart_port *port)
-{
-	/* Do nothing */
+	if (!work_pending(&one->tx_work))
+		schedule_work(&one->tx_work);
 }
 
 static unsigned int max310x_tx_empty(struct uart_port *port)
 {
-	unsigned int val = 0;
-	struct max310x_port *s = container_of(port, struct max310x_port, port);
-
-	mutex_lock(&s->max310x_mutex);
-	regmap_read(s->regmap, MAX310X_TXFIFOLVL_REG, &val);
-	mutex_unlock(&s->max310x_mutex);
+	unsigned int lvl, sts;
 
-	return val ? 0 : TIOCSER_TEMT;
-}
+	lvl = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
+	sts = max310x_port_read(port, MAX310X_IRQSTS_REG);
 
-static void max310x_enable_ms(struct uart_port *port)
-{
-	/* Modem status not supported */
+	return ((sts & MAX310X_IRQ_TXEMPTY_BIT) && !lvl) ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int max310x_get_mctrl(struct uart_port *port)
@@ -644,28 +723,20 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void max310x_break_ctl(struct uart_port *port, int break_state)
 {
-	struct max310x_port *s = container_of(port, struct max310x_port, port);
-
-	mutex_lock(&s->max310x_mutex);
-	regmap_update_bits(s->regmap, MAX310X_LCR_REG,
-			   MAX310X_LCR_TXBREAK_BIT,
-			   break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
-	mutex_unlock(&s->max310x_mutex);
+	max310x_port_update(port, MAX310X_LCR_REG,
+			    MAX310X_LCR_TXBREAK_BIT,
+			    break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
 }
 
 static void max310x_set_termios(struct uart_port *port,
 				struct ktermios *termios,
 				struct ktermios *old)
 {
-	struct max310x_port *s = container_of(port, struct max310x_port, port);
 	unsigned int lcr, flow = 0;
 	int baud;
 
-	mutex_lock(&s->max310x_mutex);
-
 	/* Mask termios capabilities we don't support */
 	termios->c_cflag &= ~CMSPAR;
-	termios->c_iflag &= ~IXANY;
 
 	/* Word size */
 	switch (termios->c_cflag & CSIZE) {
@@ -696,7 +767,7 @@ static void max310x_set_termios(struct uart_port *port,
 		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
 
 	/* Update LCR register */
-	regmap_write(s->regmap, MAX310X_LCR_REG, lcr);
+	max310x_port_write(port, MAX310X_LCR_REG, lcr);
 
 	/* Set read status mask */
 	port->read_status_mask = MAX310X_LSR_RXOVR_BIT;
@@ -717,8 +788,8 @@ static void max310x_set_termios(struct uart_port *port,
 					    MAX310X_LSR_RXBRK_BIT;
 
 	/* Configure flow control */
-	regmap_write(s->regmap, MAX310X_XON1_REG, termios->c_cc[VSTART]);
-	regmap_write(s->regmap, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
+	max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
+	max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
 	if (termios->c_cflag & CRTSCTS)
 		flow |= MAX310X_FLOWCTRL_AUTOCTS_BIT |
 			MAX310X_FLOWCTRL_AUTORTS_BIT;
@@ -728,7 +799,7 @@ static void max310x_set_termios(struct uart_port *port,
 	if (termios->c_iflag & IXOFF)
 		flow |= MAX310X_FLOWCTRL_SWFLOW1_BIT |
 			MAX310X_FLOWCTRL_SWFLOWEN_BIT;
-	regmap_write(s->regmap, MAX310X_FLOWCTRL_REG, flow);
+	max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);
 
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
@@ -736,36 +807,30 @@ static void max310x_set_termios(struct uart_port *port,
 				  port->uartclk / 4);
 
 	/* Setup baudrate generator */
-	max310x_set_baud(s, baud);
+	max310x_set_baud(port, baud);
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
-
-	mutex_unlock(&s->max310x_mutex);
 }
 
 static int max310x_startup(struct uart_port *port)
 {
 	unsigned int val, line = port->line;
-	struct max310x_port *s = container_of(port, struct max310x_port, port);
+	struct max310x_port *s = dev_get_drvdata(port->dev);
 
-	if (s->pdata->suspend)
-		s->pdata->suspend(0);
-
-	mutex_lock(&s->max310x_mutex);
+	s->devtype->power(port, 1);
 
 	/* Configure baud rate, 9600 as default */
-	max310x_set_baud(s, 9600);
+	max310x_set_baud(port, 9600);
 
 	/* Configure LCR register, 8N1 mode by default */
-	val = MAX310X_LCR_WORD_LEN_8;
-	regmap_write(s->regmap, MAX310X_LCR_REG, val);
+	max310x_port_write(port, MAX310X_LCR_REG, MAX310X_LCR_WORD_LEN_8);
 
 	/* Configure MODE1 register */
-	regmap_update_bits(s->regmap, MAX310X_MODE1_REG,
-			   MAX310X_MODE1_TRNSCVCTRL_BIT,
-			   (s->pdata->uart_flags[line] & MAX310X_AUTO_DIR_CTRL)
-			   ? MAX310X_MODE1_TRNSCVCTRL_BIT : 0);
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_TRNSCVCTRL_BIT,
+			    (s->pdata->uart_flags[line] & MAX310X_AUTO_DIR_CTRL)
+			    ? MAX310X_MODE1_TRNSCVCTRL_BIT : 0);
 
 	/* Configure MODE2 register */
 	val = MAX310X_MODE2_RXEMPTINV_BIT;
@@ -776,63 +841,40 @@ static int max310x_startup(struct uart_port *port)
 
 	/* Reset FIFOs */
 	val |= MAX310X_MODE2_FIFORST_BIT;
-	regmap_write(s->regmap, MAX310X_MODE2_REG, val);
-
-	/* Configure FIFO trigger level register */
-	/* RX FIFO trigger for 16 words, TX FIFO trigger for 64 words */
-	val = MAX310X_FIFOTRIGLVL_RX(16) | MAX310X_FIFOTRIGLVL_TX(64);
-	regmap_write(s->regmap, MAX310X_FIFOTRIGLVL_REG, val);
+	max310x_port_write(port, MAX310X_MODE2_REG, val);
+	max310x_port_update(port, MAX310X_MODE2_REG,
+			    MAX310X_MODE2_FIFORST_BIT, 0);
 
 	/* Configure flow control levels */
 	/* Flow control halt level 96, resume level 48 */
-	val = MAX310X_FLOWLVL_RES(48) | MAX310X_FLOWLVL_HALT(96);
-	regmap_write(s->regmap, MAX310X_FLOWLVL_REG, val);
-
-	/* Clear timeout register */
-	regmap_write(s->regmap, MAX310X_RXTO_REG, 0);
-
-	/* Configure LSR interrupt enable register */
-	/* Enable RX timeout interrupt */
-	val = MAX310X_LSR_RXTO_BIT;
-	regmap_write(s->regmap, MAX310X_LSR_IRQEN_REG, val);
+	max310x_port_write(port, MAX310X_FLOWLVL_REG,
+			   MAX310X_FLOWLVL_RES(48) | MAX310X_FLOWLVL_HALT(96));
 
-	/* Clear FIFO reset */
-	regmap_update_bits(s->regmap, MAX310X_MODE2_REG,
-			   MAX310X_MODE2_FIFORST_BIT, 0);
+	/* Clear IRQ status register */
+	max310x_port_read(port, MAX310X_IRQSTS_REG);
 
-	/* Clear IRQ status register by reading it */
-	regmap_read(s->regmap, MAX310X_IRQSTS_REG, &val);
-
-	/* Configure interrupt enable register */
-	/* Enable CTS change interrupt */
-	val = MAX310X_IRQ_CTS_BIT;
-	/* Enable RX, TX interrupts */
-	val |= MAX310X_IRQ_RX | MAX310X_IRQ_TX;
-	regmap_write(s->regmap, MAX310X_IRQEN_REG, val);
-
-	mutex_unlock(&s->max310x_mutex);
+	/* Enable RX, TX, CTS change interrupts */
+	val = MAX310X_IRQ_RXEMPTY_BIT | MAX310X_IRQ_TXEMPTY_BIT;
+	max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);
 
 	return 0;
 }
 
 static void max310x_shutdown(struct uart_port *port)
 {
-	struct max310x_port *s = container_of(port, struct max310x_port, port);
+	struct max310x_port *s = dev_get_drvdata(port->dev);
 
 	/* Disable all interrupts */
-	mutex_lock(&s->max310x_mutex);
-	regmap_write(s->regmap, MAX310X_IRQEN_REG, 0);
-	mutex_unlock(&s->max310x_mutex);
+	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
-	if (s->pdata->suspend)
-		s->pdata->suspend(1);
+	s->devtype->power(port, 0);
 }
 
 static const char *max310x_type(struct uart_port *port)
 {
-	struct max310x_port *s = container_of(port, struct max310x_port, port);
+	struct max310x_port *s = dev_get_drvdata(port->dev);
 
-	return (port->type == PORT_MAX310X) ? s->name : NULL;
+	return (port->type == PORT_MAX310X) ? s->devtype->name : NULL;
 }
 
 static int max310x_request_port(struct uart_port *port)
@@ -841,134 +883,100 @@ static int max310x_request_port(struct uart_port *port)
 	return 0;
 }
 
-static void max310x_release_port(struct uart_port *port)
-{
-	/* Do nothing */
-}
-
 static void max310x_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE)
 		port->type = PORT_MAX310X;
 }
 
-static int max310x_verify_port(struct uart_port *port, struct serial_struct *ser)
+static int max310x_verify_port(struct uart_port *port, struct serial_struct *s)
 {
-	if ((ser->type == PORT_UNKNOWN) || (ser->type == PORT_MAX310X))
-		return 0;
-	if (ser->irq == port->irq)
-		return 0;
+	if ((s->type != PORT_UNKNOWN) && (s->type != PORT_MAX310X))
+		return -EINVAL;
+	if (s->irq != port->irq)
+		return -EINVAL;
 
-	return -EINVAL;
+	return 0;
 }
 
-static struct uart_ops max310x_ops = {
+static void max310x_null_void(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static const struct uart_ops max310x_ops = {
 	.tx_empty	= max310x_tx_empty,
 	.set_mctrl	= max310x_set_mctrl,
 	.get_mctrl	= max310x_get_mctrl,
-	.stop_tx	= max310x_stop_tx,
+	.stop_tx	= max310x_null_void,
 	.start_tx	= max310x_start_tx,
-	.stop_rx	= max310x_stop_rx,
-	.enable_ms	= max310x_enable_ms,
+	.stop_rx	= max310x_null_void,
+	.enable_ms	= max310x_null_void,
 	.break_ctl	= max310x_break_ctl,
 	.startup	= max310x_startup,
 	.shutdown	= max310x_shutdown,
 	.set_termios	= max310x_set_termios,
 	.type		= max310x_type,
 	.request_port	= max310x_request_port,
-	.release_port	= max310x_release_port,
+	.release_port	= max310x_null_void,
 	.config_port	= max310x_config_port,
 	.verify_port	= max310x_verify_port,
 };
 
-#ifdef CONFIG_PM_SLEEP
-
-static int max310x_suspend(struct device *dev)
+static int __maybe_unused max310x_suspend(struct spi_device *spi,
+					  pm_message_t state)
 {
-	int ret;
-	struct max310x_port *s = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "Suspend\n");
+	struct max310x_port *s = dev_get_drvdata(&spi->dev);
+	int i;
 
-	ret = uart_suspend_port(&s->uart, &s->port);
-
-	mutex_lock(&s->max310x_mutex);
-
-	/* Enable sleep mode */
-	regmap_update_bits(s->regmap, MAX310X_MODE1_REG,
-			   MAX310X_MODE1_FORCESLEEP_BIT,
-			   MAX310X_MODE1_FORCESLEEP_BIT);
-
-	mutex_unlock(&s->max310x_mutex);
-
-	if (s->pdata->suspend)
-		s->pdata->suspend(1);
+	for (i = 0; i < s->uart.nr; i++) {
+		uart_suspend_port(&s->uart, &s->p[i].port);
+		s->devtype->power(&s->p[i].port, 0);
+	}
 
-	return ret;
+	return 0;
 }
 
-static int max310x_resume(struct device *dev)
+static int __maybe_unused max310x_resume(struct spi_device *spi)
 {
-	struct max310x_port *s = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "Resume\n");
-
-	if (s->pdata->suspend)
-		s->pdata->suspend(0);
-
-	mutex_lock(&s->max310x_mutex);
+	struct max310x_port *s = dev_get_drvdata(&spi->dev);
+	int i;
 
-	/* Disable sleep mode */
-	regmap_update_bits(s->regmap, MAX310X_MODE1_REG,
-			   MAX310X_MODE1_FORCESLEEP_BIT,
-			   0);
-
-	max310x_wait_pll(s);
-
-	mutex_unlock(&s->max310x_mutex);
+	for (i = 0; i < s->uart.nr; i++) {
+		s->devtype->power(&s->p[i].port, 1);
+		uart_resume_port(&s->uart, &s->p[i].port);
+	}
 
-	return uart_resume_port(&s->uart, &s->port);
+	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
-#define MAX310X_PM_OPS (&max310x_pm_ops)
-
-#else
-#define MAX310X_PM_OPS NULL
-#endif
-
 #ifdef CONFIG_GPIOLIB
 static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	unsigned int val = 0;
+	unsigned int val;
 	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+	struct uart_port *port = &s->p[offset / 4].port;
 
-	mutex_lock(&s->max310x_mutex);
-	regmap_read(s->regmap, MAX310X_GPIODATA_REG, &val);
-	mutex_unlock(&s->max310x_mutex);
+	val = max310x_port_read(port, MAX310X_GPIODATA_REG);
 
-	return !!((val >> 4) & (1 << offset));
+	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
 static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+	struct uart_port *port = &s->p[offset / 4].port;
 
-	mutex_lock(&s->max310x_mutex);
-	regmap_update_bits(s->regmap, MAX310X_GPIODATA_REG, 1 << offset, value ?
-							    1 << offset : 0);
-	mutex_unlock(&s->max310x_mutex);
+	max310x_port_update(port, MAX310X_GPIODATA_REG, 1 << (offset % 4),
+			    value ? 1 << (offset % 4) : 0);
 }
 
 static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+	struct uart_port *port = &s->p[offset / 4].port;
 
-	mutex_lock(&s->max310x_mutex);
-
-	regmap_update_bits(s->regmap, MAX310X_GPIOCFG_REG, 1 << offset, 0);
-
-	mutex_unlock(&s->max310x_mutex);
+	max310x_port_update(port, MAX310X_GPIOCFG_REG, 1 << (offset % 4), 0);
 
 	return 0;
 }
@@ -977,74 +985,42 @@ static int max310x_gpio_direction_output(struct gpio_chip *chip,
 					 unsigned offset, int value)
 {
 	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+	struct uart_port *port = &s->p[offset / 4].port;
 
-	mutex_lock(&s->max310x_mutex);
-
-	regmap_update_bits(s->regmap, MAX310X_GPIOCFG_REG, 1 << offset,
-							   1 << offset);
-	regmap_update_bits(s->regmap, MAX310X_GPIODATA_REG, 1 << offset, value ?
-							    1 << offset : 0);
-
-	mutex_unlock(&s->max310x_mutex);
+	max310x_port_update(port, MAX310X_GPIODATA_REG, 1 << (offset % 4),
+			    value ? 1 << (offset % 4) : 0);
+	max310x_port_update(port, MAX310X_GPIOCFG_REG, 1 << (offset % 4),
+			    1 << (offset % 4));
 
 	return 0;
 }
 #endif
 
-/* Generic platform data */
-static struct max310x_pdata generic_plat_data = {
-	.driver_flags	= MAX310X_EXT_CLK,
-	.uart_flags[0]	= MAX310X_ECHO_SUPRESS,
-	.frequency	= 26000000,
-};
-
-static int max310x_probe(struct spi_device *spi)
+static int max310x_probe(struct device *dev, int is_spi,
+			 struct max310x_devtype *devtype, int irq)
 {
 	struct max310x_port *s;
-	struct device *dev = &spi->dev;
-	int chiptype = spi_get_device_id(spi)->driver_data;
-	struct max310x_pdata *pdata = dev->platform_data;
-	unsigned int val = 0;
-	int ret;
+	struct max310x_pdata *pdata = dev_get_platdata(dev);
+	int i, ret, uartclk;
 
 	/* Check for IRQ */
-	if (spi->irq <= 0) {
+	if (irq <= 0) {
 		dev_err(dev, "No IRQ specified\n");
 		return -ENOTSUPP;
 	}
 
+	if (!pdata) {
+		dev_err(dev, "No platform data supplied\n");
+		return -EINVAL;
+	}
+
 	/* Alloc port structure */
-	s = devm_kzalloc(dev, sizeof(struct max310x_port), GFP_KERNEL);
+	s = devm_kzalloc(dev, sizeof(*s) +
+			 sizeof(struct max310x_one) * devtype->nr, GFP_KERNEL);
 	if (!s) {
 		dev_err(dev, "Error allocating port structure\n");
 		return -ENOMEM;
 	}
-	dev_set_drvdata(dev, s);
-
-	if (!pdata) {
-		dev_warn(dev, "No platform data supplied, using defaults\n");
-		pdata = &generic_plat_data;
-	}
-	s->pdata = pdata;
-
-	/* Individual chip settings */
-	switch (chiptype) {
-	case MAX310X_TYPE_MAX3107:
-		s->name = "MAX3107";
-		s->nr_gpio = 4;
-		s->uart.nr = 1;
-		s->regcfg.max_register = 0x1f;
-		break;
-	case MAX310X_TYPE_MAX3108:
-		s->name = "MAX3108";
-		s->nr_gpio = 4;
-		s->uart.nr = 1;
-		s->regcfg.max_register = 0x1e;
-		break;
-	default:
-		dev_err(dev, "Unsupported chip type %i\n", chiptype);
-		return -ENOTSUPP;
-	}
 
 	/* Check input frequency */
 	if ((pdata->driver_flags & MAX310X_EXT_CLK) &&
@@ -1055,13 +1031,11 @@ static int max310x_probe(struct spi_device *spi)
 	   ((pdata->frequency < 1000000) || (pdata->frequency > 4000000)))
 		goto err_freq;
 
-	mutex_init(&s->max310x_mutex);
+	s->pdata = pdata;
+	s->devtype = devtype;
+	dev_set_drvdata(dev, s);
 
-	/* Setup SPI bus */
-	spi->mode		= SPI_MODE_0;
-	spi->bits_per_word	= 8;
-	spi->max_speed_hz	= 26000000;
-	spi_setup(spi);
+	mutex_init(&s->mutex);
 
 	/* Setup regmap */
 	s->regcfg.reg_bits		= 8;
@@ -1069,109 +1043,100 @@ static int max310x_probe(struct spi_device *spi)
 	s->regcfg.read_flag_mask	= 0x00;
 	s->regcfg.write_flag_mask	= 0x80;
 	s->regcfg.cache_type		= REGCACHE_RBTREE;
-	s->regcfg.writeable_reg		= max3107_8_reg_writeable;
+	s->regcfg.writeable_reg		= max310x_reg_writeable;
 	s->regcfg.volatile_reg		= max310x_reg_volatile;
 	s->regcfg.precious_reg		= max310x_reg_precious;
-	s->regmap = devm_regmap_init_spi(spi, &s->regcfg);
+	s->regcfg.max_register		= devtype->nr * 0x20 - 1;
+
+	if (IS_ENABLED(CONFIG_SPI_MASTER) && is_spi) {
+		struct spi_device *spi = to_spi_device(dev);
+
+		s->regmap = devm_regmap_init_spi(spi, &s->regcfg);
+	} else
+		return -ENOTSUPP;
+
 	if (IS_ERR(s->regmap)) {
-		ret = PTR_ERR(s->regmap);
 		dev_err(dev, "Failed to initialize register map\n");
-		goto err_out;
-	}
-
-	/* Reset chip & check SPI function */
-	ret = regmap_write(s->regmap, MAX310X_MODE2_REG, MAX310X_MODE2_RST_BIT);
-	if (ret) {
-		dev_err(dev, "SPI transfer failed\n");
-		goto err_out;
-	}
-	/* Clear chip reset */
-	regmap_write(s->regmap, MAX310X_MODE2_REG, 0);
-
-	switch (chiptype) {
-	case MAX310X_TYPE_MAX3107:
-		/* Check REV ID to ensure we are talking to what we expect */
-		regmap_read(s->regmap, MAX3107_REVID_REG, &val);
-		if (((val & MAX3107_REV_MASK) != MAX3107_REV_ID)) {
-			dev_err(dev, "%s ID 0x%02x does not match\n",
-				s->name, val);
-			ret = -ENODEV;
-			goto err_out;
-		}
-		break;
-	case MAX310X_TYPE_MAX3108:
-		/* MAX3108 have not REV ID register, we just check default value
-		 * from clocksource register to make sure everything works.
-		 */
-		regmap_read(s->regmap, MAX310X_CLKSRC_REG, &val);
-		if (val != (MAX310X_CLKSRC_EXTCLK_BIT |
-			    MAX310X_CLKSRC_PLLBYP_BIT)) {
-			dev_err(dev, "%s not present\n", s->name);
-			ret = -ENODEV;
-			goto err_out;
-		}
-		break;
+		return PTR_ERR(s->regmap);
 	}
 
 	/* Board specific configure */
-	if (pdata->init)
-		pdata->init();
-	if (pdata->suspend)
-		pdata->suspend(0);
-
-	/* Calculate referecne clock */
-	s->uartclk = max310x_set_ref_clk(s);
-
-	/* Disable all interrupts */
-	regmap_write(s->regmap, MAX310X_IRQEN_REG, 0);
-
-	/* Setup MODE1 register */
-	val = MAX310X_MODE1_IRQSEL_BIT; /* Enable IRQ pin */
-	if (pdata->driver_flags & MAX310X_AUTOSLEEP)
-		val = MAX310X_MODE1_AUTOSLEEP_BIT;
-	regmap_write(s->regmap, MAX310X_MODE1_REG, val);
-
-	/* Setup interrupt */
-	ret = devm_request_threaded_irq(dev, spi->irq, NULL, max310x_ist,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					dev_name(dev), s);
-	if (ret) {
-		dev_err(dev, "Unable to reguest IRQ %i\n", spi->irq);
-		goto err_out;
+	if (s->pdata->init)
+		s->pdata->init();
+
+	/* Check device to ensure we are talking to what we expect */
+	ret = devtype->detect(dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < devtype->nr; i++) {
+		unsigned int offs = i << 5;
+
+		/* Reset port */
+		regmap_write(s->regmap, MAX310X_MODE2_REG + offs,
+			     MAX310X_MODE2_RST_BIT);
+		/* Clear port reset */
+		regmap_write(s->regmap, MAX310X_MODE2_REG + offs, 0);
+
+		/* Wait for port startup */
+		do {
+			regmap_read(s->regmap,
+				    MAX310X_BRGDIVLSB_REG + offs, &ret);
+		} while (ret != 0x01);
+
+		regmap_update_bits(s->regmap, MAX310X_MODE1_REG + offs,
+				   MAX310X_MODE1_AUTOSLEEP_BIT,
+				   MAX310X_MODE1_AUTOSLEEP_BIT);
 	}
 
+	uartclk = max310x_set_ref_clk(s);
+	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
+
 	/* Register UART driver */
 	s->uart.owner		= THIS_MODULE;
-	s->uart.driver_name	= dev_name(dev);
 	s->uart.dev_name	= "ttyMAX";
 	s->uart.major		= MAX310X_MAJOR;
 	s->uart.minor		= MAX310X_MINOR;
+	s->uart.nr		= devtype->nr;
 	ret = uart_register_driver(&s->uart);
 	if (ret) {
 		dev_err(dev, "Registering UART driver failed\n");
-		goto err_out;
+		return ret;
 	}
 
-	/* Initialize workqueue for start TX */
-	s->wq = create_freezable_workqueue(dev_name(dev));
-	INIT_WORK(&s->tx_work, max310x_wq_proc);
-
-	/* Initialize UART port data */
-	s->port.line		= 0;
-	s->port.dev		= dev;
-	s->port.irq		= spi->irq;
-	s->port.type		= PORT_MAX310X;
-	s->port.fifosize	= MAX310X_FIFO_SIZE;
-	s->port.flags		= UPF_SKIP_TEST | UPF_FIXED_TYPE;
-	s->port.iotype		= UPIO_PORT;
-	s->port.membase		= (void __iomem *)0xffffffff; /* Bogus value */
-	s->port.uartclk		= s->uartclk;
-	s->port.ops		= &max310x_ops;
-	uart_add_one_port(&s->uart, &s->port);
+	for (i = 0; i < devtype->nr; i++) {
+		/* Initialize port data */
+		s->p[i].port.line	= i;
+		s->p[i].port.dev	= dev;
+		s->p[i].port.irq	= irq;
+		s->p[i].port.type	= PORT_MAX310X;
+		s->p[i].port.fifosize	= MAX310X_FIFO_SIZE;
+		s->p[i].port.flags	= UPF_SKIP_TEST | UPF_FIXED_TYPE |
+					  UPF_LOW_LATENCY;
+		s->p[i].port.iotype	= UPIO_PORT;
+		s->p[i].port.iobase	= i * 0x20;
+		s->p[i].port.membase	= (void __iomem *)~0;
+		s->p[i].port.uartclk	= uartclk;
+		s->p[i].port.ops	= &max310x_ops;
+		/* Disable all interrupts */
+		max310x_port_write(&s->p[i].port, MAX310X_IRQEN_REG, 0);
+		/* Clear IRQ status register */
+		max310x_port_read(&s->p[i].port, MAX310X_IRQSTS_REG);
+		/* Enable IRQ pin */
+		max310x_port_update(&s->p[i].port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_IRQSEL_BIT,
+				    MAX310X_MODE1_IRQSEL_BIT);
+		/* Initialize queue for start TX */
+		INIT_WORK(&s->p[i].tx_work, max310x_wq_proc);
+		/* Register port */
+		uart_add_one_port(&s->uart, &s->p[i].port);
+		/* Go to suspend mode */
+		devtype->power(&s->p[i].port, 0);
+	}
 
 #ifdef CONFIG_GPIOLIB
 	/* Setup GPIO cotroller */
-	if (pdata->gpio_base) {
+	if (s->pdata->gpio_base) {
 		s->gpio.owner		= THIS_MODULE;
 		s->gpio.dev		= dev;
 		s->gpio.label		= dev_name(dev);
@@ -1179,86 +1144,105 @@ static int max310x_probe(struct spi_device *spi)
 		s->gpio.get		= max310x_gpio_get;
 		s->gpio.direction_output= max310x_gpio_direction_output;
 		s->gpio.set		= max310x_gpio_set;
-		s->gpio.base		= pdata->gpio_base;
-		s->gpio.ngpio		= s->nr_gpio;
+		s->gpio.base		= s->pdata->gpio_base;
+		s->gpio.ngpio		= devtype->nr * 4;
 		s->gpio.can_sleep	= 1;
-		if (gpiochip_add(&s->gpio)) {
-			/* Indicate that we should not call gpiochip_remove */
-			s->gpio.base = 0;
-		}
+		if (!gpiochip_add(&s->gpio))
+			s->gpio_used = 1;
 	} else
 		dev_info(dev, "GPIO support not enabled\n");
 #endif
 
-	/* Go to suspend mode */
-	if (pdata->suspend)
-		pdata->suspend(1);
+	/* Setup interrupt */
+	ret = devm_request_threaded_irq(dev, irq, NULL, max310x_ist,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					dev_name(dev), s);
+	if (ret) {
+		dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+#ifdef CONFIG_GPIOLIB
+		if (s->gpio_used)
+			WARN_ON(gpiochip_remove(&s->gpio));
+#endif
+	}
 
-	return 0;
+	return ret;
 
 err_freq:
 	dev_err(dev, "Frequency parameter incorrect\n");
-	ret = -EINVAL;
-
-err_out:
-	dev_set_drvdata(dev, NULL);
-
-	return ret;
+	return -EINVAL;
 }
 
-static int max310x_remove(struct spi_device *spi)
+static int max310x_remove(struct device *dev)
 {
-	struct device *dev = &spi->dev;
 	struct max310x_port *s = dev_get_drvdata(dev);
-	int ret = 0;
-
-	dev_dbg(dev, "Removing port\n");
-
-	devm_free_irq(dev, s->port.irq, s);
+	int i, ret = 0;
 
-	destroy_workqueue(s->wq);
-
-	uart_remove_one_port(&s->uart, &s->port);
+	for (i = 0; i < s->uart.nr; i++) {
+		cancel_work_sync(&s->p[i].tx_work);
+		uart_remove_one_port(&s->uart, &s->p[i].port);
+		s->devtype->power(&s->p[i].port, 0);
+	}
 
 	uart_unregister_driver(&s->uart);
 
 #ifdef CONFIG_GPIOLIB
-	if (s->pdata->gpio_base) {
+	if (s->gpio_used)
 		ret = gpiochip_remove(&s->gpio);
-		if (ret)
-			dev_err(dev, "Failed to remove gpio chip: %d\n", ret);
-	}
 #endif
 
-	dev_set_drvdata(dev, NULL);
-
-	if (s->pdata->suspend)
-		s->pdata->suspend(1);
 	if (s->pdata->exit)
 		s->pdata->exit();
 
 	return ret;
 }
 
+#ifdef CONFIG_SPI_MASTER
+static int max310x_spi_probe(struct spi_device *spi)
+{
+	struct max310x_devtype *devtype =
+		(struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
+	int ret;
+
+	/* Setup SPI bus */
+	spi->bits_per_word	= 8;
+	spi->mode		= spi->mode ? : SPI_MODE_0;
+	spi->max_speed_hz	= spi->max_speed_hz ? : 26000000;
+	ret = spi_setup(spi);
+	if (ret) {
+		dev_err(&spi->dev, "SPI setup failed\n");
+		return ret;
+	}
+
+	return max310x_probe(&spi->dev, 1, devtype, spi->irq);
+}
+
+static int max310x_spi_remove(struct spi_device *spi)
+{
+	return max310x_remove(&spi->dev);
+}
+
+static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
+
 static const struct spi_device_id max310x_id_table[] = {
-	{ "max3107",	MAX310X_TYPE_MAX3107 },
-	{ "max3108",	MAX310X_TYPE_MAX3108 },
+	{ "max3107",	(kernel_ulong_t)&max3107_devtype, },
+	{ "max3108",	(kernel_ulong_t)&max3108_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, max310x_id_table);
 
-static struct spi_driver max310x_driver = {
+static struct spi_driver max310x_uart_driver = {
 	.driver = {
-		.name	= "max310x",
+		.name	= MAX310X_NAME,
 		.owner	= THIS_MODULE,
-		.pm	= MAX310X_PM_OPS,
+		.pm	= &max310x_pm_ops,
 	},
-	.probe		= max310x_probe,
-	.remove		= max310x_remove,
+	.probe		= max310x_spi_probe,
+	.remove		= max310x_spi_remove,
 	.id_table	= max310x_id_table,
 };
-module_spi_driver(max310x_driver);
+module_spi_driver(max310x_uart_driver);
+#endif
 
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("MAX310X serial driver");
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
index 91648bf..1aec0b6 100644
--- a/include/linux/platform_data/max310x.h
+++ b/include/linux/platform_data/max310x.h
@@ -42,9 +42,8 @@
 /* MAX310X platform data structure */
 struct max310x_pdata {
 	/* Flags global to driver */
-	const u8		driver_flags:2;
+	const u8		driver_flags;
 #define MAX310X_EXT_CLK		(0x00000001)	/* External clock enable */
-#define MAX310X_AUTOSLEEP	(0x00000002)	/* Enable AutoSleep mode */
 	/* Flags global to UART port */
 	const u8		uart_flags[MAX310X_MAX_UARTS];
 #define MAX310X_LOOPBACK	(0x00000001)	/* Loopback mode enable */
@@ -60,8 +59,6 @@ struct max310x_pdata {
 	void (*init)(void);
 	/* Called before finish */
 	void (*exit)(void);
-	/* Suspend callback */
-	void (*suspend)(int do_suspend);
 };
 
 #endif
-- 
1.8.1.5

