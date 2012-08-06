From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: New serial driver MAX310X
Date: Mon,  6 Aug 2012 19:42:32 +0400
Message-ID: <1344267752-20407-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.mail.ru ([94.100.176.130]:51078 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756370Ab2HFPmm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Aug 2012 11:42:42 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This driver is a replacement for a MAX3107 driver with a lot of
improvements and new features.
The main differences from the old version:
- Using the regmap.
- Using devm_XXX-related functions.
- The use of threaded IRQ with IRQF_ONESHOT flag allows the driver to
  the hardware that supports only level IRQ.
- Improved error handling of serial port, improved FIFO handling,
  improved hardware & software flow control.
- Advanced flags allows turn on RS-485 mode (Auto direction control).
- Ability to load multiple instances of drivers.
- Added support for MAX3108.
- GPIO support.
- Driver is quite ready for adding I2C support and support other ICs
  with compatible registers set (MAX3109, MAX14830).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig            |   13 +-
 drivers/tty/serial/Makefile           |    2 +-
 drivers/tty/serial/max3107.c          | 1215 -------------------------------
 drivers/tty/serial/max3107.h          |  441 ------------
 drivers/tty/serial/max310x.c          | 1259 +++++++++++++++++++++++++++++++++
 include/linux/platform_data/max310x.h |   67 ++
 include/linux/serial_core.h           |    4 +-
 7 files changed, 1339 insertions(+), 1662 deletions(-)
 delete mode 100644 drivers/tty/serial/max3107.c
 delete mode 100644 drivers/tty/serial/max3107.h
 create mode 100644 drivers/tty/serial/max310x.c
 create mode 100644 include/linux/platform_data/max310x.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 070b442..0873dfa 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -257,12 +257,19 @@ config SERIAL_MAX3100
 	help
 	  MAX3100 chip support
 
-config SERIAL_MAX3107
-	tristate "MAX3107 support"
+config SERIAL_MAX310X
+	bool "MAX310X support"
 	depends on SPI
 	select SERIAL_CORE
+	select REGMAP_SPI if SPI
+	default n
 	help
-	  MAX3107 chip support
+	  This selects support for an advanced UART from Maxim (Dallas).
+	  Supported ICs are MAX3107, MAX3108.
+	  Each IC contains 128 words each of receive and transmit FIFO
+	  that can be controlled through I2C or high-speed SPI.
+
+	  Say Y here if you want to support this ICs.
 
 config SERIAL_DZ
 	bool "DECstation DZ serial driver"
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 7257c5d..6c63194 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_SERIAL_BFIN) += bfin_uart.o
 obj-$(CONFIG_SERIAL_BFIN_SPORT) += bfin_sport_uart.o
 obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
-obj-$(CONFIG_SERIAL_MAX3107) += max3107.o
+obj-$(CONFIG_SERIAL_MAX310X) += max310x.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
 obj-$(CONFIG_SERIAL_MUX) += mux.o
 obj-$(CONFIG_SERIAL_68328) += 68328serial.o
diff --git a/drivers/tty/serial/max3107.c b/drivers/tty/serial/max3107.c
deleted file mode 100644
index 17c7ba8..0000000
--- a/drivers/tty/serial/max3107.c
+++ /dev/null
@@ -1,1215 +0,0 @@
-/*
- *  max3107.c - spi uart protocol driver for Maxim 3107
- *  Based on max3100.c
- *	by Christian Pellegrin <chripell@evolware.org>
- *  and	max3110.c
- *	by Feng Tang <feng.tang@intel.com>
- *
- *  Copyright (C) Aavamobile 2009
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- */
-
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/gpio.h>
-#include <linux/spi/spi.h>
-#include <linux/freezer.h>
-#include <linux/module.h>
-#include "max3107.h"
-
-static const struct baud_table brg26_ext[] = {
-	{ 300,    MAX3107_BRG26_B300 },
-	{ 600,    MAX3107_BRG26_B600 },
-	{ 1200,   MAX3107_BRG26_B1200 },
-	{ 2400,   MAX3107_BRG26_B2400 },
-	{ 4800,   MAX3107_BRG26_B4800 },
-	{ 9600,   MAX3107_BRG26_B9600 },
-	{ 19200,  MAX3107_BRG26_B19200 },
-	{ 57600,  MAX3107_BRG26_B57600 },
-	{ 115200, MAX3107_BRG26_B115200 },
-	{ 230400, MAX3107_BRG26_B230400 },
-	{ 460800, MAX3107_BRG26_B460800 },
-	{ 921600, MAX3107_BRG26_B921600 },
-	{ 0, 0 }
-};
-
-static const struct baud_table brg13_int[] = {
-	{ 300,    MAX3107_BRG13_IB300 },
-	{ 600,    MAX3107_BRG13_IB600 },
-	{ 1200,   MAX3107_BRG13_IB1200 },
-	{ 2400,   MAX3107_BRG13_IB2400 },
-	{ 4800,   MAX3107_BRG13_IB4800 },
-	{ 9600,   MAX3107_BRG13_IB9600 },
-	{ 19200,  MAX3107_BRG13_IB19200 },
-	{ 57600,  MAX3107_BRG13_IB57600 },
-	{ 115200, MAX3107_BRG13_IB115200 },
-	{ 230400, MAX3107_BRG13_IB230400 },
-	{ 460800, MAX3107_BRG13_IB460800 },
-	{ 921600, MAX3107_BRG13_IB921600 },
-	{ 0, 0 }
-};
-
-static u32 get_new_brg(int baud, struct max3107_port *s)
-{
-	int i;
-	const struct baud_table *baud_tbl = s->baud_tbl;
-
-	for (i = 0; i < 13; i++) {
-		if (baud == baud_tbl[i].baud)
-			return baud_tbl[i].new_brg;
-	}
-
-	return 0;
-}
-
-/* Perform SPI transfer for write/read of device register(s) */
-int max3107_rw(struct max3107_port *s, u8 *tx, u8 *rx, int len)
-{
-	struct spi_message spi_msg;
-	struct spi_transfer spi_xfer;
-
-	/* Initialize SPI ,message */
-	spi_message_init(&spi_msg);
-
-	/* Initialize SPI transfer */
-	memset(&spi_xfer, 0, sizeof spi_xfer);
-	spi_xfer.len = len;
-	spi_xfer.tx_buf = tx;
-	spi_xfer.rx_buf = rx;
-	spi_xfer.speed_hz = MAX3107_SPI_SPEED;
-
-	/* Add SPI transfer to SPI message */
-	spi_message_add_tail(&spi_xfer, &spi_msg);
-
-#ifdef DBG_TRACE_SPI_DATA
-	{
-		int i;
-		pr_info("tx len %d:\n", spi_xfer.len);
-		for (i = 0 ; i < spi_xfer.len && i < 32 ; i++)
-			pr_info(" %x", ((u8 *)spi_xfer.tx_buf)[i]);
-		pr_info("\n");
-	}
-#endif
-
-	/* Perform synchronous SPI transfer */
-	if (spi_sync(s->spi, &spi_msg)) {
-		dev_err(&s->spi->dev, "spi_sync failure\n");
-		return -EIO;
-	}
-
-#ifdef DBG_TRACE_SPI_DATA
-	if (spi_xfer.rx_buf) {
-		int i;
-		pr_info("rx len %d:\n", spi_xfer.len);
-		for (i = 0 ; i < spi_xfer.len && i < 32 ; i++)
-			pr_info(" %x", ((u8 *)spi_xfer.rx_buf)[i]);
-		pr_info("\n");
-	}
-#endif
-	return 0;
-}
-EXPORT_SYMBOL_GPL(max3107_rw);
-
-/* Puts received data to circular buffer */
-static void put_data_to_circ_buf(struct max3107_port *s, unsigned char *data,
-					int len)
-{
-	struct uart_port *port = &s->port;
-	struct tty_struct *tty;
-
-	if (!port->state)
-		return;
-
-	tty = port->state->port.tty;
-	if (!tty)
-		return;
-
-	/* Insert received data */
-	tty_insert_flip_string(tty, data, len);
-	/* Update RX counter */
-	port->icount.rx += len;
-}
-
-/* Handle data receiving */
-static void max3107_handlerx(struct max3107_port *s, u16 rxlvl)
-{
-	int i;
-	int j;
-	int len;				/* SPI transfer buffer length */
-	u16 *buf;
-	u8 *valid_str;
-
-	if (!s->rx_enabled)
-		/* RX is disabled */
-		return;
-
-	if (rxlvl == 0) {
-		/* RX fifo is empty */
-		return;
-	} else if (rxlvl >= MAX3107_RX_FIFO_SIZE) {
-		dev_warn(&s->spi->dev, "Possible RX FIFO overrun %d\n", rxlvl);
-		/* Ensure sanity of RX level */
-		rxlvl = MAX3107_RX_FIFO_SIZE;
-	}
-	if ((s->rxbuf == 0) || (s->rxstr == 0)) {
-		dev_warn(&s->spi->dev, "Rx buffer/str isn't ready\n");
-		return;
-	}
-	buf = s->rxbuf;
-	valid_str = s->rxstr;
-	while (rxlvl) {
-		pr_debug("rxlvl %d\n", rxlvl);
-		/* Clear buffer */
-		memset(buf, 0, sizeof(u16) * (MAX3107_RX_FIFO_SIZE + 2));
-		len = 0;
-		if (s->irqen_reg & MAX3107_IRQ_RXFIFO_BIT) {
-			/* First disable RX FIFO interrupt */
-			pr_debug("Disabling RX INT\n");
-			buf[0] = (MAX3107_WRITE_BIT | MAX3107_IRQEN_REG);
-			s->irqen_reg &= ~MAX3107_IRQ_RXFIFO_BIT;
-			buf[0] |= s->irqen_reg;
-			len++;
-		}
-		/* Just increase the length by amount of words in FIFO since
-		 * buffer was zeroed and SPI transfer of 0x0000 means reading
-		 * from RX FIFO
-		 */
-		len += rxlvl;
-		/* Append RX level query */
-		buf[len] = MAX3107_RXFIFOLVL_REG;
-		len++;
-
-		/* Perform the SPI transfer */
-		if (max3107_rw(s, (u8 *)buf, (u8 *)buf, len * 2)) {
-			dev_err(&s->spi->dev, "SPI transfer for RX h failed\n");
-			return;
-		}
-
-		/* Skip RX FIFO interrupt disabling word if it was added */
-		j = ((len - 1) - rxlvl);
-		/* Read received words */
-		for (i = 0; i < rxlvl; i++, j++)
-			valid_str[i] = (u8)buf[j];
-		put_data_to_circ_buf(s, valid_str, rxlvl);
-		/* Get new RX level */
-		rxlvl = (buf[len - 1] & MAX3107_SPI_RX_DATA_MASK);
-	}
-
-	if (s->rx_enabled) {
-		/* RX still enabled, re-enable RX FIFO interrupt */
-		pr_debug("Enabling RX INT\n");
-		buf[0] = (MAX3107_WRITE_BIT | MAX3107_IRQEN_REG);
-		s->irqen_reg |= MAX3107_IRQ_RXFIFO_BIT;
-		buf[0] |= s->irqen_reg;
-		if (max3107_rw(s, (u8 *)buf, NULL, 2))
-			dev_err(&s->spi->dev, "RX FIFO INT enabling failed\n");
-	}
-
-	/* Push the received data to receivers */
-	if (s->port.state->port.tty)
-		tty_flip_buffer_push(s->port.state->port.tty);
-}
-
-
-/* Handle data sending */
-static void max3107_handletx(struct max3107_port *s)
-{
-	struct circ_buf *xmit = &s->port.state->xmit;
-	int i;
-	unsigned long flags;
-	int len;				/* SPI transfer buffer length */
-	u16 *buf;
-
-	if (!s->tx_fifo_empty)
-		/* Don't send more data before previous data is sent */
-		return;
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&s->port))
-		/* No data to send or TX is stopped */
-		return;
-
-	if (!s->txbuf) {
-		dev_warn(&s->spi->dev, "Txbuf isn't ready\n");
-		return;
-	}
-	buf = s->txbuf;
-	/* Get length of data pending in circular buffer */
-	len = uart_circ_chars_pending(xmit);
-	if (len) {
-		/* Limit to size of TX FIFO */
-		if (len > MAX3107_TX_FIFO_SIZE)
-			len = MAX3107_TX_FIFO_SIZE;
-
-		pr_debug("txlen %d\n", len);
-
-		/* Update TX counter */
-		s->port.icount.tx += len;
-
-		/* TX FIFO will no longer be empty */
-		s->tx_fifo_empty = 0;
-
-		i = 0;
-		if (s->irqen_reg & MAX3107_IRQ_TXEMPTY_BIT) {
-			/* First disable TX empty interrupt */
-			pr_debug("Disabling TE INT\n");
-			buf[i] = (MAX3107_WRITE_BIT | MAX3107_IRQEN_REG);
-			s->irqen_reg &= ~MAX3107_IRQ_TXEMPTY_BIT;
-			buf[i] |= s->irqen_reg;
-			i++;
-			len++;
-		}
-		/* Add data to send */
-		spin_lock_irqsave(&s->port.lock, flags);
-		for ( ; i < len ; i++) {
-			buf[i] = (MAX3107_WRITE_BIT | MAX3107_THR_REG);
-			buf[i] |= ((u16)xmit->buf[xmit->tail] &
-						MAX3107_SPI_TX_DATA_MASK);
-			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		}
-		spin_unlock_irqrestore(&s->port.lock, flags);
-		if (!(s->irqen_reg & MAX3107_IRQ_TXEMPTY_BIT)) {
-			/* Enable TX empty interrupt */
-			pr_debug("Enabling TE INT\n");
-			buf[i] = (MAX3107_WRITE_BIT | MAX3107_IRQEN_REG);
-			s->irqen_reg |= MAX3107_IRQ_TXEMPTY_BIT;
-			buf[i] |= s->irqen_reg;
-			i++;
-			len++;
-		}
-		if (!s->tx_enabled) {
-			/* Enable TX */
-			pr_debug("Enable TX\n");
-			buf[i] = (MAX3107_WRITE_BIT | MAX3107_MODE1_REG);
-			spin_lock_irqsave(&s->data_lock, flags);
-			s->mode1_reg &= ~MAX3107_MODE1_TXDIS_BIT;
-			buf[i] |= s->mode1_reg;
-			spin_unlock_irqrestore(&s->data_lock, flags);
-			s->tx_enabled = 1;
-			i++;
-			len++;
-		}
-
-		/* Perform the SPI transfer */
-		if (max3107_rw(s, (u8 *)buf, NULL, len*2)) {
-			dev_err(&s->spi->dev,
-				"SPI transfer TX handling failed\n");
-			return;
-		}
-	}
-
-	/* Indicate wake up if circular buffer is getting low on data */
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&s->port);
-
-}
-
-/* Handle interrupts
- * Also reads and returns current RX FIFO level
- */
-static u16 handle_interrupt(struct max3107_port *s)
-{
-	u16 buf[4];	/* Buffer for SPI transfers */
-	u8 irq_status;
-	u16 rx_level;
-	unsigned long flags;
-
-	/* Read IRQ status register */
-	buf[0] = MAX3107_IRQSTS_REG;
-	/* Read status IRQ status register */
-	buf[1] = MAX3107_STS_IRQSTS_REG;
-	/* Read LSR IRQ status register */
-	buf[2] = MAX3107_LSR_IRQSTS_REG;
-	/* Query RX level */
-	buf[3] = MAX3107_RXFIFOLVL_REG;
-
-	if (max3107_rw(s, (u8 *)buf, (u8 *)buf, 8)) {
-		dev_err(&s->spi->dev,
-			"SPI transfer for INTR handling failed\n");
-		return 0;
-	}
-
-	irq_status = (u8)buf[0];
-	pr_debug("IRQSTS %x\n", irq_status);
-	rx_level = (buf[3] & MAX3107_SPI_RX_DATA_MASK);
-
-	if (irq_status & MAX3107_IRQ_LSR_BIT) {
-		/* LSR interrupt */
-		if (buf[2] & MAX3107_LSR_RXTO_BIT)
-			/* RX timeout interrupt,
-			 * handled by normal RX handling
-			 */
-			pr_debug("RX TO INT\n");
-	}
-
-	if (irq_status & MAX3107_IRQ_TXEMPTY_BIT) {
-		/* Tx empty interrupt,
-		 * disable TX and set tx_fifo_empty flag
-		 */
-		pr_debug("TE INT, disabling TX\n");
-		buf[0] = (MAX3107_WRITE_BIT | MAX3107_MODE1_REG);
-		spin_lock_irqsave(&s->data_lock, flags);
-		s->mode1_reg |= MAX3107_MODE1_TXDIS_BIT;
-		buf[0] |= s->mode1_reg;
-		spin_unlock_irqrestore(&s->data_lock, flags);
-		if (max3107_rw(s, (u8 *)buf, NULL, 2))
-			dev_err(&s->spi->dev, "SPI transfer TX dis failed\n");
-		s->tx_enabled = 0;
-		s->tx_fifo_empty = 1;
-	}
-
-	if (irq_status & MAX3107_IRQ_RXFIFO_BIT)
-		/* RX FIFO interrupt,
-		 * handled by normal RX handling
-		 */
-		pr_debug("RFIFO INT\n");
-
-	/* Return RX level */
-	return rx_level;
-}
-
-/* Trigger work thread*/
-static void max3107_dowork(struct max3107_port *s)
-{
-	if (!work_pending(&s->work) && !freezing(current) && !s->suspended)
-		queue_work(s->workqueue, &s->work);
-	else
-		dev_warn(&s->spi->dev, "interrup isn't serviced normally!\n");
-}
-
-/* Work thread */
-static void max3107_work(struct work_struct *w)
-{
-	struct max3107_port *s = container_of(w, struct max3107_port, work);
-	u16 rxlvl = 0;
-	int len;	/* SPI transfer buffer length */
-	u16 buf[5];	/* Buffer for SPI transfers */
-	unsigned long flags;
-
-	/* Start by reading current RX FIFO level */
-	buf[0] = MAX3107_RXFIFOLVL_REG;
-	if (max3107_rw(s, (u8 *)buf, (u8 *)buf, 2)) {
-		dev_err(&s->spi->dev, "SPI transfer RX lev failed\n");
-		rxlvl = 0;
-	} else {
-		rxlvl = (buf[0] & MAX3107_SPI_RX_DATA_MASK);
-	}
-
-	do {
-		pr_debug("rxlvl %d\n", rxlvl);
-
-		/* Handle RX */
-		max3107_handlerx(s, rxlvl);
-		rxlvl = 0;
-
-		if (s->handle_irq) {
-			/* Handle pending interrupts
-			 * We also get new RX FIFO level since new data may
-			 * have been received while pushing received data to
-			 * receivers
-			 */
-			s->handle_irq = 0;
-			rxlvl = handle_interrupt(s);
-		}
-
-		/* Handle TX */
-		max3107_handletx(s);
-
-		/* Handle configuration changes */
-		len = 0;
-		spin_lock_irqsave(&s->data_lock, flags);
-		if (s->mode1_commit) {
-			pr_debug("mode1_commit\n");
-			buf[len] = (MAX3107_WRITE_BIT | MAX3107_MODE1_REG);
-			buf[len++] |= s->mode1_reg;
-			s->mode1_commit = 0;
-		}
-		if (s->lcr_commit) {
-			pr_debug("lcr_commit\n");
-			buf[len] = (MAX3107_WRITE_BIT | MAX3107_LCR_REG);
-			buf[len++] |= s->lcr_reg;
-			s->lcr_commit = 0;
-		}
-		if (s->brg_commit) {
-			pr_debug("brg_commit\n");
-			buf[len] = (MAX3107_WRITE_BIT | MAX3107_BRGDIVMSB_REG);
-			buf[len++] |= ((s->brg_cfg >> 16) &
-						MAX3107_SPI_TX_DATA_MASK);
-			buf[len] = (MAX3107_WRITE_BIT | MAX3107_BRGDIVLSB_REG);
-			buf[len++] |= ((s->brg_cfg >> 8) &
-						MAX3107_SPI_TX_DATA_MASK);
-			buf[len] = (MAX3107_WRITE_BIT | MAX3107_BRGCFG_REG);
-			buf[len++] |= ((s->brg_cfg) & 0xff);
-			s->brg_commit = 0;
-		}
-		spin_unlock_irqrestore(&s->data_lock, flags);
-
-		if (len > 0) {
-			if (max3107_rw(s, (u8 *)buf, NULL, len * 2))
-				dev_err(&s->spi->dev,
-					"SPI transfer config failed\n");
-		}
-
-		/* Reloop if interrupt handling indicated data in RX FIFO */
-	} while (rxlvl);
-
-}
-
-/* Set sleep mode */
-static void max3107_set_sleep(struct max3107_port *s, int mode)
-{
-	u16 buf[1];	/* Buffer for SPI transfer */
-	unsigned long flags;
-	pr_debug("enter, mode %d\n", mode);
-
-	buf[0] = (MAX3107_WRITE_BIT | MAX3107_MODE1_REG);
-	spin_lock_irqsave(&s->data_lock, flags);
-	switch (mode) {
-	case MAX3107_DISABLE_FORCED_SLEEP:
-			s->mode1_reg &= ~MAX3107_MODE1_FORCESLEEP_BIT;
-			break;
-	case MAX3107_ENABLE_FORCED_SLEEP:
-			s->mode1_reg |= MAX3107_MODE1_FORCESLEEP_BIT;
-			break;
-	case MAX3107_DISABLE_AUTOSLEEP:
-			s->mode1_reg &= ~MAX3107_MODE1_AUTOSLEEP_BIT;
-			break;
-	case MAX3107_ENABLE_AUTOSLEEP:
-			s->mode1_reg |= MAX3107_MODE1_AUTOSLEEP_BIT;
-			break;
-	default:
-		spin_unlock_irqrestore(&s->data_lock, flags);
-		dev_warn(&s->spi->dev, "invalid sleep mode\n");
-		return;
-	}
-	buf[0] |= s->mode1_reg;
-	spin_unlock_irqrestore(&s->data_lock, flags);
-
-	if (max3107_rw(s, (u8 *)buf, NULL, 2))
-		dev_err(&s->spi->dev, "SPI transfer sleep mode failed\n");
-
-	if (mode == MAX3107_DISABLE_AUTOSLEEP ||
-			mode == MAX3107_DISABLE_FORCED_SLEEP)
-		msleep(MAX3107_WAKEUP_DELAY);
-}
-
-/* Perform full register initialization */
-static void max3107_register_init(struct max3107_port *s)
-{
-	u16 buf[11];	/* Buffer for SPI transfers */
-
-	/* 1. Configure baud rate, 9600 as default */
-	s->baud = 9600;
-	/* the below is default*/
-	if (s->ext_clk) {
-		s->brg_cfg = MAX3107_BRG26_B9600;
-		s->baud_tbl = (struct baud_table *)brg26_ext;
-	} else {
-		s->brg_cfg = MAX3107_BRG13_IB9600;
-		s->baud_tbl = (struct baud_table *)brg13_int;
-	}
-
-	if (s->pdata->init)
-		s->pdata->init(s);
-
-	buf[0] = (MAX3107_WRITE_BIT | MAX3107_BRGDIVMSB_REG)
-		| ((s->brg_cfg >> 16) & MAX3107_SPI_TX_DATA_MASK);
-	buf[1] = (MAX3107_WRITE_BIT | MAX3107_BRGDIVLSB_REG)
-		| ((s->brg_cfg >> 8) & MAX3107_SPI_TX_DATA_MASK);
-	buf[2] = (MAX3107_WRITE_BIT | MAX3107_BRGCFG_REG)
-		| ((s->brg_cfg) & 0xff);
-
-	/* 2. Configure LCR register, 8N1 mode by default */
-	s->lcr_reg = MAX3107_LCR_WORD_LEN_8;
-	buf[3] = (MAX3107_WRITE_BIT | MAX3107_LCR_REG)
-		| s->lcr_reg;
-
-	/* 3. Configure MODE 1 register */
-	s->mode1_reg = 0;
-	/* Enable IRQ pin */
-	s->mode1_reg |= MAX3107_MODE1_IRQSEL_BIT;
-	/* Disable TX */
-	s->mode1_reg |= MAX3107_MODE1_TXDIS_BIT;
-	s->tx_enabled = 0;
-	/* RX is enabled */
-	s->rx_enabled = 1;
-	buf[4] = (MAX3107_WRITE_BIT | MAX3107_MODE1_REG)
-		| s->mode1_reg;
-
-	/* 4. Configure MODE 2 register */
-	buf[5] = (MAX3107_WRITE_BIT | MAX3107_MODE2_REG);
-	if (s->loopback) {
-		/* Enable loopback */
-		buf[5] |= MAX3107_MODE2_LOOPBACK_BIT;
-	}
-	/* Reset FIFOs */
-	buf[5] |= MAX3107_MODE2_FIFORST_BIT;
-	s->tx_fifo_empty = 1;
-
-	/* 5. Configure FIFO trigger level register */
-	buf[6] = (MAX3107_WRITE_BIT | MAX3107_FIFOTRIGLVL_REG);
-	/* RX FIFO trigger for 16 words, TX FIFO trigger not used */
-	buf[6] |= (MAX3107_FIFOTRIGLVL_RX(16) | MAX3107_FIFOTRIGLVL_TX(0));
-
-	/* 6. Configure flow control levels */
-	buf[7] = (MAX3107_WRITE_BIT | MAX3107_FLOWLVL_REG);
-	/* Flow control halt level 96, resume level 48 */
-	buf[7] |= (MAX3107_FLOWLVL_RES(48) | MAX3107_FLOWLVL_HALT(96));
-
-	/* 7. Configure flow control */
-	buf[8] = (MAX3107_WRITE_BIT | MAX3107_FLOWCTRL_REG);
-	/* Enable auto CTS and auto RTS flow control */
-	buf[8] |= (MAX3107_FLOWCTRL_AUTOCTS_BIT | MAX3107_FLOWCTRL_AUTORTS_BIT);
-
-	/* 8. Configure RX timeout register */
-	buf[9] = (MAX3107_WRITE_BIT | MAX3107_RXTO_REG);
-	/* Timeout after 48 character intervals */
-	buf[9] |= 0x0030;
-
-	/* 9. Configure LSR interrupt enable register */
-	buf[10] = (MAX3107_WRITE_BIT | MAX3107_LSR_IRQEN_REG);
-	/* Enable RX timeout interrupt */
-	buf[10] |= MAX3107_LSR_RXTO_BIT;
-
-	/* Perform SPI transfer */
-	if (max3107_rw(s, (u8 *)buf, NULL, 22))
-		dev_err(&s->spi->dev, "SPI transfer for init failed\n");
-
-	/* 10. Clear IRQ status register by reading it */
-	buf[0] = MAX3107_IRQSTS_REG;
-
-	/* 11. Configure interrupt enable register */
-	/* Enable LSR interrupt */
-	s->irqen_reg = MAX3107_IRQ_LSR_BIT;
-	/* Enable RX FIFO interrupt */
-	s->irqen_reg |= MAX3107_IRQ_RXFIFO_BIT;
-	buf[1] = (MAX3107_WRITE_BIT | MAX3107_IRQEN_REG)
-		| s->irqen_reg;
-
-	/* 12. Clear FIFO reset that was set in step 6 */
-	buf[2] = (MAX3107_WRITE_BIT | MAX3107_MODE2_REG);
-	if (s->loopback) {
-		/* Keep loopback enabled */
-		buf[2] |= MAX3107_MODE2_LOOPBACK_BIT;
-	}
-
-	/* Perform SPI transfer */
-	if (max3107_rw(s, (u8 *)buf, (u8 *)buf, 6))
-		dev_err(&s->spi->dev, "SPI transfer for init failed\n");
-
-}
-
-/* IRQ handler */
-static irqreturn_t max3107_irq(int irqno, void *dev_id)
-{
-	struct max3107_port *s = dev_id;
-
-	if (irqno != s->spi->irq) {
-		/* Unexpected IRQ */
-		return IRQ_NONE;
-	}
-
-	/* Indicate irq */
-	s->handle_irq = 1;
-
-	/* Trigger work thread */
-	max3107_dowork(s);
-
-	return IRQ_HANDLED;
-}
-
-/* HW suspension function
- *
- * Currently autosleep is used to decrease current consumption, alternative
- * approach would be to set the chip to reset mode if UART is not being
- * used but that would mess the GPIOs
- *
- */
-void max3107_hw_susp(struct max3107_port *s, int suspend)
-{
-	pr_debug("enter, suspend %d\n", suspend);
-
-	if (suspend) {
-		/* Suspend requested,
-		 * enable autosleep to decrease current consumption
-		 */
-		s->suspended = 1;
-		max3107_set_sleep(s, MAX3107_ENABLE_AUTOSLEEP);
-	} else {
-		/* Resume requested,
-		 * disable autosleep
-		 */
-		s->suspended = 0;
-		max3107_set_sleep(s, MAX3107_DISABLE_AUTOSLEEP);
-	}
-}
-EXPORT_SYMBOL_GPL(max3107_hw_susp);
-
-/* Modem status IRQ enabling */
-static void max3107_enable_ms(struct uart_port *port)
-{
-	/* Modem status not supported */
-}
-
-/* Data send function */
-static void max3107_start_tx(struct uart_port *port)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-
-	/* Trigger work thread for sending data */
-	max3107_dowork(s);
-}
-
-/* Function for checking that there is no pending transfers */
-static unsigned int max3107_tx_empty(struct uart_port *port)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-
-	pr_debug("returning %d\n",
-		  (s->tx_fifo_empty && uart_circ_empty(&s->port.state->xmit)));
-	return s->tx_fifo_empty && uart_circ_empty(&s->port.state->xmit);
-}
-
-/* Function for stopping RX */
-static void max3107_stop_rx(struct uart_port *port)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-	unsigned long flags;
-
-	/* Set RX disabled in MODE 1 register */
-	spin_lock_irqsave(&s->data_lock, flags);
-	s->mode1_reg |= MAX3107_MODE1_RXDIS_BIT;
-	s->mode1_commit = 1;
-	spin_unlock_irqrestore(&s->data_lock, flags);
-	/* Set RX disabled */
-	s->rx_enabled = 0;
-	/* Trigger work thread for doing the actual configuration change */
-	max3107_dowork(s);
-}
-
-/* Function for returning control pin states */
-static unsigned int max3107_get_mctrl(struct uart_port *port)
-{
-	/* DCD and DSR are not wired and CTS/RTS is handled automatically
-	 * so just indicate DSR and CAR asserted
-	 */
-	return TIOCM_DSR | TIOCM_CAR;
-}
-
-/* Function for setting control pin states */
-static void max3107_set_mctrl(struct uart_port *port, unsigned int mctrl)
-{
-	/* DCD and DSR are not wired and CTS/RTS is hadnled automatically
-	 * so do nothing
-	 */
-}
-
-/* Function for configuring UART parameters */
-static void max3107_set_termios(struct uart_port *port,
-				struct ktermios *termios,
-				struct ktermios *old)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-	struct tty_struct *tty;
-	int baud;
-	u16 new_lcr = 0;
-	u32 new_brg = 0;
-	unsigned long flags;
-
-	if (!port->state)
-		return;
-
-	tty = port->state->port.tty;
-	if (!tty)
-		return;
-
-	/* Get new LCR register values */
-	/* Word size */
-	if ((termios->c_cflag & CSIZE) == CS7)
-		new_lcr |= MAX3107_LCR_WORD_LEN_7;
-	else
-		new_lcr |= MAX3107_LCR_WORD_LEN_8;
-
-	/* Parity */
-	if (termios->c_cflag & PARENB) {
-		new_lcr |= MAX3107_LCR_PARITY_BIT;
-		if (!(termios->c_cflag & PARODD))
-			new_lcr |= MAX3107_LCR_EVENPARITY_BIT;
-	}
-
-	/* Stop bits */
-	if (termios->c_cflag & CSTOPB) {
-		/* 2 stop bits */
-		new_lcr |= MAX3107_LCR_STOPLEN_BIT;
-	}
-
-	/* Mask termios capabilities we don't support */
-	termios->c_cflag &= ~CMSPAR;
-
-	/* Set status ignore mask */
-	s->port.ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		s->port.ignore_status_mask |= MAX3107_ALL_ERRORS;
-
-	/* Set low latency to immediately handle pushed data */
-	s->port.state->port.tty->low_latency = 1;
-
-	/* Get new baud rate generator configuration */
-	baud = tty_get_baud_rate(tty);
-
-	spin_lock_irqsave(&s->data_lock, flags);
-	new_brg = get_new_brg(baud, s);
-	/* if can't find the corrent config, use previous */
-	if (!new_brg) {
-		baud = s->baud;
-		new_brg = s->brg_cfg;
-	}
-	spin_unlock_irqrestore(&s->data_lock, flags);
-	tty_termios_encode_baud_rate(termios, baud, baud);
-	s->baud = baud;
-
-	/* Update timeout according to new baud rate */
-	uart_update_timeout(port, termios->c_cflag, baud);
-
-	spin_lock_irqsave(&s->data_lock, flags);
-	if (s->lcr_reg != new_lcr) {
-		s->lcr_reg = new_lcr;
-		s->lcr_commit = 1;
-	}
-	if (s->brg_cfg != new_brg) {
-		s->brg_cfg = new_brg;
-		s->brg_commit = 1;
-	}
-	spin_unlock_irqrestore(&s->data_lock, flags);
-
-	/* Trigger work thread for doing the actual configuration change */
-	max3107_dowork(s);
-}
-
-/* Port shutdown function */
-static void max3107_shutdown(struct uart_port *port)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-
-	if (s->suspended && s->pdata->hw_suspend)
-		s->pdata->hw_suspend(s, 0);
-
-	/* Free the interrupt */
-	free_irq(s->spi->irq, s);
-
-	if (s->workqueue) {
-		/* Flush and destroy work queue */
-		flush_workqueue(s->workqueue);
-		destroy_workqueue(s->workqueue);
-		s->workqueue = NULL;
-	}
-
-	/* Suspend HW */
-	if (s->pdata->hw_suspend)
-		s->pdata->hw_suspend(s, 1);
-}
-
-/* Port startup function */
-static int max3107_startup(struct uart_port *port)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-
-	/* Initialize work queue */
-	s->workqueue = create_freezable_workqueue("max3107");
-	if (!s->workqueue) {
-		dev_err(&s->spi->dev, "Workqueue creation failed\n");
-		return -EBUSY;
-	}
-	INIT_WORK(&s->work, max3107_work);
-
-	/* Setup IRQ */
-	if (request_irq(s->spi->irq, max3107_irq, IRQF_TRIGGER_FALLING,
-			"max3107", s)) {
-		dev_err(&s->spi->dev, "IRQ reguest failed\n");
-		destroy_workqueue(s->workqueue);
-		s->workqueue = NULL;
-		return -EBUSY;
-	}
-
-	/* Resume HW */
-	if (s->pdata->hw_suspend)
-		s->pdata->hw_suspend(s, 0);
-
-	/* Init registers */
-	max3107_register_init(s);
-
-	return 0;
-}
-
-/* Port type function */
-static const char *max3107_type(struct uart_port *port)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-	return s->spi->modalias;
-}
-
-/* Port release function */
-static void max3107_release_port(struct uart_port *port)
-{
-	/* Do nothing */
-}
-
-/* Port request function */
-static int max3107_request_port(struct uart_port *port)
-{
-	/* Do nothing */
-	return 0;
-}
-
-/* Port config function */
-static void max3107_config_port(struct uart_port *port, int flags)
-{
-	struct max3107_port *s = container_of(port, struct max3107_port, port);
-	s->port.type = PORT_MAX3107;
-}
-
-/* Port verify function */
-static int max3107_verify_port(struct uart_port *port,
-				struct serial_struct *ser)
-{
-	if (ser->type == PORT_UNKNOWN || ser->type == PORT_MAX3107)
-		return 0;
-
-	return -EINVAL;
-}
-
-/* Port stop TX function */
-static void max3107_stop_tx(struct uart_port *port)
-{
-	/* Do nothing */
-}
-
-/* Port break control function */
-static void max3107_break_ctl(struct uart_port *port, int break_state)
-{
-	/* We don't support break control, do nothing */
-}
-
-
-/* Port functions */
-static struct uart_ops max3107_ops = {
-	.tx_empty       = max3107_tx_empty,
-	.set_mctrl      = max3107_set_mctrl,
-	.get_mctrl      = max3107_get_mctrl,
-	.stop_tx        = max3107_stop_tx,
-	.start_tx       = max3107_start_tx,
-	.stop_rx        = max3107_stop_rx,
-	.enable_ms      = max3107_enable_ms,
-	.break_ctl      = max3107_break_ctl,
-	.startup        = max3107_startup,
-	.shutdown       = max3107_shutdown,
-	.set_termios    = max3107_set_termios,
-	.type           = max3107_type,
-	.release_port   = max3107_release_port,
-	.request_port   = max3107_request_port,
-	.config_port    = max3107_config_port,
-	.verify_port    = max3107_verify_port,
-};
-
-/* UART driver data */
-static struct uart_driver max3107_uart_driver = {
-	.owner          = THIS_MODULE,
-	.driver_name    = "ttyMAX",
-	.dev_name       = "ttyMAX",
-	.nr             = 1,
-};
-
-static int driver_registered = 0;
-
-
-
-/* 'Generic' platform data */
-static struct max3107_plat generic_plat_data = {
-	.loopback               = 0,
-	.ext_clk                = 1,
-	.hw_suspend		= max3107_hw_susp,
-	.polled_mode            = 0,
-	.poll_time              = 0,
-};
-
-
-/*******************************************************************/
-
-/**
- *	max3107_probe		-	SPI bus probe entry point
- *	@spi: the spi device
- *
- *	SPI wants us to probe this device and if appropriate claim it.
- *	Perform any platform specific requirements and then initialise
- *	the device.
- */
-
-int max3107_probe(struct spi_device *spi, struct max3107_plat *pdata)
-{
-	struct max3107_port *s;
-	u16 buf[2];	/* Buffer for SPI transfers */
-	int retval;
-
-	pr_info("enter max3107 probe\n");
-
-	/* Allocate port structure */
-	s = kzalloc(sizeof(*s), GFP_KERNEL);
-	if (!s) {
-		pr_err("Allocating port structure failed\n");
-		return -ENOMEM;
-	}
-
-	s->pdata = pdata;
-
-	/* SPI Rx buffer
-	 * +2 for RX FIFO interrupt
-	 * disabling and RX level query
-	 */
-	s->rxbuf = kzalloc(sizeof(u16) * (MAX3107_RX_FIFO_SIZE+2), GFP_KERNEL);
-	if (!s->rxbuf) {
-		pr_err("Allocating RX buffer failed\n");
-		retval = -ENOMEM;
-		goto err_free4;
-	}
-	s->rxstr = kzalloc(sizeof(u8) * MAX3107_RX_FIFO_SIZE, GFP_KERNEL);
-	if (!s->rxstr) {
-		pr_err("Allocating RX buffer failed\n");
-		retval = -ENOMEM;
-		goto err_free3;
-	}
-	/* SPI Tx buffer
-	 * SPI transfer buffer
-	 * +3 for TX FIFO empty
-	 * interrupt disabling and
-	 * enabling and TX enabling
-	 */
-	s->txbuf = kzalloc(sizeof(u16) * MAX3107_TX_FIFO_SIZE + 3, GFP_KERNEL);
-	if (!s->txbuf) {
-		pr_err("Allocating TX buffer failed\n");
-		retval = -ENOMEM;
-		goto err_free2;
-	}
-	/* Initialize shared data lock */
-	spin_lock_init(&s->data_lock);
-
-	/* SPI intializations */
-	dev_set_drvdata(&spi->dev, s);
-	spi->mode = SPI_MODE_0;
-	spi->dev.platform_data = pdata;
-	spi->bits_per_word = 16;
-	s->ext_clk = pdata->ext_clk;
-	s->loopback = pdata->loopback;
-	spi_setup(spi);
-	s->spi = spi;
-
-	/* Check REV ID to ensure we are talking to what we expect */
-	buf[0] = MAX3107_REVID_REG;
-	if (max3107_rw(s, (u8 *)buf, (u8 *)buf, 2)) {
-		dev_err(&s->spi->dev, "SPI transfer for REVID read failed\n");
-		retval = -EIO;
-		goto err_free1;
-	}
-	if ((buf[0] & MAX3107_SPI_RX_DATA_MASK) != MAX3107_REVID1 &&
-		(buf[0] & MAX3107_SPI_RX_DATA_MASK) != MAX3107_REVID2) {
-		dev_err(&s->spi->dev, "REVID %x does not match\n",
-				(buf[0] & MAX3107_SPI_RX_DATA_MASK));
-		retval = -ENODEV;
-		goto err_free1;
-	}
-
-	/* Disable all interrupts */
-	buf[0] = (MAX3107_WRITE_BIT | MAX3107_IRQEN_REG | 0x0000);
-	buf[0] |= 0x0000;
-
-	/* Configure clock source */
-	buf[1] = (MAX3107_WRITE_BIT | MAX3107_CLKSRC_REG);
-	if (s->ext_clk) {
-		/* External clock */
-		buf[1] |= MAX3107_CLKSRC_EXTCLK_BIT;
-	}
-
-	/* PLL bypass ON */
-	buf[1] |= MAX3107_CLKSRC_PLLBYP_BIT;
-
-	/* Perform SPI transfer */
-	if (max3107_rw(s, (u8 *)buf, NULL, 4)) {
-		dev_err(&s->spi->dev, "SPI transfer for init failed\n");
-		retval = -EIO;
-		goto err_free1;
-	}
-
-	/* Register UART driver */
-	if (!driver_registered) {
-		retval = uart_register_driver(&max3107_uart_driver);
-		if (retval) {
-			dev_err(&s->spi->dev, "Registering UART driver failed\n");
-			goto err_free1;
-		}
-		driver_registered = 1;
-	}
-
-	/* Initialize UART port data */
-	s->port.fifosize = 128;
-	s->port.ops = &max3107_ops;
-	s->port.line = 0;
-	s->port.dev = &spi->dev;
-	s->port.uartclk = 9600;
-	s->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-	s->port.irq = s->spi->irq;
-	s->port.type = PORT_MAX3107;
-
-	/* Add UART port */
-	retval = uart_add_one_port(&max3107_uart_driver, &s->port);
-	if (retval < 0) {
-		dev_err(&s->spi->dev, "Adding UART port failed\n");
-		goto err_free1;
-	}
-
-	if (pdata->configure) {
-		retval = pdata->configure(s);
-		if (retval < 0)
-			goto err_free1;
-	}
-
-	/* Go to suspend mode */
-	if (pdata->hw_suspend)
-		pdata->hw_suspend(s, 1);
-
-	return 0;
-
-err_free1:
-	kfree(s->txbuf);
-err_free2:
-	kfree(s->rxstr);
-err_free3:
-	kfree(s->rxbuf);
-err_free4:
-	kfree(s);
-	return retval;
-}
-EXPORT_SYMBOL_GPL(max3107_probe);
-
-/* Driver remove function */
-int max3107_remove(struct spi_device *spi)
-{
-	struct max3107_port *s = dev_get_drvdata(&spi->dev);
-
-	pr_info("enter max3107 remove\n");
-
-	/* Remove port */
-	if (uart_remove_one_port(&max3107_uart_driver, &s->port))
-		dev_warn(&s->spi->dev, "Removing UART port failed\n");
-
-
-	/* Free TxRx buffer */
-	kfree(s->rxbuf);
-	kfree(s->rxstr);
-	kfree(s->txbuf);
-
-	/* Free port structure */
-	kfree(s);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(max3107_remove);
-
-/* Driver suspend function */
-int max3107_suspend(struct spi_device *spi, pm_message_t state)
-{
-#ifdef CONFIG_PM
-	struct max3107_port *s = dev_get_drvdata(&spi->dev);
-
-	pr_debug("enter suspend\n");
-
-	/* Suspend UART port */
-	uart_suspend_port(&max3107_uart_driver, &s->port);
-
-	/* Go to suspend mode */
-	if (s->pdata->hw_suspend)
-		s->pdata->hw_suspend(s, 1);
-#endif	/* CONFIG_PM */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(max3107_suspend);
-
-/* Driver resume function */
-int max3107_resume(struct spi_device *spi)
-{
-#ifdef CONFIG_PM
-	struct max3107_port *s = dev_get_drvdata(&spi->dev);
-
-	pr_debug("enter resume\n");
-
-	/* Resume from suspend */
-	if (s->pdata->hw_suspend)
-		s->pdata->hw_suspend(s, 0);
-
-	/* Resume UART port */
-	uart_resume_port(&max3107_uart_driver, &s->port);
-#endif	/* CONFIG_PM */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(max3107_resume);
-
-static int max3107_probe_generic(struct spi_device *spi)
-{
-	return max3107_probe(spi, &generic_plat_data);
-}
-
-/* Spi driver data */
-static struct spi_driver max3107_driver = {
-	.driver = {
-		.name		= "max3107",
-		.owner		= THIS_MODULE,
-	},
-	.probe		= max3107_probe_generic,
-	.remove		= __devexit_p(max3107_remove),
-	.suspend	= max3107_suspend,
-	.resume		= max3107_resume,
-};
-
-/* Driver init function */
-static int __init max3107_init(void)
-{
-	pr_info("enter max3107 init\n");
-	return spi_register_driver(&max3107_driver);
-}
-
-/* Driver exit function */
-static void __exit max3107_exit(void)
-{
-	pr_info("enter max3107 exit\n");
-	/* Unregister UART driver */
-	if (driver_registered)
-		uart_unregister_driver(&max3107_uart_driver);
-	spi_unregister_driver(&max3107_driver);
-}
-
-module_init(max3107_init);
-module_exit(max3107_exit);
-
-MODULE_DESCRIPTION("MAX3107 driver");
-MODULE_AUTHOR("Aavamobile");
-MODULE_ALIAS("spi:max3107");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/max3107.h b/drivers/tty/serial/max3107.h
deleted file mode 100644
index 8415fc7..0000000
--- a/drivers/tty/serial/max3107.h
+++ /dev/null
@@ -1,441 +0,0 @@
-/*
- * max3107.h - spi uart protocol driver header for Maxim 3107
- *
- * Copyright (C) Aavamobile 2009
- * Based on serial_max3100.h by Christian Pellegrin
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef _MAX3107_H
-#define _MAX3107_H
-
-/* Serial error status definitions */
-#define MAX3107_PARITY_ERROR	1
-#define MAX3107_FRAME_ERROR	2
-#define MAX3107_OVERRUN_ERROR	4
-#define MAX3107_ALL_ERRORS	(MAX3107_PARITY_ERROR | \
-				 MAX3107_FRAME_ERROR | \
-				 MAX3107_OVERRUN_ERROR)
-
-/* GPIO definitions */
-#define MAX3107_GPIO_BASE	88
-#define MAX3107_GPIO_COUNT	4
-
-
-/* GPIO connected to chip's reset pin */
-#define MAX3107_RESET_GPIO	87
-
-
-/* Chip reset delay */
-#define MAX3107_RESET_DELAY	10
-
-/* Chip wakeup delay */
-#define MAX3107_WAKEUP_DELAY	50
-
-
-/* Sleep mode definitions */
-#define MAX3107_DISABLE_FORCED_SLEEP	0
-#define MAX3107_ENABLE_FORCED_SLEEP	1
-#define MAX3107_DISABLE_AUTOSLEEP	2
-#define MAX3107_ENABLE_AUTOSLEEP	3
-
-
-/* Definitions for register access with SPI transfers
- *
- * SPI transfer format:
- *
- * Master to slave bits xzzzzzzzyyyyyyyy
- * Slave to master bits aaaaaaaabbbbbbbb
- *
- * where:
- * x = 0 for reads, 1 for writes
- * z = register address
- * y = new register value if write, 0 if read
- * a = unspecified
- * b = register value if read, unspecified if write
- */
-
-/* SPI speed */
-#define MAX3107_SPI_SPEED	(3125000 * 2)
-
-/* Write bit */
-#define MAX3107_WRITE_BIT	(1 << 15)
-
-/* SPI TX data mask */
-#define MAX3107_SPI_RX_DATA_MASK	(0x00ff)
-
-/* SPI RX data mask */
-#define MAX3107_SPI_TX_DATA_MASK	(0x00ff)
-
-/* Register access masks */
-#define MAX3107_RHR_REG			(0x0000) /* RX FIFO */
-#define MAX3107_THR_REG			(0x0000) /* TX FIFO */
-#define MAX3107_IRQEN_REG		(0x0100) /* IRQ enable */
-#define MAX3107_IRQSTS_REG		(0x0200) /* IRQ status */
-#define MAX3107_LSR_IRQEN_REG		(0x0300) /* LSR IRQ enable */
-#define MAX3107_LSR_IRQSTS_REG		(0x0400) /* LSR IRQ status */
-#define MAX3107_SPCHR_IRQEN_REG		(0x0500) /* Special char IRQ enable */
-#define MAX3107_SPCHR_IRQSTS_REG	(0x0600) /* Special char IRQ status */
-#define MAX3107_STS_IRQEN_REG		(0x0700) /* Status IRQ enable */
-#define MAX3107_STS_IRQSTS_REG		(0x0800) /* Status IRQ status */
-#define MAX3107_MODE1_REG		(0x0900) /* MODE1 */
-#define MAX3107_MODE2_REG		(0x0a00) /* MODE2 */
-#define MAX3107_LCR_REG			(0x0b00) /* LCR */
-#define MAX3107_RXTO_REG		(0x0c00) /* RX timeout */
-#define MAX3107_HDPIXDELAY_REG		(0x0d00) /* Auto transceiver delays */
-#define MAX3107_IRDA_REG		(0x0e00) /* IRDA settings */
-#define MAX3107_FLOWLVL_REG		(0x0f00) /* Flow control levels */
-#define MAX3107_FIFOTRIGLVL_REG		(0x1000) /* FIFO IRQ trigger levels */
-#define MAX3107_TXFIFOLVL_REG		(0x1100) /* TX FIFO level */
-#define MAX3107_RXFIFOLVL_REG		(0x1200) /* RX FIFO level */
-#define MAX3107_FLOWCTRL_REG		(0x1300) /* Flow control */
-#define MAX3107_XON1_REG		(0x1400) /* XON1 character */
-#define MAX3107_XON2_REG		(0x1500) /* XON2 character */
-#define MAX3107_XOFF1_REG		(0x1600) /* XOFF1 character */
-#define MAX3107_XOFF2_REG		(0x1700) /* XOFF2 character */
-#define MAX3107_GPIOCFG_REG		(0x1800) /* GPIO config */
-#define MAX3107_GPIODATA_REG		(0x1900) /* GPIO data */
-#define MAX3107_PLLCFG_REG		(0x1a00) /* PLL config */
-#define MAX3107_BRGCFG_REG		(0x1b00) /* Baud rate generator conf */
-#define MAX3107_BRGDIVLSB_REG		(0x1c00) /* Baud rate divisor LSB */
-#define MAX3107_BRGDIVMSB_REG		(0x1d00) /* Baud rate divisor MSB */
-#define MAX3107_CLKSRC_REG		(0x1e00) /* Clock source */
-#define MAX3107_REVID_REG		(0x1f00) /* Revision identification */
-
-/* IRQ register bits */
-#define MAX3107_IRQ_LSR_BIT	(1 << 0) /* LSR interrupt */
-#define MAX3107_IRQ_SPCHR_BIT	(1 << 1) /* Special char interrupt */
-#define MAX3107_IRQ_STS_BIT	(1 << 2) /* Status interrupt */
-#define MAX3107_IRQ_RXFIFO_BIT	(1 << 3) /* RX FIFO interrupt */
-#define MAX3107_IRQ_TXFIFO_BIT	(1 << 4) /* TX FIFO interrupt */
-#define MAX3107_IRQ_TXEMPTY_BIT	(1 << 5) /* TX FIFO empty interrupt */
-#define MAX3107_IRQ_RXEMPTY_BIT	(1 << 6) /* RX FIFO empty interrupt */
-#define MAX3107_IRQ_CTS_BIT	(1 << 7) /* CTS interrupt */
-
-/* LSR register bits */
-#define MAX3107_LSR_RXTO_BIT	(1 << 0) /* RX timeout */
-#define MAX3107_LSR_RXOVR_BIT	(1 << 1) /* RX overrun */
-#define MAX3107_LSR_RXPAR_BIT	(1 << 2) /* RX parity error */
-#define MAX3107_LSR_FRERR_BIT	(1 << 3) /* Frame error */
-#define MAX3107_LSR_RXBRK_BIT	(1 << 4) /* RX break */
-#define MAX3107_LSR_RXNOISE_BIT	(1 << 5) /* RX noise */
-#define MAX3107_LSR_UNDEF6_BIT	(1 << 6) /* Undefined/not used */
-#define MAX3107_LSR_CTS_BIT	(1 << 7) /* CTS pin state */
-
-/* Special character register bits */
-#define MAX3107_SPCHR_XON1_BIT		(1 << 0) /* XON1 character */
-#define MAX3107_SPCHR_XON2_BIT		(1 << 1) /* XON2 character */
-#define MAX3107_SPCHR_XOFF1_BIT		(1 << 2) /* XOFF1 character */
-#define MAX3107_SPCHR_XOFF2_BIT		(1 << 3) /* XOFF2 character */
-#define MAX3107_SPCHR_BREAK_BIT		(1 << 4) /* RX break */
-#define MAX3107_SPCHR_MULTIDROP_BIT	(1 << 5) /* 9-bit multidrop addr char */
-#define MAX3107_SPCHR_UNDEF6_BIT	(1 << 6) /* Undefined/not used */
-#define MAX3107_SPCHR_UNDEF7_BIT	(1 << 7) /* Undefined/not used */
-
-/* Status register bits */
-#define MAX3107_STS_GPIO0_BIT		(1 << 0) /* GPIO 0 interrupt */
-#define MAX3107_STS_GPIO1_BIT		(1 << 1) /* GPIO 1 interrupt */
-#define MAX3107_STS_GPIO2_BIT		(1 << 2) /* GPIO 2 interrupt */
-#define MAX3107_STS_GPIO3_BIT		(1 << 3) /* GPIO 3 interrupt */
-#define MAX3107_STS_UNDEF4_BIT		(1 << 4) /* Undefined/not used */
-#define MAX3107_STS_CLKREADY_BIT	(1 << 5) /* Clock ready */
-#define MAX3107_STS_SLEEP_BIT		(1 << 6) /* Sleep interrupt */
-#define MAX3107_STS_UNDEF7_BIT		(1 << 7) /* Undefined/not used */
-
-/* MODE1 register bits */
-#define MAX3107_MODE1_RXDIS_BIT		(1 << 0) /* RX disable */
-#define MAX3107_MODE1_TXDIS_BIT		(1 << 1) /* TX disable */
-#define MAX3107_MODE1_TXHIZ_BIT		(1 << 2) /* TX pin three-state */
-#define MAX3107_MODE1_RTSHIZ_BIT	(1 << 3) /* RTS pin three-state */
-#define MAX3107_MODE1_TRNSCVCTRL_BIT	(1 << 4) /* Transceiver ctrl enable */
-#define MAX3107_MODE1_FORCESLEEP_BIT	(1 << 5) /* Force sleep mode */
-#define MAX3107_MODE1_AUTOSLEEP_BIT	(1 << 6) /* Auto sleep enable */
-#define MAX3107_MODE1_IRQSEL_BIT	(1 << 7) /* IRQ pin enable */
-
-/* MODE2 register bits */
-#define MAX3107_MODE2_RST_BIT		(1 << 0) /* Chip reset */
-#define MAX3107_MODE2_FIFORST_BIT	(1 << 1) /* FIFO reset */
-#define MAX3107_MODE2_RXTRIGINV_BIT	(1 << 2) /* RX FIFO INT invert */
-#define MAX3107_MODE2_RXEMPTINV_BIT	(1 << 3) /* RX FIFO empty INT invert */
-#define MAX3107_MODE2_SPCHR_BIT		(1 << 4) /* Special chr detect enable */
-#define MAX3107_MODE2_LOOPBACK_BIT	(1 << 5) /* Internal loopback enable */
-#define MAX3107_MODE2_MULTIDROP_BIT	(1 << 6) /* 9-bit multidrop enable */
-#define MAX3107_MODE2_ECHOSUPR_BIT	(1 << 7) /* ECHO suppression enable */
-
-/* LCR register bits */
-#define MAX3107_LCR_LENGTH0_BIT		(1 << 0) /* Word length bit 0 */
-#define MAX3107_LCR_LENGTH1_BIT		(1 << 1) /* Word length bit 1
-						  *
-						  * Word length bits table:
-						  * 00 -> 5 bit words
-						  * 01 -> 6 bit words
-						  * 10 -> 7 bit words
-						  * 11 -> 8 bit words
-						  */
-#define MAX3107_LCR_STOPLEN_BIT		(1 << 2) /* STOP length bit
-						  *
-						  * STOP length bit table:
-						  * 0 -> 1 stop bit
-						  * 1 -> 1-1.5 stop bits if
-						  *      word length is 5,
-						  *      2 stop bits otherwise
-						  */
-#define MAX3107_LCR_PARITY_BIT		(1 << 3) /* Parity bit enable */
-#define MAX3107_LCR_EVENPARITY_BIT	(1 << 4) /* Even parity bit enable */
-#define MAX3107_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
-#define MAX3107_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
-#define MAX3107_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
-#define MAX3107_LCR_WORD_LEN_5		(0x0000)
-#define MAX3107_LCR_WORD_LEN_6		(0x0001)
-#define MAX3107_LCR_WORD_LEN_7		(0x0002)
-#define MAX3107_LCR_WORD_LEN_8		(0x0003)
-
-
-/* IRDA register bits */
-#define MAX3107_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
-#define MAX3107_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
-#define MAX3107_IRDA_SHORTIR_BIT	(1 << 2) /* Short SIR mode enable */
-#define MAX3107_IRDA_MIR_BIT		(1 << 3) /* MIR mode enable */
-#define MAX3107_IRDA_RXINV_BIT		(1 << 4) /* RX logic inversion enable */
-#define MAX3107_IRDA_TXINV_BIT		(1 << 5) /* TX logic inversion enable */
-#define MAX3107_IRDA_UNDEF6_BIT		(1 << 6) /* Undefined/not used */
-#define MAX3107_IRDA_UNDEF7_BIT		(1 << 7) /* Undefined/not used */
-
-/* Flow control trigger level register masks */
-#define MAX3107_FLOWLVL_HALT_MASK	(0x000f) /* Flow control halt level */
-#define MAX3107_FLOWLVL_RES_MASK	(0x00f0) /* Flow control resume level */
-#define MAX3107_FLOWLVL_HALT(words)	((words/8) & 0x000f)
-#define MAX3107_FLOWLVL_RES(words)	(((words/8) & 0x000f) << 4)
-
-/* FIFO interrupt trigger level register masks */
-#define MAX3107_FIFOTRIGLVL_TX_MASK	(0x000f) /* TX FIFO trigger level */
-#define MAX3107_FIFOTRIGLVL_RX_MASK	(0x00f0) /* RX FIFO trigger level */
-#define MAX3107_FIFOTRIGLVL_TX(words)	((words/8) & 0x000f)
-#define MAX3107_FIFOTRIGLVL_RX(words)	(((words/8) & 0x000f) << 4)
-
-/* Flow control register bits */
-#define MAX3107_FLOWCTRL_AUTORTS_BIT	(1 << 0) /* Auto RTS flow ctrl enable */
-#define MAX3107_FLOWCTRL_AUTOCTS_BIT	(1 << 1) /* Auto CTS flow ctrl enable */
-#define MAX3107_FLOWCTRL_GPIADDR_BIT	(1 << 2) /* Enables that GPIO inputs
-						  * are used in conjunction with
-						  * XOFF2 for definition of
-						  * special character */
-#define MAX3107_FLOWCTRL_SWFLOWEN_BIT	(1 << 3) /* Auto SW flow ctrl enable */
-#define MAX3107_FLOWCTRL_SWFLOW0_BIT	(1 << 4) /* SWFLOW bit 0 */
-#define MAX3107_FLOWCTRL_SWFLOW1_BIT	(1 << 5) /* SWFLOW bit 1
-						  *
-						  * SWFLOW bits 1 & 0 table:
-						  * 00 -> no transmitter flow
-						  *       control
-						  * 01 -> receiver compares
-						  *       XON2 and XOFF2
-						  *       and controls
-						  *       transmitter
-						  * 10 -> receiver compares
-						  *       XON1 and XOFF1
-						  *       and controls
-						  *       transmitter
-						  * 11 -> receiver compares
-						  *       XON1, XON2, XOFF1 and
-						  *       XOFF2 and controls
-						  *       transmitter
-						  */
-#define MAX3107_FLOWCTRL_SWFLOW2_BIT	(1 << 6) /* SWFLOW bit 2 */
-#define MAX3107_FLOWCTRL_SWFLOW3_BIT	(1 << 7) /* SWFLOW bit 3
-						  *
-						  * SWFLOW bits 3 & 2 table:
-						  * 00 -> no received flow
-						  *       control
-						  * 01 -> transmitter generates
-						  *       XON2 and XOFF2
-						  * 10 -> transmitter generates
-						  *       XON1 and XOFF1
-						  * 11 -> transmitter generates
-						  *       XON1, XON2, XOFF1 and
-						  *       XOFF2
-						  */
-
-/* GPIO configuration register bits */
-#define MAX3107_GPIOCFG_GP0OUT_BIT	(1 << 0) /* GPIO 0 output enable */
-#define MAX3107_GPIOCFG_GP1OUT_BIT	(1 << 1) /* GPIO 1 output enable */
-#define MAX3107_GPIOCFG_GP2OUT_BIT	(1 << 2) /* GPIO 2 output enable */
-#define MAX3107_GPIOCFG_GP3OUT_BIT	(1 << 3) /* GPIO 3 output enable */
-#define MAX3107_GPIOCFG_GP0OD_BIT	(1 << 4) /* GPIO 0 open-drain enable */
-#define MAX3107_GPIOCFG_GP1OD_BIT	(1 << 5) /* GPIO 1 open-drain enable */
-#define MAX3107_GPIOCFG_GP2OD_BIT	(1 << 6) /* GPIO 2 open-drain enable */
-#define MAX3107_GPIOCFG_GP3OD_BIT	(1 << 7) /* GPIO 3 open-drain enable */
-
-/* GPIO DATA register bits */
-#define MAX3107_GPIODATA_GP0OUT_BIT	(1 << 0) /* GPIO 0 output value */
-#define MAX3107_GPIODATA_GP1OUT_BIT	(1 << 1) /* GPIO 1 output value */
-#define MAX3107_GPIODATA_GP2OUT_BIT	(1 << 2) /* GPIO 2 output value */
-#define MAX3107_GPIODATA_GP3OUT_BIT	(1 << 3) /* GPIO 3 output value */
-#define MAX3107_GPIODATA_GP0IN_BIT	(1 << 4) /* GPIO 0 input value */
-#define MAX3107_GPIODATA_GP1IN_BIT	(1 << 5) /* GPIO 1 input value */
-#define MAX3107_GPIODATA_GP2IN_BIT	(1 << 6) /* GPIO 2 input value */
-#define MAX3107_GPIODATA_GP3IN_BIT	(1 << 7) /* GPIO 3 input value */
-
-/* PLL configuration register masks */
-#define MAX3107_PLLCFG_PREDIV_MASK	(0x003f) /* PLL predivision value */
-#define MAX3107_PLLCFG_PLLFACTOR_MASK	(0x00c0) /* PLL multiplication factor */
-
-/* Baud rate generator configuration register masks and bits */
-#define MAX3107_BRGCFG_FRACT_MASK	(0x000f) /* Fractional portion of
-						  * Baud rate generator divisor
-						  */
-#define MAX3107_BRGCFG_2XMODE_BIT	(1 << 4) /* Double baud rate */
-#define MAX3107_BRGCFG_4XMODE_BIT	(1 << 5) /* Quadruple baud rate */
-#define MAX3107_BRGCFG_UNDEF6_BIT	(1 << 6) /* Undefined/not used */
-#define MAX3107_BRGCFG_UNDEF7_BIT	(1 << 7) /* Undefined/not used */
-
-/* Clock source register bits */
-#define MAX3107_CLKSRC_INTOSC_BIT	(1 << 0) /* Internal osc enable */
-#define MAX3107_CLKSRC_CRYST_BIT	(1 << 1) /* Crystal osc enable */
-#define MAX3107_CLKSRC_PLL_BIT		(1 << 2) /* PLL enable */
-#define MAX3107_CLKSRC_PLLBYP_BIT	(1 << 3) /* PLL bypass */
-#define MAX3107_CLKSRC_EXTCLK_BIT	(1 << 4) /* External clock enable */
-#define MAX3107_CLKSRC_UNDEF5_BIT	(1 << 5) /* Undefined/not used */
-#define MAX3107_CLKSRC_UNDEF6_BIT	(1 << 6) /* Undefined/not used */
-#define MAX3107_CLKSRC_CLK2RTS_BIT	(1 << 7) /* Baud clk to RTS pin */
-
-
-/* HW definitions */
-#define MAX3107_RX_FIFO_SIZE	128
-#define MAX3107_TX_FIFO_SIZE	128
-#define MAX3107_REVID1		0x00a0
-#define MAX3107_REVID2		0x00a1
-
-
-/* Baud rate generator configuration values for external clock 13MHz */
-#define MAX3107_BRG13_B300	(0x0A9400 | 0x05)
-#define MAX3107_BRG13_B600	(0x054A00 | 0x03)
-#define MAX3107_BRG13_B1200	(0x02A500 | 0x01)
-#define MAX3107_BRG13_B2400	(0x015200 | 0x09)
-#define MAX3107_BRG13_B4800	(0x00A900 | 0x04)
-#define MAX3107_BRG13_B9600	(0x005400 | 0x0A)
-#define MAX3107_BRG13_B19200	(0x002A00 | 0x05)
-#define MAX3107_BRG13_B38400	(0x001500 | 0x03)
-#define MAX3107_BRG13_B57600	(0x000E00 | 0x02)
-#define MAX3107_BRG13_B115200	(0x000700 | 0x01)
-#define MAX3107_BRG13_B230400	(0x000300 | 0x08)
-#define MAX3107_BRG13_B460800	(0x000100 | 0x0c)
-#define MAX3107_BRG13_B921600	(0x000100 | 0x1c)
-
-/* Baud rate generator configuration values for external clock 26MHz */
-#define MAX3107_BRG26_B300	(0x152800 | 0x0A)
-#define MAX3107_BRG26_B600	(0x0A9400 | 0x05)
-#define MAX3107_BRG26_B1200	(0x054A00 | 0x03)
-#define MAX3107_BRG26_B2400	(0x02A500 | 0x01)
-#define MAX3107_BRG26_B4800	(0x015200 | 0x09)
-#define MAX3107_BRG26_B9600	(0x00A900 | 0x04)
-#define MAX3107_BRG26_B19200	(0x005400 | 0x0A)
-#define MAX3107_BRG26_B38400	(0x002A00 | 0x05)
-#define MAX3107_BRG26_B57600	(0x001C00 | 0x03)
-#define MAX3107_BRG26_B115200	(0x000E00 | 0x02)
-#define MAX3107_BRG26_B230400	(0x000700 | 0x01)
-#define MAX3107_BRG26_B460800	(0x000300 | 0x08)
-#define MAX3107_BRG26_B921600	(0x000100 | 0x0C)
-
-/* Baud rate generator configuration values for internal clock */
-#define MAX3107_BRG13_IB300	(0x008000 | 0x00)
-#define MAX3107_BRG13_IB600	(0x004000 | 0x00)
-#define MAX3107_BRG13_IB1200	(0x002000 | 0x00)
-#define MAX3107_BRG13_IB2400	(0x001000 | 0x00)
-#define MAX3107_BRG13_IB4800	(0x000800 | 0x00)
-#define MAX3107_BRG13_IB9600	(0x000400 | 0x00)
-#define MAX3107_BRG13_IB19200	(0x000200 | 0x00)
-#define MAX3107_BRG13_IB38400	(0x000100 | 0x00)
-#define MAX3107_BRG13_IB57600	(0x000000 | 0x0B)
-#define MAX3107_BRG13_IB115200	(0x000000 | 0x05)
-#define MAX3107_BRG13_IB230400	(0x000000 | 0x03)
-#define MAX3107_BRG13_IB460800	(0x000000 | 0x00)
-#define MAX3107_BRG13_IB921600	(0x000000 | 0x00)
-
-
-struct baud_table {
-	int baud;
-	u32 new_brg;
-};
-
-struct max3107_port {
-	/* UART port structure */
-	struct uart_port port;
-
-	/* SPI device structure */
-	struct spi_device *spi;
-
-#if defined(CONFIG_GPIOLIB)
-	/* GPIO chip structure */
-	struct gpio_chip chip;
-#endif
-
-	/* Workqueue that does all the magic */
-	struct workqueue_struct *workqueue;
-	struct work_struct work;
-
-	/* Lock for shared data */
-	spinlock_t data_lock;
-
-	/* Device configuration */
-	int ext_clk;		/* 1 if external clock used */
-	int loopback;		/* Current loopback mode state */
-	int baud;			/* Current baud rate */
-
-	/* State flags */
-	int suspended;		/* Indicates suspend mode */
-	int tx_fifo_empty;	/* Flag for TX FIFO state */
-	int rx_enabled;		/* Flag for receiver state */
-	int tx_enabled;		/* Flag for transmitter state */
-
-	u16 irqen_reg;		/* Current IRQ enable register value */
-	/* Shared data */
-	u16 mode1_reg;		/* Current mode1 register value*/
-	int mode1_commit;	/* Flag for setting new mode1 register value */
-	u16 lcr_reg;		/* Current LCR register value */
-	int lcr_commit;		/* Flag for setting new LCR register value */
-	u32 brg_cfg;		/* Current Baud rate generator config  */
-	int brg_commit;		/* Flag for setting new baud rate generator
-				 * config
-				 */
-	struct baud_table *baud_tbl;
-	int handle_irq;		/* Indicates that IRQ should be handled */
-
-	/* Rx buffer and str*/
-	u16 *rxbuf;
-	u8  *rxstr;
-	/* Tx buffer*/
-	u16 *txbuf;
-
-	struct max3107_plat *pdata;	/* Platform data */
-};
-
-/* Platform data structure */
-struct max3107_plat {
-	/* Loopback mode enable */
-	int loopback;
-	/* External clock enable */
-	int ext_clk;
-	/* Called during the register initialisation */
-	void (*init)(struct max3107_port *s);
-	/* Called when the port is found and configured */
-	int (*configure)(struct max3107_port *s);
-	/* HW suspend function */
-	void (*hw_suspend) (struct max3107_port *s, int suspend);
-	/* Polling mode enable */
-	int polled_mode;
-	/* Polling period if polling mode enabled */
-	int poll_time;
-};
-
-extern int max3107_rw(struct max3107_port *s, u8 *tx, u8 *rx, int len);
-extern void max3107_hw_susp(struct max3107_port *s, int suspend);
-extern int max3107_probe(struct spi_device *spi, struct max3107_plat *pdata);
-extern int max3107_remove(struct spi_device *spi);
-extern int max3107_suspend(struct spi_device *spi, pm_message_t state);
-extern int max3107_resume(struct spi_device *spi);
-
-#endif /* _LINUX_SERIAL_MAX3107_H */
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
new file mode 100644
index 0000000..534e448
--- /dev/null
+++ b/drivers/tty/serial/max310x.c
@@ -0,0 +1,1259 @@
+/*
+ *  Maxim (Dallas) MAX3107/8 serial driver
+ *
+ *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *
+ *  Based on max3100.c, by Christian Pellegrin <chripell@evolware.org>
+ *  Based on max3110.c, by Feng Tang <feng.tang@intel.com>
+ *  Based on max3107.c, by Aavamobile
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+/* TODO: MAX3109 support (Dual) */
+/* TODO: MAX14830 support (Quad) */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/regmap.h>
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_data/max310x.h>
+
+#define MAX310X_MAJOR			204
+#define MAX310X_MINOR			209
+
+/* MAX310X register definitions */
+#define MAX310X_RHR_REG			(0x00) /* RX FIFO */
+#define MAX310X_THR_REG			(0x00) /* TX FIFO */
+#define MAX310X_IRQEN_REG		(0x01) /* IRQ enable */
+#define MAX310X_IRQSTS_REG		(0x02) /* IRQ status */
+#define MAX310X_LSR_IRQEN_REG		(0x03) /* LSR IRQ enable */
+#define MAX310X_LSR_IRQSTS_REG		(0x04) /* LSR IRQ status */
+#define MAX310X_SPCHR_IRQEN_REG		(0x05) /* Special char IRQ enable */
+#define MAX310X_SPCHR_IRQSTS_REG	(0x06) /* Special char IRQ status */
+#define MAX310X_STS_IRQEN_REG		(0x07) /* Status IRQ enable */
+#define MAX310X_STS_IRQSTS_REG		(0x08) /* Status IRQ status */
+#define MAX310X_MODE1_REG		(0x09) /* MODE1 */
+#define MAX310X_MODE2_REG		(0x0a) /* MODE2 */
+#define MAX310X_LCR_REG			(0x0b) /* LCR */
+#define MAX310X_RXTO_REG		(0x0c) /* RX timeout */
+#define MAX310X_HDPIXDELAY_REG		(0x0d) /* Auto transceiver delays */
+#define MAX310X_IRDA_REG		(0x0e) /* IRDA settings */
+#define MAX310X_FLOWLVL_REG		(0x0f) /* Flow control levels */
+#define MAX310X_FIFOTRIGLVL_REG		(0x10) /* FIFO IRQ trigger levels */
+#define MAX310X_TXFIFOLVL_REG		(0x11) /* TX FIFO level */
+#define MAX310X_RXFIFOLVL_REG		(0x12) /* RX FIFO level */
+#define MAX310X_FLOWCTRL_REG		(0x13) /* Flow control */
+#define MAX310X_XON1_REG		(0x14) /* XON1 character */
+#define MAX310X_XON2_REG		(0x15) /* XON2 character */
+#define MAX310X_XOFF1_REG		(0x16) /* XOFF1 character */
+#define MAX310X_XOFF2_REG		(0x17) /* XOFF2 character */
+#define MAX310X_GPIOCFG_REG		(0x18) /* GPIO config */
+#define MAX310X_GPIODATA_REG		(0x19) /* GPIO data */
+#define MAX310X_PLLCFG_REG		(0x1a) /* PLL config */
+#define MAX310X_BRGCFG_REG		(0x1b) /* Baud rate generator conf */
+#define MAX310X_BRGDIVLSB_REG		(0x1c) /* Baud rate divisor LSB */
+#define MAX310X_BRGDIVMSB_REG		(0x1d) /* Baud rate divisor MSB */
+#define MAX310X_CLKSRC_REG		(0x1e) /* Clock source */
+/* Only present in MAX3107 */
+#define MAX3107_REVID_REG		(0x1f) /* Revision identification */
+
+/* IRQ register bits */
+#define MAX310X_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
+#define MAX310X_IRQ_SPCHR_BIT		(1 << 1) /* Special char interrupt */
+#define MAX310X_IRQ_STS_BIT		(1 << 2) /* Status interrupt */
+#define MAX310X_IRQ_RXFIFO_BIT		(1 << 3) /* RX FIFO interrupt */
+#define MAX310X_IRQ_TXFIFO_BIT		(1 << 4) /* TX FIFO interrupt */
+#define MAX310X_IRQ_TXEMPTY_BIT		(1 << 5) /* TX FIFO empty interrupt */
+#define MAX310X_IRQ_RXEMPTY_BIT		(1 << 6) /* RX FIFO empty interrupt */
+#define MAX310X_IRQ_CTS_BIT		(1 << 7) /* CTS interrupt */
+
+/* LSR register bits */
+#define MAX310X_LSR_RXTO_BIT		(1 << 0) /* RX timeout */
+#define MAX310X_LSR_RXOVR_BIT		(1 << 1) /* RX overrun */
+#define MAX310X_LSR_RXPAR_BIT		(1 << 2) /* RX parity error */
+#define MAX310X_LSR_FRERR_BIT		(1 << 3) /* Frame error */
+#define MAX310X_LSR_RXBRK_BIT		(1 << 4) /* RX break */
+#define MAX310X_LSR_RXNOISE_BIT		(1 << 5) /* RX noise */
+#define MAX310X_LSR_CTS_BIT		(1 << 7) /* CTS pin state */
+
+/* Special character register bits */
+#define MAX310X_SPCHR_XON1_BIT		(1 << 0) /* XON1 character */
+#define MAX310X_SPCHR_XON2_BIT		(1 << 1) /* XON2 character */
+#define MAX310X_SPCHR_XOFF1_BIT		(1 << 2) /* XOFF1 character */
+#define MAX310X_SPCHR_XOFF2_BIT		(1 << 3) /* XOFF2 character */
+#define MAX310X_SPCHR_BREAK_BIT		(1 << 4) /* RX break */
+#define MAX310X_SPCHR_MULTIDROP_BIT	(1 << 5) /* 9-bit multidrop addr char */
+
+/* Status register bits */
+#define MAX310X_STS_GPIO0_BIT		(1 << 0) /* GPIO 0 interrupt */
+#define MAX310X_STS_GPIO1_BIT		(1 << 1) /* GPIO 1 interrupt */
+#define MAX310X_STS_GPIO2_BIT		(1 << 2) /* GPIO 2 interrupt */
+#define MAX310X_STS_GPIO3_BIT		(1 << 3) /* GPIO 3 interrupt */
+#define MAX310X_STS_CLKREADY_BIT	(1 << 5) /* Clock ready */
+#define MAX310X_STS_SLEEP_BIT		(1 << 6) /* Sleep interrupt */
+
+/* MODE1 register bits */
+#define MAX310X_MODE1_RXDIS_BIT		(1 << 0) /* RX disable */
+#define MAX310X_MODE1_TXDIS_BIT		(1 << 1) /* TX disable */
+#define MAX310X_MODE1_TXHIZ_BIT		(1 << 2) /* TX pin three-state */
+#define MAX310X_MODE1_RTSHIZ_BIT	(1 << 3) /* RTS pin three-state */
+#define MAX310X_MODE1_TRNSCVCTRL_BIT	(1 << 4) /* Transceiver ctrl enable */
+#define MAX310X_MODE1_FORCESLEEP_BIT	(1 << 5) /* Force sleep mode */
+#define MAX310X_MODE1_AUTOSLEEP_BIT	(1 << 6) /* Auto sleep enable */
+#define MAX310X_MODE1_IRQSEL_BIT	(1 << 7) /* IRQ pin enable */
+
+/* MODE2 register bits */
+#define MAX310X_MODE2_RST_BIT		(1 << 0) /* Chip reset */
+#define MAX310X_MODE2_FIFORST_BIT	(1 << 1) /* FIFO reset */
+#define MAX310X_MODE2_RXTRIGINV_BIT	(1 << 2) /* RX FIFO INT invert */
+#define MAX310X_MODE2_RXEMPTINV_BIT	(1 << 3) /* RX FIFO empty INT invert */
+#define MAX310X_MODE2_SPCHR_BIT		(1 << 4) /* Special chr detect enable */
+#define MAX310X_MODE2_LOOPBACK_BIT	(1 << 5) /* Internal loopback enable */
+#define MAX310X_MODE2_MULTIDROP_BIT	(1 << 6) /* 9-bit multidrop enable */
+#define MAX310X_MODE2_ECHOSUPR_BIT	(1 << 7) /* ECHO suppression enable */
+
+/* LCR register bits */
+#define MAX310X_LCR_LENGTH0_BIT		(1 << 0) /* Word length bit 0 */
+#define MAX310X_LCR_LENGTH1_BIT		(1 << 1) /* Word length bit 1
+						  *
+						  * Word length bits table:
+						  * 00 -> 5 bit words
+						  * 01 -> 6 bit words
+						  * 10 -> 7 bit words
+						  * 11 -> 8 bit words
+						  */
+#define MAX310X_LCR_STOPLEN_BIT		(1 << 2) /* STOP length bit
+						  *
+						  * STOP length bit table:
+						  * 0 -> 1 stop bit
+						  * 1 -> 1-1.5 stop bits if
+						  *      word length is 5,
+						  *      2 stop bits otherwise
+						  */
+#define MAX310X_LCR_PARITY_BIT		(1 << 3) /* Parity bit enable */
+#define MAX310X_LCR_EVENPARITY_BIT	(1 << 4) /* Even parity bit enable */
+#define MAX310X_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
+#define MAX310X_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
+#define MAX310X_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
+#define MAX310X_LCR_WORD_LEN_5		(0x00)
+#define MAX310X_LCR_WORD_LEN_6		(0x01)
+#define MAX310X_LCR_WORD_LEN_7		(0x02)
+#define MAX310X_LCR_WORD_LEN_8		(0x03)
+
+/* IRDA register bits */
+#define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
+#define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
+#define MAX310X_IRDA_SHORTIR_BIT	(1 << 2) /* Short SIR mode enable */
+#define MAX310X_IRDA_MIR_BIT		(1 << 3) /* MIR mode enable */
+#define MAX310X_IRDA_RXINV_BIT		(1 << 4) /* RX logic inversion enable */
+#define MAX310X_IRDA_TXINV_BIT		(1 << 5) /* TX logic inversion enable */
+
+/* Flow control trigger level register masks */
+#define MAX310X_FLOWLVL_HALT_MASK	(0x000f) /* Flow control halt level */
+#define MAX310X_FLOWLVL_RES_MASK	(0x00f0) /* Flow control resume level */
+#define MAX310X_FLOWLVL_HALT(words)	((words / 8) & 0x0f)
+#define MAX310X_FLOWLVL_RES(words)	(((words / 8) & 0x0f) << 4)
+
+/* FIFO interrupt trigger level register masks */
+#define MAX310X_FIFOTRIGLVL_TX_MASK	(0x0f) /* TX FIFO trigger level */
+#define MAX310X_FIFOTRIGLVL_RX_MASK	(0xf0) /* RX FIFO trigger level */
+#define MAX310X_FIFOTRIGLVL_TX(words)	((words / 8) & 0x0f)
+#define MAX310X_FIFOTRIGLVL_RX(words)	(((words / 8) & 0x0f) << 4)
+
+/* Flow control register bits */
+#define MAX310X_FLOWCTRL_AUTORTS_BIT	(1 << 0) /* Auto RTS flow ctrl enable */
+#define MAX310X_FLOWCTRL_AUTOCTS_BIT	(1 << 1) /* Auto CTS flow ctrl enable */
+#define MAX310X_FLOWCTRL_GPIADDR_BIT	(1 << 2) /* Enables that GPIO inputs
+						  * are used in conjunction with
+						  * XOFF2 for definition of
+						  * special character */
+#define MAX310X_FLOWCTRL_SWFLOWEN_BIT	(1 << 3) /* Auto SW flow ctrl enable */
+#define MAX310X_FLOWCTRL_SWFLOW0_BIT	(1 << 4) /* SWFLOW bit 0 */
+#define MAX310X_FLOWCTRL_SWFLOW1_BIT	(1 << 5) /* SWFLOW bit 1
+						  *
+						  * SWFLOW bits 1 & 0 table:
+						  * 00 -> no transmitter flow
+						  *       control
+						  * 01 -> receiver compares
+						  *       XON2 and XOFF2
+						  *       and controls
+						  *       transmitter
+						  * 10 -> receiver compares
+						  *       XON1 and XOFF1
+						  *       and controls
+						  *       transmitter
+						  * 11 -> receiver compares
+						  *       XON1, XON2, XOFF1 and
+						  *       XOFF2 and controls
+						  *       transmitter
+						  */
+#define MAX310X_FLOWCTRL_SWFLOW2_BIT	(1 << 6) /* SWFLOW bit 2 */
+#define MAX310X_FLOWCTRL_SWFLOW3_BIT	(1 << 7) /* SWFLOW bit 3
+						  *
+						  * SWFLOW bits 3 & 2 table:
+						  * 00 -> no received flow
+						  *       control
+						  * 01 -> transmitter generates
+						  *       XON2 and XOFF2
+						  * 10 -> transmitter generates
+						  *       XON1 and XOFF1
+						  * 11 -> transmitter generates
+						  *       XON1, XON2, XOFF1 and
+						  *       XOFF2
+						  */
+
+/* GPIO configuration register bits */
+#define MAX310X_GPIOCFG_GP0OUT_BIT	(1 << 0) /* GPIO 0 output enable */
+#define MAX310X_GPIOCFG_GP1OUT_BIT	(1 << 1) /* GPIO 1 output enable */
+#define MAX310X_GPIOCFG_GP2OUT_BIT	(1 << 2) /* GPIO 2 output enable */
+#define MAX310X_GPIOCFG_GP3OUT_BIT	(1 << 3) /* GPIO 3 output enable */
+#define MAX310X_GPIOCFG_GP0OD_BIT	(1 << 4) /* GPIO 0 open-drain enable */
+#define MAX310X_GPIOCFG_GP1OD_BIT	(1 << 5) /* GPIO 1 open-drain enable */
+#define MAX310X_GPIOCFG_GP2OD_BIT	(1 << 6) /* GPIO 2 open-drain enable */
+#define MAX310X_GPIOCFG_GP3OD_BIT	(1 << 7) /* GPIO 3 open-drain enable */
+
+/* GPIO DATA register bits */
+#define MAX310X_GPIODATA_GP0OUT_BIT	(1 << 0) /* GPIO 0 output value */
+#define MAX310X_GPIODATA_GP1OUT_BIT	(1 << 1) /* GPIO 1 output value */
+#define MAX310X_GPIODATA_GP2OUT_BIT	(1 << 2) /* GPIO 2 output value */
+#define MAX310X_GPIODATA_GP3OUT_BIT	(1 << 3) /* GPIO 3 output value */
+#define MAX310X_GPIODATA_GP0IN_BIT	(1 << 4) /* GPIO 0 input value */
+#define MAX310X_GPIODATA_GP1IN_BIT	(1 << 5) /* GPIO 1 input value */
+#define MAX310X_GPIODATA_GP2IN_BIT	(1 << 6) /* GPIO 2 input value */
+#define MAX310X_GPIODATA_GP3IN_BIT	(1 << 7) /* GPIO 3 input value */
+
+/* PLL configuration register masks */
+#define MAX310X_PLLCFG_PREDIV_MASK	(0x3f) /* PLL predivision value */
+#define MAX310X_PLLCFG_PLLFACTOR_MASK	(0xc0) /* PLL multiplication factor */
+
+/* Baud rate generator configuration register bits */
+#define MAX310X_BRGCFG_2XMODE_BIT	(1 << 4) /* Double baud rate */
+#define MAX310X_BRGCFG_4XMODE_BIT	(1 << 5) /* Quadruple baud rate */
+
+/* Clock source register bits */
+#define MAX310X_CLKSRC_CRYST_BIT	(1 << 1) /* Crystal osc enable */
+#define MAX310X_CLKSRC_PLL_BIT		(1 << 2) /* PLL enable */
+#define MAX310X_CLKSRC_PLLBYP_BIT	(1 << 3) /* PLL bypass */
+#define MAX310X_CLKSRC_EXTCLK_BIT	(1 << 4) /* External clock enable */
+#define MAX310X_CLKSRC_CLK2RTS_BIT	(1 << 7) /* Baud clk to RTS pin */
+
+/* Misc definitions */
+#define MAX310X_FIFO_SIZE		(128)
+
+/* MAX3107 specific */
+#define MAX3107_REV_ID			(0xa0)
+#define MAX3107_REV_MASK		(0xfe)
+
+/* IRQ status bits definitions */
+#define MAX310X_IRQ_TX			(MAX310X_IRQ_TXFIFO_BIT | \
+					 MAX310X_IRQ_TXEMPTY_BIT)
+#define MAX310X_IRQ_RX			(MAX310X_IRQ_RXFIFO_BIT | \
+					 MAX310X_IRQ_RXEMPTY_BIT)
+
+/* Supported chip types */
+enum {
+	MAX310X_TYPE_MAX3107	= 3107,
+	MAX310X_TYPE_MAX3108	= 3108,
+};
+
+struct max310x_port {
+	struct uart_driver	uart;
+	struct uart_port	port;
+
+	const char		*name;
+	int			uartclk;
+
+	unsigned int		nr_gpio;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip	gpio;
+#endif
+
+	struct regmap		*regmap;
+	struct regmap_config	regcfg;
+
+	struct workqueue_struct	*wq;
+	struct work_struct	tx_work;
+
+	struct mutex		max310x_mutex;
+
+	struct max310x_pdata	*pdata;
+};
+
+static bool max3107_8_reg_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX310X_IRQSTS_REG:
+	case MAX310X_LSR_IRQSTS_REG:
+	case MAX310X_SPCHR_IRQSTS_REG:
+	case MAX310X_STS_IRQSTS_REG:
+	case MAX310X_TXFIFOLVL_REG:
+	case MAX310X_RXFIFOLVL_REG:
+	case MAX3107_REVID_REG: /* Only available on MAX3107 */
+		return false;
+	default:
+		break;
+	}
+
+	return true;
+}
+
+static bool max310x_reg_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX310X_RHR_REG:
+	case MAX310X_IRQSTS_REG:
+	case MAX310X_LSR_IRQSTS_REG:
+	case MAX310X_SPCHR_IRQSTS_REG:
+	case MAX310X_STS_IRQSTS_REG:
+	case MAX310X_TXFIFOLVL_REG:
+	case MAX310X_RXFIFOLVL_REG:
+	case MAX310X_GPIODATA_REG:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static bool max310x_reg_precious(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX310X_RHR_REG:
+	case MAX310X_IRQSTS_REG:
+	case MAX310X_SPCHR_IRQSTS_REG:
+	case MAX310X_STS_IRQSTS_REG:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static void max310x_set_baud(struct max310x_port *s, int baud)
+{
+	unsigned int mode = 0, div = s->uartclk / baud;
+
+	if (!(div / 16)) {
+		/* Mode x2 */
+		mode = MAX310X_BRGCFG_2XMODE_BIT;
+		div = (s->uartclk * 2) / baud;
+	}
+
+	if (!(div / 16)) {
+		/* Mode x4 */
+		mode = MAX310X_BRGCFG_4XMODE_BIT;
+		div = (s->uartclk * 4) / baud;
+	}
+
+	regmap_write(s->regmap, MAX310X_BRGDIVMSB_REG,
+		     ((div / 16) >> 8) & 0xff);
+	regmap_write(s->regmap, MAX310X_BRGDIVLSB_REG, (div / 16) & 0xff);
+	regmap_write(s->regmap, MAX310X_BRGCFG_REG, (div % 16) | mode);
+}
+
+static void max310x_wait_pll(struct max310x_port *s)
+{
+	int tryes = 1000;
+
+	/* Wait for PLL only if crystal is used */
+	if (!(s->pdata->driver_flags & MAX310X_EXT_CLK)) {
+		unsigned int sts = 0;
+
+		while (tryes--) {
+			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &sts);
+			if (sts & MAX310X_STS_CLKREADY_BIT)
+				break;
+		}
+	}
+}
+
+static int __devinit max310x_update_best_err(unsigned long f, long *besterr)
+{
+	/* Use baudrate 115200 for calculate error */
+	long err = f % (115200 * 16);
+
+	if ((*besterr < 0) || (*besterr > err)) {
+		*besterr = err;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int __devinit max310x_set_ref_clk(struct max310x_port *s)
+{
+	unsigned int div, clksrc, pllcfg = 0;
+	long besterr = -1;
+	unsigned long fdiv, fmul, bestfreq = s->pdata->frequency;
+
+	/* First, update error without PLL */
+	max310x_update_best_err(s->pdata->frequency, &besterr);
+
+	/* Try all possible PLL dividers */
+	for (div = 1; (div <= 63) && besterr; div++) {
+		fdiv = DIV_ROUND_CLOSEST(s->pdata->frequency, div);
+
+		/* Try multiplier 6 */
+		fmul = fdiv * 6;
+		if ((fdiv >= 500000) && (fdiv <= 800000))
+			if (!max310x_update_best_err(fmul, &besterr)) {
+				pllcfg = (0 << 6) | div;
+				bestfreq = fmul;
+			}
+		/* Try multiplier 48 */
+		fmul = fdiv * 48;
+		if ((fdiv >= 850000) && (fdiv <= 1200000))
+			if (!max310x_update_best_err(fmul, &besterr)) {
+				pllcfg = (1 << 6) | div;
+				bestfreq = fmul;
+			}
+		/* Try multiplier 96 */
+		fmul = fdiv * 96;
+		if ((fdiv >= 425000) && (fdiv <= 1000000))
+			if (!max310x_update_best_err(fmul, &besterr)) {
+				pllcfg = (2 << 6) | div;
+				bestfreq = fmul;
+			}
+		/* Try multiplier 144 */
+		fmul = fdiv * 144;
+		if ((fdiv >= 390000) && (fdiv <= 667000))
+			if (!max310x_update_best_err(fmul, &besterr)) {
+				pllcfg = (3 << 6) | div;
+				bestfreq = fmul;
+			}
+	}
+
+	/* Configure clock source */
+	if (s->pdata->driver_flags & MAX310X_EXT_CLK)
+		clksrc = MAX310X_CLKSRC_EXTCLK_BIT;
+	else
+		clksrc = MAX310X_CLKSRC_CRYST_BIT;
+
+	/* Configure PLL */
+	if (pllcfg) {
+		clksrc |= MAX310X_CLKSRC_PLL_BIT;
+		regmap_write(s->regmap, MAX310X_PLLCFG_REG, pllcfg);
+	} else
+		clksrc |= MAX310X_CLKSRC_PLLBYP_BIT;
+
+	regmap_write(s->regmap, MAX310X_CLKSRC_REG, clksrc);
+
+	if (pllcfg)
+		max310x_wait_pll(s);
+
+	dev_dbg(s->port.dev, "Reference clock set to %lu Hz\n", bestfreq);
+
+	return (int)bestfreq;
+}
+
+static void max310x_handle_rx(struct max310x_port *s, unsigned int rxlen)
+{
+	unsigned int sts = 0, ch = 0, flag;
+	struct tty_struct *tty = tty_port_tty_get(&s->port.state->port);
+
+	if (!tty)
+		return;
+
+	if (unlikely(rxlen >= MAX310X_FIFO_SIZE)) {
+		dev_warn(s->port.dev, "Possible RX FIFO overrun %d\n", rxlen);
+		/* Ensure sanity of RX level */
+		rxlen = MAX310X_FIFO_SIZE;
+	}
+
+	dev_dbg(s->port.dev, "RX Len = %u\n", rxlen);
+
+	while (rxlen--) {
+		regmap_read(s->regmap, MAX310X_RHR_REG, &ch);
+		regmap_read(s->regmap, MAX310X_LSR_IRQSTS_REG, &sts);
+
+		sts &= MAX310X_LSR_RXPAR_BIT | MAX310X_LSR_FRERR_BIT |
+		       MAX310X_LSR_RXOVR_BIT | MAX310X_LSR_RXBRK_BIT;
+
+		s->port.icount.rx++;
+		flag = TTY_NORMAL;
+
+		if (unlikely(sts)) {
+			if (sts & MAX310X_LSR_RXBRK_BIT) {
+				s->port.icount.brk++;
+				if (uart_handle_break(&s->port))
+					continue;
+			} else if (sts & MAX310X_LSR_RXPAR_BIT)
+				s->port.icount.parity++;
+			else if (sts & MAX310X_LSR_FRERR_BIT)
+				s->port.icount.frame++;
+			else if (sts & MAX310X_LSR_RXOVR_BIT)
+				s->port.icount.overrun++;
+
+			sts &= s->port.read_status_mask;
+			if (sts & MAX310X_LSR_RXBRK_BIT)
+				flag = TTY_BREAK;
+			else if (sts & MAX310X_LSR_RXPAR_BIT)
+				flag = TTY_PARITY;
+			else if (sts & MAX310X_LSR_FRERR_BIT)
+				flag = TTY_FRAME;
+			else if (sts & MAX310X_LSR_RXOVR_BIT)
+				flag = TTY_OVERRUN;
+		}
+
+		if (uart_handle_sysrq_char(s->port, ch))
+			continue;
+
+		if (sts & s->port.ignore_status_mask)
+			continue;
+
+		uart_insert_char(&s->port, sts, MAX310X_LSR_RXOVR_BIT,
+				 ch, flag);
+	}
+
+	tty_flip_buffer_push(tty);
+
+	tty_kref_put(tty);
+}
+
+static void max310x_handle_tx(struct max310x_port *s)
+{
+	struct circ_buf *xmit = &s->port.state->xmit;
+	unsigned int txlen = 0, to_send;
+
+	if (unlikely(s->port.x_char)) {
+		regmap_write(s->regmap, MAX310X_THR_REG, s->port.x_char);
+		s->port.icount.tx++;
+		s->port.x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(&s->port))
+		return;
+
+	/* Get length of data pending in circular buffer */
+	to_send = uart_circ_chars_pending(xmit);
+	if (likely(to_send)) {
+		/* Limit to size of TX FIFO */
+		regmap_read(s->regmap, MAX310X_TXFIFOLVL_REG, &txlen);
+		txlen = MAX310X_FIFO_SIZE - txlen;
+		to_send = (to_send > txlen) ? txlen : to_send;
+
+		dev_dbg(s->port.dev, "TX Len = %u\n", to_send);
+
+		/* Add data to send */
+		s->port.icount.tx += to_send;
+		while (to_send--) {
+			regmap_write(s->regmap, MAX310X_THR_REG,
+				     xmit->buf[xmit->tail]);
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		};
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&s->port);
+}
+
+static irqreturn_t max310x_ist(int irq, void *dev_id)
+{
+	struct max310x_port *s = (struct max310x_port *)dev_id;
+	unsigned int ists = 0, lsr = 0, rxlen = 0;
+
+	mutex_lock(&s->max310x_mutex);
+
+	for (;;) {
+		/* Read IRQ status & RX FIFO level */
+		regmap_read(s->regmap, MAX310X_IRQSTS_REG, &ists);
+		regmap_read(s->regmap, MAX310X_LSR_IRQSTS_REG, &lsr);
+		regmap_read(s->regmap, MAX310X_RXFIFOLVL_REG, &rxlen);
+		if (!ists && !(lsr & MAX310X_LSR_RXTO_BIT) && !rxlen)
+			break;
+
+		dev_dbg(s->port.dev, "IRQ status: 0x%02x\n", ists);
+
+		if (rxlen)
+			max310x_handle_rx(s, rxlen);
+		if (ists & MAX310X_IRQ_TX)
+			max310x_handle_tx(s);
+		if (ists & MAX310X_IRQ_CTS_BIT)
+			uart_handle_cts_change(&s->port,
+					       !!(lsr & MAX310X_LSR_CTS_BIT));
+	}
+
+	mutex_unlock(&s->max310x_mutex);
+
+	return IRQ_HANDLED;
+}
+
+static void max310x_wq_proc(struct work_struct *ws)
+{
+	struct max310x_port *s = container_of(ws, struct max310x_port, tx_work);
+
+	mutex_lock(&s->max310x_mutex);
+	max310x_handle_tx(s);
+	mutex_unlock(&s->max310x_mutex);
+}
+
+static void max310x_start_tx(struct uart_port *port)
+{
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	queue_work(s->wq, &s->tx_work);
+}
+
+static void max310x_stop_tx(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static void max310x_stop_rx(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static unsigned int max310x_tx_empty(struct uart_port *port)
+{
+	unsigned int val = 0;
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	mutex_lock(&s->max310x_mutex);
+	regmap_read(s->regmap, MAX310X_TXFIFOLVL_REG, &val);
+	mutex_unlock(&s->max310x_mutex);
+
+	return val ? 0 : TIOCSER_TEMT;
+}
+
+static void max310x_enable_ms(struct uart_port *port)
+{
+	/* Modem status not supported */
+}
+
+static unsigned int max310x_get_mctrl(struct uart_port *port)
+{
+	/* DCD and DSR are not wired and CTS/RTS is handled automatically
+	 * so just indicate DSR and CAR asserted
+	 */
+	return TIOCM_DSR | TIOCM_CAR;
+}
+
+static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* DCD and DSR are not wired and CTS/RTS is hadnled automatically
+	 * so do nothing
+	 */
+}
+
+static void max310x_break_ctl(struct uart_port *port, int break_state)
+{
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	mutex_lock(&s->max310x_mutex);
+	regmap_update_bits(s->regmap, MAX310X_LCR_REG,
+			   MAX310X_LCR_TXBREAK_BIT,
+			   break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
+	mutex_unlock(&s->max310x_mutex);
+}
+
+static void max310x_set_termios(struct uart_port *port,
+				struct ktermios *termios,
+				struct ktermios *old)
+{
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+	unsigned int lcr, flow = 0;
+	int baud;
+
+	mutex_lock(&s->max310x_mutex);
+
+	/* Mask termios capabilities we don't support */
+	termios->c_cflag &= ~CMSPAR;
+	termios->c_iflag &= ~IXANY;
+
+	/* Word size */
+	switch (termios->c_cflag & CSIZE) {
+	case CS5:
+		lcr = MAX310X_LCR_WORD_LEN_5;
+		break;
+	case CS6:
+		lcr = MAX310X_LCR_WORD_LEN_6;
+		break;
+	case CS7:
+		lcr = MAX310X_LCR_WORD_LEN_7;
+		break;
+	case CS8:
+	default:
+		lcr = MAX310X_LCR_WORD_LEN_8;
+		break;
+	}
+
+	/* Parity */
+	if (termios->c_cflag & PARENB) {
+		lcr |= MAX310X_LCR_PARITY_BIT;
+		if (!(termios->c_cflag & PARODD))
+			lcr |= MAX310X_LCR_EVENPARITY_BIT;
+	}
+
+	/* Stop bits */
+	if (termios->c_cflag & CSTOPB)
+		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
+
+	/* Update LCR register */
+	regmap_write(s->regmap, MAX310X_LCR_REG, lcr);
+
+	/* Set read status mask */
+	port->read_status_mask = MAX310X_LSR_RXOVR_BIT;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= MAX310X_LSR_RXPAR_BIT |
+					  MAX310X_LSR_FRERR_BIT;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		port->read_status_mask |= MAX310X_LSR_RXBRK_BIT;
+
+	/* Set status ignore mask */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNBRK)
+		port->ignore_status_mask |= MAX310X_LSR_RXBRK_BIT;
+	if (!(termios->c_cflag & CREAD))
+		port->ignore_status_mask |= MAX310X_LSR_RXPAR_BIT |
+					    MAX310X_LSR_RXOVR_BIT |
+					    MAX310X_LSR_FRERR_BIT |
+					    MAX310X_LSR_RXBRK_BIT;
+
+	/* Configure flow control */
+	regmap_write(s->regmap, MAX310X_XON1_REG, termios->c_cc[VSTART]);
+	regmap_write(s->regmap, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
+	if (termios->c_cflag & CRTSCTS)
+		flow |= MAX310X_FLOWCTRL_AUTOCTS_BIT |
+			MAX310X_FLOWCTRL_AUTORTS_BIT;
+	if (termios->c_iflag & IXON)
+		flow |= MAX310X_FLOWCTRL_SWFLOW3_BIT |
+			MAX310X_FLOWCTRL_SWFLOWEN_BIT;
+	if (termios->c_iflag & IXOFF)
+		flow |= MAX310X_FLOWCTRL_SWFLOW1_BIT |
+			MAX310X_FLOWCTRL_SWFLOWEN_BIT;
+	regmap_write(s->regmap, MAX310X_FLOWCTRL_REG, flow);
+
+	/* Get baud rate generator configuration */
+	baud = uart_get_baud_rate(port, termios, old,
+				  port->uartclk / 16 / 0xffff,
+				  port->uartclk / 4);
+
+	/* Setup baudrate generator */
+	max310x_set_baud(s, baud);
+
+	/* Update timeout according to new baud rate */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	mutex_unlock(&s->max310x_mutex);
+}
+
+static int max310x_startup(struct uart_port *port)
+{
+	unsigned int val, line = port->line;
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(0);
+
+	mutex_lock(&s->max310x_mutex);
+
+	/* Configure baud rate, 9600 as default */
+	max310x_set_baud(s, 9600);
+
+	/* Configure LCR register, 8N1 mode by default */
+	val = MAX310X_LCR_WORD_LEN_8;
+	regmap_write(s->regmap, MAX310X_LCR_REG, val);
+
+	/* Configure MODE1 register */
+	regmap_update_bits(s->regmap, MAX310X_MODE1_REG,
+			   MAX310X_MODE1_TRNSCVCTRL_BIT,
+			   (s->pdata->uart_flags[line] & MAX310X_AUTO_DIR_CTRL)
+			   ? MAX310X_MODE1_TRNSCVCTRL_BIT : 0);
+
+	/* Configure MODE2 register */
+	val = MAX310X_MODE2_RXEMPTINV_BIT;
+	if (s->pdata->uart_flags[line] & MAX310X_LOOPBACK)
+		val |= MAX310X_MODE2_LOOPBACK_BIT;
+	if (s->pdata->uart_flags[line] & MAX310X_ECHO_SUPRESS)
+		val |= MAX310X_MODE2_ECHOSUPR_BIT;
+
+	/* Reset FIFOs */
+	val |= MAX310X_MODE2_FIFORST_BIT;
+	regmap_write(s->regmap, MAX310X_MODE2_REG, val);
+
+	/* Configure FIFO trigger level register */
+	/* RX FIFO trigger for 16 words, TX FIFO trigger for 64 words */
+	val = MAX310X_FIFOTRIGLVL_RX(16) | MAX310X_FIFOTRIGLVL_TX(64);
+	regmap_write(s->regmap, MAX310X_FIFOTRIGLVL_REG, val);
+
+	/* Configure flow control levels */
+	/* Flow control halt level 96, resume level 48 */
+	val = MAX310X_FLOWLVL_RES(48) | MAX310X_FLOWLVL_HALT(96);
+	regmap_write(s->regmap, MAX310X_FLOWLVL_REG, val);
+
+	/* Clear timeout register */
+	regmap_write(s->regmap, MAX310X_RXTO_REG, 0);
+
+	/* Configure LSR interrupt enable register */
+	/* Enable RX timeout interrupt */
+	val = MAX310X_LSR_RXTO_BIT;
+	regmap_write(s->regmap, MAX310X_LSR_IRQEN_REG, val);
+
+	/* Clear FIFO reset */
+	regmap_update_bits(s->regmap, MAX310X_MODE2_REG,
+			   MAX310X_MODE2_FIFORST_BIT, 0);
+
+	/* Clear IRQ status register by reading it */
+	regmap_read(s->regmap, MAX310X_IRQSTS_REG, &val);
+
+	/* Configure interrupt enable register */
+	/* Enable CTS change interrupt */
+	val = MAX310X_IRQ_CTS_BIT;
+	/* Enable RX, TX interrupts */
+	val |= MAX310X_IRQ_RX | MAX310X_IRQ_TX;
+	regmap_write(s->regmap, MAX310X_IRQEN_REG, val);
+
+	mutex_unlock(&s->max310x_mutex);
+
+	return 0;
+}
+
+static void max310x_shutdown(struct uart_port *port)
+{
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	/* Disable all interrupts */
+	mutex_lock(&s->max310x_mutex);
+	regmap_write(s->regmap, MAX310X_IRQEN_REG, 0);
+	mutex_unlock(&s->max310x_mutex);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(1);
+}
+
+static const char *max310x_type(struct uart_port *port)
+{
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	return (port->type == PORT_MAX310X) ? s->name : NULL;
+}
+
+static int max310x_request_port(struct uart_port *port)
+{
+	/* Do nothing */
+	return 0;
+}
+
+static void max310x_release_port(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static void max310x_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_MAX310X;
+}
+
+static int max310x_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	if ((ser->type == PORT_UNKNOWN) || (ser->type == PORT_MAX310X))
+		return 0;
+	if (ser->irq == port->irq)
+		return 0;
+
+	return -EINVAL;
+}
+
+static struct uart_ops max310x_ops = {
+	.tx_empty	= max310x_tx_empty,
+	.set_mctrl	= max310x_set_mctrl,
+	.get_mctrl	= max310x_get_mctrl,
+	.stop_tx	= max310x_stop_tx,
+	.start_tx	= max310x_start_tx,
+	.stop_rx	= max310x_stop_rx,
+	.enable_ms	= max310x_enable_ms,
+	.break_ctl	= max310x_break_ctl,
+	.startup	= max310x_startup,
+	.shutdown	= max310x_shutdown,
+	.set_termios	= max310x_set_termios,
+	.type		= max310x_type,
+	.request_port	= max310x_request_port,
+	.release_port	= max310x_release_port,
+	.config_port	= max310x_config_port,
+	.verify_port	= max310x_verify_port,
+};
+
+static int max310x_suspend(struct spi_device *spi, pm_message_t state)
+{
+	int ret;
+	struct max310x_port *s = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(&spi->dev, "Suspend\n");
+
+	ret = uart_suspend_port(&s->uart, &s->port);
+
+	mutex_lock(&s->max310x_mutex);
+
+	/* Enable sleep mode */
+	regmap_update_bits(s->regmap, MAX310X_MODE1_REG,
+			   MAX310X_MODE1_FORCESLEEP_BIT,
+			   MAX310X_MODE1_FORCESLEEP_BIT);
+
+	mutex_unlock(&s->max310x_mutex);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(1);
+
+	return ret;
+}
+
+static int max310x_resume(struct spi_device *spi)
+{
+	struct max310x_port *s = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(&spi->dev, "Resume\n");
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(0);
+
+	mutex_lock(&s->max310x_mutex);
+
+	/* Disable sleep mode */
+	regmap_update_bits(s->regmap, MAX310X_MODE1_REG,
+			   MAX310X_MODE1_FORCESLEEP_BIT,
+			   0);
+
+	max310x_wait_pll(s);
+
+	mutex_unlock(&s->max310x_mutex);
+
+	return uart_resume_port(&s->uart, &s->port);
+}
+
+#ifdef CONFIG_GPIOLIB
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned int val = 0;
+	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+
+	mutex_lock(&s->max310x_mutex);
+	regmap_read(s->regmap, MAX310X_GPIODATA_REG, &val);
+	mutex_unlock(&s->max310x_mutex);
+
+	return !!((val >> 4) & (1 << offset));
+}
+
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+
+	mutex_lock(&s->max310x_mutex);
+	regmap_update_bits(s->regmap, MAX310X_GPIODATA_REG, 1 << offset, value ?
+							    1 << offset : 0);
+	mutex_unlock(&s->max310x_mutex);
+}
+
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+
+	mutex_lock(&s->max310x_mutex);
+
+	regmap_update_bits(s->regmap, MAX310X_GPIOCFG_REG, 1 << offset, 0);
+
+	mutex_unlock(&s->max310x_mutex);
+
+	return 0;
+}
+
+static int max310x_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned offset, int value)
+{
+	struct max310x_port *s = container_of(chip, struct max310x_port, gpio);
+
+	mutex_lock(&s->max310x_mutex);
+
+	regmap_update_bits(s->regmap, MAX310X_GPIOCFG_REG, 1 << offset,
+							   1 << offset);
+	regmap_update_bits(s->regmap, MAX310X_GPIODATA_REG, 1 << offset, value ?
+							    1 << offset : 0);
+
+	mutex_unlock(&s->max310x_mutex);
+
+	return 0;
+}
+#endif
+
+/* Generic platform data */
+static struct max310x_pdata generic_plat_data = {
+	.driver_flags	= MAX310X_EXT_CLK,
+	.uart_flags[0]	= MAX310X_ECHO_SUPRESS,
+	.frequency	= 26000000,
+};
+
+static int __devinit max310x_probe(struct spi_device *spi)
+{
+	struct max310x_port *s;
+	struct device *dev = &spi->dev;
+	int chiptype = spi_get_device_id(spi)->driver_data;
+	struct max310x_pdata *pdata = dev->platform_data;
+	unsigned int val = 0;
+	int ret;
+
+	/* Check for IRQ */
+	if (spi->irq <= 0) {
+		dev_err(dev, "No IRQ specified\n");
+		return -ENOTSUPP;
+	}
+
+	/* Alloc port structure */
+	s = devm_kzalloc(dev, sizeof(struct max310x_port), GFP_KERNEL);
+	if (!s) {
+		dev_err(dev, "Error allocating port structure\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(dev, s);
+
+	if (!pdata) {
+		dev_warn(dev, "No platform data supplied, using defaults\n");
+		pdata = &generic_plat_data;
+	}
+	s->pdata = pdata;
+
+	/* Individual chip settings */
+	switch (chiptype) {
+	case MAX310X_TYPE_MAX3107:
+		s->name = "MAX3107";
+		s->nr_gpio = 4;
+		s->uart.nr = 1;
+		s->regcfg.max_register = 0x1f;
+		break;
+	case MAX310X_TYPE_MAX3108:
+		s->name = "MAX3108";
+		s->nr_gpio = 4;
+		s->uart.nr = 1;
+		s->regcfg.max_register = 0x1e;
+		break;
+	default:
+		dev_err(dev, "Unsupported chip type %i\n", chiptype);
+		return -ENOTSUPP;
+	}
+
+	/* Check input frequency */
+	if ((pdata->driver_flags & MAX310X_EXT_CLK) &&
+	   ((pdata->frequency < 500000) || (pdata->frequency > 35000000)))
+		goto err_freq;
+	/* Check frequency for quartz */
+	if (!(pdata->driver_flags & MAX310X_EXT_CLK) &&
+	   ((pdata->frequency < 1000000) || (pdata->frequency > 4000000)))
+		goto err_freq;
+
+	mutex_init(&s->max310x_mutex);
+
+	/* Setup SPI bus */
+	spi->mode		= SPI_MODE_0;
+	spi->bits_per_word	= 8;
+	spi->max_speed_hz	= 26000000;
+	spi_setup(spi);
+
+	/* Setup regmap */
+	s->regcfg.reg_bits		= 8;
+	s->regcfg.val_bits		= 8;
+	s->regcfg.read_flag_mask	= 0x00;
+	s->regcfg.write_flag_mask	= 0x80;
+	s->regcfg.cache_type		= REGCACHE_RBTREE;
+	s->regcfg.writeable_reg		= max3107_8_reg_writeable;
+	s->regcfg.volatile_reg		= max310x_reg_volatile;
+	s->regcfg.precious_reg		= max310x_reg_precious;
+	s->regmap = devm_regmap_init_spi(spi, &s->regcfg);
+	if (IS_ERR(s->regmap)) {
+		ret = PTR_ERR(s->regmap);
+		dev_err(dev, "Failed to initialize register map\n");
+		goto err_out;
+	}
+
+	/* Reset chip & check SPI function */
+	ret = regmap_write(s->regmap, MAX310X_MODE2_REG, MAX310X_MODE2_RST_BIT);
+	if (ret) {
+		dev_err(dev, "SPI transfer failed\n");
+		goto err_out;
+	}
+	/* Clear chip reset */
+	regmap_write(s->regmap, MAX310X_MODE2_REG, 0);
+
+	switch (chiptype) {
+	case MAX310X_TYPE_MAX3107:
+		/* Check REV ID to ensure we are talking to what we expect */
+		regmap_read(s->regmap, MAX3107_REVID_REG, &val);
+		if (((val & MAX3107_REV_MASK) != MAX3107_REV_ID)) {
+			dev_err(dev, "%s ID 0x%02x does not match\n",
+				s->name, val);
+			ret = -ENODEV;
+			goto err_out;
+		}
+		break;
+	case MAX310X_TYPE_MAX3108:
+		/* MAX3108 have not REV ID register, we just check default value
+		 * from clocksource register to make sure everything works.
+		 */
+		regmap_read(s->regmap, MAX310X_CLKSRC_REG, &val);
+		if (val != (MAX310X_CLKSRC_EXTCLK_BIT |
+			    MAX310X_CLKSRC_PLLBYP_BIT)) {
+			dev_err(dev, "%s not present\n", s->name);
+			ret = -ENODEV;
+			goto err_out;
+		}
+		break;
+	}
+
+	/* Board specific configure */
+	if (pdata->init)
+		pdata->init();
+	if (pdata->suspend)
+		pdata->suspend(0);
+
+	/* Calculate referecne clock */
+	s->uartclk = max310x_set_ref_clk(s);
+
+	/* Disable all interrupts */
+	regmap_write(s->regmap, MAX310X_IRQEN_REG, 0);
+
+	/* Setup MODE1 register */
+	val = MAX310X_MODE1_IRQSEL_BIT; /* Enable IRQ pin */
+	if (pdata->driver_flags & MAX310X_AUTOSLEEP)
+		val = MAX310X_MODE1_AUTOSLEEP_BIT;
+	regmap_write(s->regmap, MAX310X_MODE1_REG, val);
+
+	/* Setup interrupt */
+	ret = devm_request_threaded_irq(dev, spi->irq, NULL, max310x_ist,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					dev_name(dev), s);
+	if (ret) {
+		dev_err(dev, "Unable to reguest IRQ %i\n", spi->irq);
+		goto err_out;
+	}
+
+	/* Register UART driver */
+	s->uart.owner		= THIS_MODULE;
+	s->uart.driver_name	= dev_name(dev);
+	s->uart.dev_name	= "ttyMAX";
+	s->uart.major		= MAX310X_MAJOR;
+	s->uart.minor		= MAX310X_MINOR;
+	ret = uart_register_driver(&s->uart);
+	if (ret) {
+		dev_err(dev, "Registering UART driver failed\n");
+		goto err_out;
+	}
+
+	/* Initialize workqueue for start TX */
+	s->wq = create_freezable_workqueue(dev_name(dev));
+	INIT_WORK(&s->tx_work, max310x_wq_proc);
+
+	/* Initialize UART port data */
+	s->port.line		= 0;
+	s->port.dev		= dev;
+	s->port.irq		= spi->irq;
+	s->port.type		= PORT_MAX310X;
+	s->port.fifosize	= MAX310X_FIFO_SIZE;
+	s->port.flags		= UPF_SKIP_TEST | UPF_FIXED_TYPE;
+	s->port.iotype		= UPIO_PORT;
+	s->port.membase		= (void __iomem *)0xffffffff; /* Bogus value */
+	s->port.uartclk		= s->uartclk;
+	s->port.ops		= &max310x_ops;
+	uart_add_one_port(&s->uart, &s->port);
+
+#ifdef CONFIG_GPIOLIB
+	/* Setup GPIO cotroller */
+	if (pdata->gpio_base) {
+		s->gpio.owner		= THIS_MODULE;
+		s->gpio.dev		= dev;
+		s->gpio.label		= dev_name(dev);
+		s->gpio.direction_input	= max310x_gpio_direction_input;
+		s->gpio.get		= max310x_gpio_get;
+		s->gpio.direction_output= max310x_gpio_direction_output;
+		s->gpio.set		= max310x_gpio_set;
+		s->gpio.base		= pdata->gpio_base;
+		s->gpio.ngpio		= s->nr_gpio;
+		if (gpiochip_add(&s->gpio)) {
+			/* Indicate that we should not call gpiochip_remove */
+			s->gpio.base = 0;
+		}
+	} else
+		dev_info(dev, "GPIO support not enabled\n");
+#endif
+
+	/* Go to suspend mode */
+	if (pdata->suspend)
+		pdata->suspend(1);
+
+	return 0;
+
+err_freq:
+	dev_err(dev, "Frequency parameter incorrect\n");
+	ret = -EINVAL;
+
+err_out:
+	dev_set_drvdata(dev, NULL);
+	devm_kfree(dev, s);
+
+	return ret;
+}
+
+static int __devexit max310x_remove(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct max310x_port *s = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "Removing port\n");
+
+	devm_free_irq(dev, s->port.irq, s);
+
+	destroy_workqueue(s->wq);
+
+	uart_remove_one_port(&s->uart, &s->port);
+
+	uart_unregister_driver(&s->uart);
+
+#ifdef CONFIG_GPIOLIB
+	if (s->pdata->gpio_base)
+		gpiochip_remove(&s->gpio);
+#endif
+
+	dev_set_drvdata(dev, NULL);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(1);
+	if (s->pdata->exit)
+		s->pdata->exit();
+
+	devm_kfree(dev, s);
+
+	return 0;
+}
+
+static const struct spi_device_id max310x_id_table[] = {
+	{ "max3107",	MAX310X_TYPE_MAX3107 },
+	{ "max3108",	MAX310X_TYPE_MAX3108 },
+};
+MODULE_DEVICE_TABLE(spi, max310x_id_table);
+
+static struct spi_driver max310x_driver = {
+	.driver = {
+		.name	= "max310x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max310x_probe,
+	.remove		= __devexit_p(max310x_remove),
+	.suspend	= max310x_suspend,
+	.resume		= max310x_resume,
+	.id_table	= max310x_id_table,
+};
+module_spi_driver(max310x_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("MAX310X serial driver");
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
new file mode 100644
index 0000000..91648bf
--- /dev/null
+++ b/include/linux/platform_data/max310x.h
@@ -0,0 +1,67 @@
+/*
+ *  Maxim (Dallas) MAX3107/8 serial driver
+ *
+ *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *
+ *  Based on max3100.c, by Christian Pellegrin <chripell@evolware.org>
+ *  Based on max3110.c, by Feng Tang <feng.tang@intel.com>
+ *  Based on max3107.c, by Aavamobile
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#ifndef _MAX310X_H_
+#define _MAX310X_H_
+
+/*
+ * Example board initialization data:
+ *
+ * static struct max310x_pdata max3107_pdata = {
+ *	.driver_flags	= MAX310X_EXT_CLK,
+ *	.uart_flags[0]	= MAX310X_ECHO_SUPRESS | MAX310X_AUTO_DIR_CTRL,
+ *	.frequency	= 3686400,
+ *	.gpio_base	= -1,
+ * };
+ *
+ * static struct spi_board_info spi_device_max3107[] = {
+ *	{
+ *		.modalias	= "max3107",
+ *		.irq		= IRQ_EINT3,
+ *		.bus_num	= 1,
+ *		.chip_select	= 1,
+ *		.platform_data	= &max3107_pdata,
+ *	},
+ * };
+ */
+
+#define MAX310X_MAX_UARTS	1
+
+/* MAX310X platform data structure */
+struct max310x_pdata {
+	/* Flags global to driver */
+	const u8		driver_flags:2;
+#define MAX310X_EXT_CLK		(0x00000001)	/* External clock enable */
+#define MAX310X_AUTOSLEEP	(0x00000002)	/* Enable AutoSleep mode */
+	/* Flags global to UART port */
+	const u8		uart_flags[MAX310X_MAX_UARTS];
+#define MAX310X_LOOPBACK	(0x00000001)	/* Loopback mode enable */
+#define MAX310X_ECHO_SUPRESS	(0x00000002)	/* Enable echo supress */
+#define MAX310X_AUTO_DIR_CTRL	(0x00000004)	/* Enable Auto direction
+						 * control (RS-485)
+						 */
+	/* Frequency (extrenal clock or crystal) */
+	const int		frequency;
+	/* GPIO base number (can be negative) */
+	const int		gpio_base;
+	/* Called during startup */
+	void (*init)(void);
+	/* Called before finish */
+	void (*exit)(void);
+	/* Suspend callback */
+	void (*suspend)(int do_suspend);
+};
+
+#endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 0253c20..7cf0b68 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -193,8 +193,8 @@
 /* SH-SCI */
 #define PORT_SCIFB	93
 
-/* MAX3107 */
-#define PORT_MAX3107	94
+/* MAX310X */
+#define PORT_MAX310X	94
 
 /* High Speed UART for Medfield */
 #define PORT_MFD	95
-- 
1.7.3.4

