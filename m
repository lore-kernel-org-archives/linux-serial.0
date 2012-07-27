From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: The new version of the driver MAX3107.
Date: Fri, 27 Jul 2012 19:01:49 +0400
Message-ID: <1343401309-14862-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:52811 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab2G0PKq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2012 11:10:46 -0400
Received: from smtp27.mail.ru (smtp27.mail.ru [94.100.176.180])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 82C7910DDD2
	for <linux-serial@vger.kernel.org>; Fri, 27 Jul 2012 19:02:22 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This is NOT a patch. Only for initial review and comment. So, do NOT apply.

Since the new version is very different from the old one I'm posting it as
a new driver to simplify the code view.
New features:
- Using the regmap. This makes it easy to add support for the driver
  via I2C. Register cache removes unnecessary reading that improves
  performance. I tested the driver on a slow processor with a very slow
  SPI bus, so the speed was an important factor when writing code.
- Using devm_XXX-related functions.
- The use of threaded IRQ with IRQF_ONESHOT flag allows the driver to
  the hardware that supports only level IRQ.
- Proper serial error handling.
- Proper treatment of FIFO queues.
- Advanced flags allows turn on RS-485 mode (Auto direction control).
- Ability to load multiple drivers MAX3107.
- Header moved to include/linux/platform_data.
- Cleanup, cleanup, cleanup...

So waiting for comments.
Thanks!
---
 drivers/tty/serial/Kconfig            |    7 +-
 drivers/tty/serial/max3107.c          | 1087 +++++++++++++++++++++++++++++++++
 include/linux/platform_data/max3107.h |   56 ++
 3 files changed, 1149 insertions(+), 1 deletions(-)
 create mode 100644 drivers/tty/serial/max3107.c
 create mode 100644 include/linux/platform_data/max3107.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 070b442..d2bbfd11 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -254,8 +254,13 @@ config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
 	select SERIAL_CORE
+	select REGMAP_SPI if SPI
 	help
-	  MAX3100 chip support
+	  The MAX3107 is an advanced universal asynchronous receiver-transmitter
+	  with 128 words each of receive and transmit first-in/first-out (FIFO)
+	  that can be controlled through I2C or high-speed SPI.
+
+	  Say Y here if you want to support this chip.
 
 config SERIAL_MAX3107
 	tristate "MAX3107 support"
diff --git a/drivers/tty/serial/max3107.c b/drivers/tty/serial/max3107.c
new file mode 100644
index 0000000..c7ea7d0
--- /dev/null
+++ b/drivers/tty/serial/max3107.c
@@ -0,0 +1,1087 @@
+/*
+ *  SPI UART protocol driver for Maxim (Dallas) MAX3107
+ *
+ *  Based on max3100.c
+ *    by Christian Pellegrin <chripell@evolware.org>
+ *  and max3110.c
+ *    by Feng Tang <feng.tang@intel.com>
+ *
+ *  Rewritten by Alexander Shiyan <shc_work@mail.ru>
+ *
+ *  Copyright (C) Aavamobile 2009
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+/* TODO: GPIO handling */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/platform_data/max3107.h>
+
+#define MAX3107_MAJOR			204
+#define MAX3107_MINOR			209
+
+/* Chip wakeup delay */
+#define MAX3107_WAKEUP_DELAY		50
+
+/* Sleep mode definitions */
+#define MAX3107_DISABLE_FORCED_SLEEP	0
+#define MAX3107_ENABLE_FORCED_SLEEP	1
+#define MAX3107_DISABLE_AUTOSLEEP	2
+#define MAX3107_ENABLE_AUTOSLEEP	3
+
+/* MAX3107 register definitions */
+#define MAX3107_RHR_REG			(0x00) /* RX FIFO */
+#define MAX3107_THR_REG			(0x00) /* TX FIFO */
+#define MAX3107_IRQEN_REG		(0x01) /* IRQ enable */
+#define MAX3107_IRQSTS_REG		(0x02) /* IRQ status */
+#define MAX3107_LSR_IRQEN_REG		(0x03) /* LSR IRQ enable */
+#define MAX3107_LSR_IRQSTS_REG		(0x04) /* LSR IRQ status */
+#define MAX3107_SPCHR_IRQEN_REG		(0x05) /* Special char IRQ enable */
+#define MAX3107_SPCHR_IRQSTS_REG	(0x06) /* Special char IRQ status */
+#define MAX3107_STS_IRQEN_REG		(0x07) /* Status IRQ enable */
+#define MAX3107_STS_IRQSTS_REG		(0x08) /* Status IRQ status */
+#define MAX3107_MODE1_REG		(0x09) /* MODE1 */
+#define MAX3107_MODE2_REG		(0x0a) /* MODE2 */
+#define MAX3107_LCR_REG			(0x0b) /* LCR */
+#define MAX3107_RXTO_REG		(0x0c) /* RX timeout */
+#define MAX3107_HDPIXDELAY_REG		(0x0d) /* Auto transceiver delays */
+#define MAX3107_IRDA_REG		(0x0e) /* IRDA settings */
+#define MAX3107_FLOWLVL_REG		(0x0f) /* Flow control levels */
+#define MAX3107_FIFOTRIGLVL_REG		(0x10) /* FIFO IRQ trigger levels */
+#define MAX3107_TXFIFOLVL_REG		(0x11) /* TX FIFO level */
+#define MAX3107_RXFIFOLVL_REG		(0x12) /* RX FIFO level */
+#define MAX3107_FLOWCTRL_REG		(0x13) /* Flow control */
+#define MAX3107_XON1_REG		(0x14) /* XON1 character */
+#define MAX3107_XON2_REG		(0x15) /* XON2 character */
+#define MAX3107_XOFF1_REG		(0x16) /* XOFF1 character */
+#define MAX3107_XOFF2_REG		(0x17) /* XOFF2 character */
+#define MAX3107_GPIOCFG_REG		(0x18) /* GPIO config */
+#define MAX3107_GPIODATA_REG		(0x19) /* GPIO data */
+#define MAX3107_PLLCFG_REG		(0x1a) /* PLL config */
+#define MAX3107_BRGCFG_REG		(0x1b) /* Baud rate generator conf */
+#define MAX3107_BRGDIVLSB_REG		(0x1c) /* Baud rate divisor LSB */
+#define MAX3107_BRGDIVMSB_REG		(0x1d) /* Baud rate divisor MSB */
+#define MAX3107_CLKSRC_REG		(0x1e) /* Clock source */
+#define MAX3107_REVID_REG		(0x1f) /* Revision identification */
+
+/* IRQ register bits */
+#define MAX3107_IRQ_LSR_BIT		(1 << 0) /* LSR interrupt */
+#define MAX3107_IRQ_SPCHR_BIT		(1 << 1) /* Special char interrupt */
+#define MAX3107_IRQ_STS_BIT		(1 << 2) /* Status interrupt */
+#define MAX3107_IRQ_RXFIFO_BIT		(1 << 3) /* RX FIFO interrupt */
+#define MAX3107_IRQ_TXFIFO_BIT		(1 << 4) /* TX FIFO interrupt */
+#define MAX3107_IRQ_TXEMPTY_BIT		(1 << 5) /* TX FIFO empty interrupt */
+#define MAX3107_IRQ_RXEMPTY_BIT		(1 << 6) /* RX FIFO empty interrupt */
+#define MAX3107_IRQ_CTS_BIT		(1 << 7) /* CTS interrupt */
+
+/* LSR register bits */
+#define MAX3107_LSR_RXTO_BIT		(1 << 0) /* RX timeout */
+#define MAX3107_LSR_RXOVR_BIT		(1 << 1) /* RX overrun */
+#define MAX3107_LSR_RXPAR_BIT		(1 << 2) /* RX parity error */
+#define MAX3107_LSR_FRERR_BIT		(1 << 3) /* Frame error */
+#define MAX3107_LSR_RXBRK_BIT		(1 << 4) /* RX break */
+#define MAX3107_LSR_RXNOISE_BIT		(1 << 5) /* RX noise */
+#define MAX3107_LSR_CTS_BIT		(1 << 7) /* CTS pin state */
+
+/* Special character register bits */
+#define MAX3107_SPCHR_XON1_BIT		(1 << 0) /* XON1 character */
+#define MAX3107_SPCHR_XON2_BIT		(1 << 1) /* XON2 character */
+#define MAX3107_SPCHR_XOFF1_BIT		(1 << 2) /* XOFF1 character */
+#define MAX3107_SPCHR_XOFF2_BIT		(1 << 3) /* XOFF2 character */
+#define MAX3107_SPCHR_BREAK_BIT		(1 << 4) /* RX break */
+#define MAX3107_SPCHR_MULTIDROP_BIT	(1 << 5) /* 9-bit multidrop addr char */
+
+/* Status register bits */
+#define MAX3107_STS_GPIO0_BIT		(1 << 0) /* GPIO 0 interrupt */
+#define MAX3107_STS_GPIO1_BIT		(1 << 1) /* GPIO 1 interrupt */
+#define MAX3107_STS_GPIO2_BIT		(1 << 2) /* GPIO 2 interrupt */
+#define MAX3107_STS_GPIO3_BIT		(1 << 3) /* GPIO 3 interrupt */
+#define MAX3107_STS_CLKREADY_BIT	(1 << 5) /* Clock ready */
+#define MAX3107_STS_SLEEP_BIT		(1 << 6) /* Sleep interrupt */
+
+/* MODE1 register bits */
+#define MAX3107_MODE1_RXDIS_BIT		(1 << 0) /* RX disable */
+#define MAX3107_MODE1_TXDIS_BIT		(1 << 1) /* TX disable */
+#define MAX3107_MODE1_TXHIZ_BIT		(1 << 2) /* TX pin three-state */
+#define MAX3107_MODE1_RTSHIZ_BIT	(1 << 3) /* RTS pin three-state */
+#define MAX3107_MODE1_TRNSCVCTRL_BIT	(1 << 4) /* Transceiver ctrl enable */
+#define MAX3107_MODE1_FORCESLEEP_BIT	(1 << 5) /* Force sleep mode */
+#define MAX3107_MODE1_AUTOSLEEP_BIT	(1 << 6) /* Auto sleep enable */
+#define MAX3107_MODE1_IRQSEL_BIT	(1 << 7) /* IRQ pin enable */
+
+/* MODE2 register bits */
+#define MAX3107_MODE2_RST_BIT		(1 << 0) /* Chip reset */
+#define MAX3107_MODE2_FIFORST_BIT	(1 << 1) /* FIFO reset */
+#define MAX3107_MODE2_RXTRIGINV_BIT	(1 << 2) /* RX FIFO INT invert */
+#define MAX3107_MODE2_RXEMPTINV_BIT	(1 << 3) /* RX FIFO empty INT invert */
+#define MAX3107_MODE2_SPCHR_BIT		(1 << 4) /* Special chr detect enable */
+#define MAX3107_MODE2_LOOPBACK_BIT	(1 << 5) /* Internal loopback enable */
+#define MAX3107_MODE2_MULTIDROP_BIT	(1 << 6) /* 9-bit multidrop enable */
+#define MAX3107_MODE2_ECHOSUPR_BIT	(1 << 7) /* ECHO suppression enable */
+
+/* LCR register bits */
+#define MAX3107_LCR_LENGTH0_BIT		(1 << 0) /* Word length bit 0 */
+#define MAX3107_LCR_LENGTH1_BIT		(1 << 1) /* Word length bit 1
+						  *
+						  * Word length bits table:
+						  * 00 -> 5 bit words
+						  * 01 -> 6 bit words
+						  * 10 -> 7 bit words
+						  * 11 -> 8 bit words
+						  */
+#define MAX3107_LCR_STOPLEN_BIT		(1 << 2) /* STOP length bit
+						  *
+						  * STOP length bit table:
+						  * 0 -> 1 stop bit
+						  * 1 -> 1-1.5 stop bits if
+						  *      word length is 5,
+						  *      2 stop bits otherwise
+						  */
+#define MAX3107_LCR_PARITY_BIT		(1 << 3) /* Parity bit enable */
+#define MAX3107_LCR_EVENPARITY_BIT	(1 << 4) /* Even parity bit enable */
+#define MAX3107_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
+#define MAX3107_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
+#define MAX3107_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
+#define MAX3107_LCR_WORD_LEN_5		(0x00)
+#define MAX3107_LCR_WORD_LEN_6		(0x01)
+#define MAX3107_LCR_WORD_LEN_7		(0x02)
+#define MAX3107_LCR_WORD_LEN_8		(0x03)
+
+/* IRDA register bits */
+#define MAX3107_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
+#define MAX3107_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
+#define MAX3107_IRDA_SHORTIR_BIT	(1 << 2) /* Short SIR mode enable */
+#define MAX3107_IRDA_MIR_BIT		(1 << 3) /* MIR mode enable */
+#define MAX3107_IRDA_RXINV_BIT		(1 << 4) /* RX logic inversion enable */
+#define MAX3107_IRDA_TXINV_BIT		(1 << 5) /* TX logic inversion enable */
+
+/* Flow control trigger level register masks */
+#define MAX3107_FLOWLVL_HALT_MASK	(0x000f) /* Flow control halt level */
+#define MAX3107_FLOWLVL_RES_MASK	(0x00f0) /* Flow control resume level */
+#define MAX3107_FLOWLVL_HALT(words)	((words / 8) & 0x0f)
+#define MAX3107_FLOWLVL_RES(words)	(((words / 8) & 0x0f) << 4)
+
+/* FIFO interrupt trigger level register masks */
+#define MAX3107_FIFOTRIGLVL_TX_MASK	(0x0f) /* TX FIFO trigger level */
+#define MAX3107_FIFOTRIGLVL_RX_MASK	(0xf0) /* RX FIFO trigger level */
+#define MAX3107_FIFOTRIGLVL_TX(words)	((words / 8) & 0x0f)
+#define MAX3107_FIFOTRIGLVL_RX(words)	(((words / 8) & 0x0f) << 4)
+
+/* Flow control register bits */
+#define MAX3107_FLOWCTRL_AUTORTS_BIT	(1 << 0) /* Auto RTS flow ctrl enable */
+#define MAX3107_FLOWCTRL_AUTOCTS_BIT	(1 << 1) /* Auto CTS flow ctrl enable */
+#define MAX3107_FLOWCTRL_GPIADDR_BIT	(1 << 2) /* Enables that GPIO inputs
+						  * are used in conjunction with
+						  * XOFF2 for definition of
+						  * special character */
+#define MAX3107_FLOWCTRL_SWFLOWEN_BIT	(1 << 3) /* Auto SW flow ctrl enable */
+#define MAX3107_FLOWCTRL_SWFLOW0_BIT	(1 << 4) /* SWFLOW bit 0 */
+#define MAX3107_FLOWCTRL_SWFLOW1_BIT	(1 << 5) /* SWFLOW bit 1
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
+#define MAX3107_FLOWCTRL_SWFLOW2_BIT	(1 << 6) /* SWFLOW bit 2 */
+#define MAX3107_FLOWCTRL_SWFLOW3_BIT	(1 << 7) /* SWFLOW bit 3
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
+#define MAX3107_GPIOCFG_GP0OUT_BIT	(1 << 0) /* GPIO 0 output enable */
+#define MAX3107_GPIOCFG_GP1OUT_BIT	(1 << 1) /* GPIO 1 output enable */
+#define MAX3107_GPIOCFG_GP2OUT_BIT	(1 << 2) /* GPIO 2 output enable */
+#define MAX3107_GPIOCFG_GP3OUT_BIT	(1 << 3) /* GPIO 3 output enable */
+#define MAX3107_GPIOCFG_GP0OD_BIT	(1 << 4) /* GPIO 0 open-drain enable */
+#define MAX3107_GPIOCFG_GP1OD_BIT	(1 << 5) /* GPIO 1 open-drain enable */
+#define MAX3107_GPIOCFG_GP2OD_BIT	(1 << 6) /* GPIO 2 open-drain enable */
+#define MAX3107_GPIOCFG_GP3OD_BIT	(1 << 7) /* GPIO 3 open-drain enable */
+
+/* GPIO DATA register bits */
+#define MAX3107_GPIODATA_GP0OUT_BIT	(1 << 0) /* GPIO 0 output value */
+#define MAX3107_GPIODATA_GP1OUT_BIT	(1 << 1) /* GPIO 1 output value */
+#define MAX3107_GPIODATA_GP2OUT_BIT	(1 << 2) /* GPIO 2 output value */
+#define MAX3107_GPIODATA_GP3OUT_BIT	(1 << 3) /* GPIO 3 output value */
+#define MAX3107_GPIODATA_GP0IN_BIT	(1 << 4) /* GPIO 0 input value */
+#define MAX3107_GPIODATA_GP1IN_BIT	(1 << 5) /* GPIO 1 input value */
+#define MAX3107_GPIODATA_GP2IN_BIT	(1 << 6) /* GPIO 2 input value */
+#define MAX3107_GPIODATA_GP3IN_BIT	(1 << 7) /* GPIO 3 input value */
+
+/* PLL configuration register masks */
+#define MAX3107_PLLCFG_PREDIV_MASK	(0x3f) /* PLL predivision value */
+#define MAX3107_PLLCFG_PLLFACTOR_MASK	(0xc0) /* PLL multiplication factor */
+
+/* Baud rate generator configuration register masks and bits */
+#define MAX3107_BRGCFG_FRACT_MASK	(0x0f) /* Fractional portion of
+						* Baud rate generator divisor
+						*/
+#define MAX3107_BRGCFG_2XMODE_BIT	(1 << 4) /* Double baud rate */
+#define MAX3107_BRGCFG_4XMODE_BIT	(1 << 5) /* Quadruple baud rate */
+
+/* Clock source register bits */
+#define MAX3107_CLKSRC_CRYST_BIT	(1 << 1) /* Crystal osc enable */
+#define MAX3107_CLKSRC_PLL_BIT		(1 << 2) /* PLL enable */
+#define MAX3107_CLKSRC_PLLBYP_BIT	(1 << 3) /* PLL bypass */
+#define MAX3107_CLKSRC_EXTCLK_BIT	(1 << 4) /* External clock enable */
+#define MAX3107_CLKSRC_CLK2RTS_BIT	(1 << 7) /* Baud clk to RTS pin */
+
+/* Misc definitions */
+#define MAX3107_FIFO_SIZE		(128)
+#define MAX3107_REV_ID			(0xa0)
+#define MAX3107_REV_MASK		(0xfe)
+
+/* Error status definitions */
+#define MAX3107_ERR_PARITY	MAX3107_LSR_RXPAR_BIT
+#define MAX3107_ERR_FRAME	MAX3107_LSR_FRERR_BIT
+#define MAX3107_ERR_OVERRUN	MAX3107_LSR_RXOVR_BIT
+#define MAX3107_ERR_BREAK	MAX3107_LSR_RXBRK_BIT
+
+/* IRQ status bits definitions */
+#define MAX3107_IRQ_TX		(MAX3107_IRQ_TXFIFO_BIT | MAX3107_IRQ_TXEMPTY_BIT)
+#define MAX3107_IRQ_RX		(MAX3107_IRQ_RXFIFO_BIT | MAX3107_IRQ_RXEMPTY_BIT)
+
+struct max3107_port {
+	struct uart_port	port;
+
+	struct regmap		*regmap;
+
+	struct workqueue_struct	*wq;
+	struct work_struct	tx_work;
+
+	struct mutex		max3107_mutex;
+
+	int			suspended;
+
+	struct max3107_plat	*pdata;
+};
+
+/* Baudrate table for 13 MHz external clock */
+const struct baud_table brg_table_13m[] = {
+	{ 300,		0x0a9400 | 0x05 },
+	{ 600,		0x054a00 | 0x03 },
+	{ 1200,		0x02a500 | 0x01 },
+	{ 2400,		0x015200 | 0x09 },
+	{ 4800,		0x00a900 | 0x04 },
+	{ 9600,		0x005400 | 0x0a },
+	{ 19200,	0x002a00 | 0x05 },
+	{ 38400,	0x001500 | 0x03 },
+	{ 57600,	0x000e00 | 0x02 },
+	{ 115200,	0x000700 | 0x01 },
+	{ 230400,	0x000300 | 0x08 },
+	{ 460800,	0x000100 | 0x0c },
+	{ 921600,	0x000100 | 0x1c },
+	{ 0, 0 }
+};
+EXPORT_SYMBOL_GPL(brg_table_13m);
+
+/* Baudrate table for 26 MHz external clock */
+const struct baud_table brg_table_26m[] = {
+	{ 300,		0x152800 | 0x0a },
+	{ 600,		0x0a9400 | 0x05 },
+	{ 1200,		0x054a00 | 0x03 },
+	{ 2400,		0x02a500 | 0x01 },
+	{ 4800,		0x015200 | 0x09 },
+	{ 9600,		0x00a900 | 0x04 },
+	{ 19200,	0x005400 | 0x0a },
+	{ 38400,	0x002a00 | 0x05 },
+	{ 57600,	0x001c00 | 0x03 },
+	{ 115200,	0x000e00 | 0x02 },
+	{ 230400,	0x000700 | 0x01 },
+	{ 460800,	0x000300 | 0x08 },
+	{ 921600,	0x000100 | 0x0c },
+	{ 0, 0 }
+};
+EXPORT_SYMBOL_GPL(brg_table_26m);
+
+/* Baudrate table for 3.6864 MHz external clock */
+const struct baud_table brg_table_3_6864m[] = {
+	{ 300,		0x030000 | 0x00 },
+	{ 600,		0x018000 | 0x00 },
+	{ 1200,		0x00c000 | 0x00 },
+	{ 2400,		0x006000 | 0x00 },
+	{ 4800,		0x003000 | 0x00 },
+	{ 9600,		0x001800 | 0x00 },
+	{ 19200,	0x000c00 | 0x00 },
+	{ 38400,	0x000600 | 0x00 },
+	{ 57600,	0x000400 | 0x00 },
+	{ 115200,	0x000200 | 0x00 },
+	{ 230400,	0x000100 | 0x00 },
+	{ 460800,	0x000100 | 0x10 },
+	{ 921600,	0x000100 | 0x20 },
+	{ 0, 0 }
+};
+EXPORT_SYMBOL_GPL(brg_table_3_6864m);
+
+static bool max3107_reg_writeable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX3107_IRQSTS_REG:
+	case MAX3107_LSR_IRQSTS_REG:
+	case MAX3107_SPCHR_IRQSTS_REG:
+	case MAX3107_STS_IRQSTS_REG:
+	case MAX3107_TXFIFOLVL_REG:
+	case MAX3107_RXFIFOLVL_REG:
+	case MAX3107_REVID_REG:
+		return false;
+	default:
+		break;
+	}
+
+	return true;
+}
+
+static bool max3107_reg_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX3107_RHR_REG:
+	case MAX3107_IRQSTS_REG:
+	case MAX3107_LSR_IRQSTS_REG:
+	case MAX3107_SPCHR_IRQSTS_REG:
+	case MAX3107_STS_IRQSTS_REG:
+	case MAX3107_TXFIFOLVL_REG:
+	case MAX3107_RXFIFOLVL_REG:
+	case MAX3107_GPIODATA_REG:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static bool max3107_reg_precious(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX3107_RHR_REG:
+	case MAX3107_IRQSTS_REG:
+	case MAX3107_SPCHR_IRQSTS_REG:
+	case MAX3107_STS_IRQSTS_REG:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static struct regmap_config max3107_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= 0x1f,
+	.read_flag_mask	= 0x00,
+	.write_flag_mask= 0x80,
+	.cache_type	= REGCACHE_RBTREE,
+	.writeable_reg	= max3107_reg_writeable,
+	.volatile_reg	= max3107_reg_volatile,
+	.precious_reg	= max3107_reg_precious,
+};
+
+static u32 max3107_get_brg(int baud, struct max3107_port *s)
+{
+	int i;
+	const struct baud_table *baud_tbl = s->pdata->baud_tbl;
+
+	for (i = 0; baud_tbl[i].baud; i++) {
+		if (baud == baud_tbl[i].baud)
+			return baud_tbl[i].brg;
+	}
+
+	return 0;
+}
+
+static void max3107_handle_rx(struct max3107_port *s, unsigned int rxlen)
+{
+	unsigned int status, ch, flag;
+	struct tty_struct *tty = s->port.state->port.tty;
+
+	if (rxlen >= MAX3107_FIFO_SIZE) {
+		dev_warn(s->port.dev, "Possible RX FIFO overrun %d\n", rxlen);
+		/* Ensure sanity of RX level */
+		rxlen = MAX3107_FIFO_SIZE;
+	}
+
+	dev_dbg(s->port.dev, "RX Len = %u\n", rxlen);
+
+	while (rxlen--) {
+		regmap_read(s->regmap, MAX3107_RHR_REG, &ch);
+		regmap_read(s->regmap, MAX3107_LSR_IRQSTS_REG, &status);
+
+		status &= MAX3107_ERR_PARITY | MAX3107_ERR_FRAME |
+			  MAX3107_ERR_OVERRUN | MAX3107_ERR_BREAK;
+
+		s->port.icount.rx++;
+		flag = TTY_NORMAL;
+
+		if (unlikely(status)) {
+			if (status & MAX3107_ERR_BREAK) {
+				s->port.icount.brk++;
+				if (uart_handle_break(&s->port))
+					continue;
+			} else if (status & MAX3107_ERR_PARITY)
+				s->port.icount.parity++;
+			else if (status & MAX3107_ERR_FRAME)
+				s->port.icount.frame++;
+			else if (status & MAX3107_ERR_OVERRUN)
+				s->port.icount.overrun++;
+
+			status &= s->port.read_status_mask;
+			if (status & MAX3107_ERR_BREAK)
+				flag = TTY_BREAK;
+			else if (status & MAX3107_ERR_PARITY)
+				flag = TTY_PARITY;
+			else if (status & MAX3107_ERR_FRAME)
+				flag = TTY_FRAME;
+			else if (status & MAX3107_ERR_OVERRUN)
+				flag = TTY_OVERRUN;
+		}
+
+		if (uart_handle_sysrq_char(s->port, ch))
+			continue;
+
+		if (status & s->port.ignore_status_mask)
+			continue;
+
+		uart_insert_char(&s->port, status, MAX3107_ERR_OVERRUN, ch, flag);
+	}
+
+	tty_flip_buffer_push(tty);
+}
+
+static void max3107_handle_tx(struct max3107_port *s)
+{
+	struct circ_buf *xmit = &s->port.state->xmit;
+	unsigned int txlen, to_send;
+
+	if (s->port.x_char) {
+		regmap_write(s->regmap, MAX3107_THR_REG, s->port.x_char);
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
+	if (to_send) {
+		/* Limit to size of TX FIFO */
+		regmap_read(s->regmap, MAX3107_TXFIFOLVL_REG, &txlen);
+		txlen = MAX3107_FIFO_SIZE - txlen;
+		to_send = (to_send > txlen) ? txlen : to_send;
+
+		dev_dbg(s->port.dev, "TX Len = %u\n", to_send);
+
+		/* Add data to send */
+		s->port.icount.tx += to_send;
+		do {
+			regmap_write(s->regmap, MAX3107_THR_REG, xmit->buf[xmit->tail]);
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		} while (--to_send > 0);
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&s->port);
+}
+
+static irqreturn_t max3107_ist(int irq, void *dev_id)
+{
+	struct max3107_port *s = (struct max3107_port*)dev_id;
+	unsigned int ists, lsr, rxlen;
+
+	mutex_lock(&s->max3107_mutex);
+
+	for (;;) {
+		/* Read IRQ status & RX FIFO level */
+		regmap_read(s->regmap, MAX3107_IRQSTS_REG, &ists);
+		regmap_read(s->regmap, MAX3107_RXFIFOLVL_REG, &rxlen);
+		if (!ists && !(lsr & MAX3107_LSR_RXTO_BIT) && !rxlen)
+			break;
+
+		dev_dbg(s->port.dev, "IRQ status: 0x%02x\n", ists);
+
+		if (rxlen)
+			max3107_handle_rx(s, rxlen);
+		if (ists & MAX3107_IRQ_TX)
+			max3107_handle_tx(s);
+		if (ists & MAX3107_IRQ_CTS_BIT) {
+			regmap_read(s->regmap, MAX3107_LSR_IRQSTS_REG, &lsr);
+			uart_handle_cts_change(&s->port,
+					       !!(lsr & MAX3107_LSR_CTS_BIT));
+		}
+	}
+
+	mutex_unlock(&s->max3107_mutex);
+
+	return IRQ_HANDLED;
+}
+
+static void max3107_wq_proc(struct work_struct *ws)
+{
+	struct max3107_port *s = container_of(ws, struct max3107_port, tx_work);
+
+	mutex_lock(&s->max3107_mutex);
+
+	max3107_handle_tx(s);
+
+	mutex_unlock(&s->max3107_mutex);
+}
+
+static void max3107_enable_ms(struct uart_port *port)
+{
+	/* Modem status not supported */
+}
+
+static void max3107_start_tx(struct uart_port *port)
+{
+	struct max3107_port *s = container_of(port, struct max3107_port, port);
+
+	queue_work(s->wq, &s->tx_work);
+}
+
+static void max3107_stop_tx(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static void max3107_stop_rx(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static unsigned int max3107_tx_empty(struct uart_port *port)
+{
+	unsigned int val;
+	struct max3107_port *s = container_of(port, struct max3107_port, port);
+
+	mutex_lock(&s->max3107_mutex);
+	regmap_read(s->regmap, MAX3107_TXFIFOLVL_REG, &val);
+	mutex_unlock(&s->max3107_mutex);
+
+	return val ? 0: TIOCSER_TEMT;
+}
+
+static unsigned int max3107_get_mctrl(struct uart_port *port)
+{
+	/* DCD and DSR are not wired and CTS/RTS is handled automatically
+	 * so just indicate DSR and CAR asserted
+	 */
+	return TIOCM_DSR | TIOCM_CAR;
+}
+
+static void max3107_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* DCD and DSR are not wired and CTS/RTS is hadnled automatically
+	 * so do nothing
+	 */
+}
+
+static void max3107_set_termios(struct uart_port *port,
+				struct ktermios *termios,
+				struct ktermios *old)
+{
+	struct max3107_port *s = container_of(port, struct max3107_port, port);
+	struct tty_struct *tty;
+	int baud;
+	u16 lcr;
+	u32 brg = 0;
+
+	if (!port->state)
+		return;
+
+	tty = port->state->port.tty;
+	if (!tty)
+		return;
+
+	/* Word size */
+	if ((termios->c_cflag & CSIZE) == CS7)
+		lcr = MAX3107_LCR_WORD_LEN_7;
+	else
+		lcr = MAX3107_LCR_WORD_LEN_8;
+
+	/* Parity */
+	if (termios->c_cflag & PARENB) {
+		lcr |= MAX3107_LCR_PARITY_BIT;
+		if (!(termios->c_cflag & PARODD))
+			lcr |= MAX3107_LCR_EVENPARITY_BIT;
+	}
+
+	/* Stop bits */
+	if (termios->c_cflag & CSTOPB)
+		lcr |= MAX3107_LCR_STOPLEN_BIT; /* 2 stops */
+
+	/* Mask termios capabilities we don't support */
+	termios->c_cflag &= ~CMSPAR;
+
+	/* Set read status mask */
+	s->port.read_status_mask = MAX3107_ERR_OVERRUN;
+	if (termios->c_iflag & INPCK)
+		s->port.read_status_mask |= MAX3107_ERR_PARITY | MAX3107_ERR_FRAME;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		s->port.read_status_mask |= MAX3107_ERR_BREAK;
+
+	/* Set status ignore mask */
+	s->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNBRK)
+		s->port.ignore_status_mask |= MAX3107_ERR_BREAK;
+	if (!(termios->c_cflag & CREAD))
+		s->port.ignore_status_mask |= MAX3107_ERR_PARITY |
+					      MAX3107_ERR_OVERRUN |
+					      MAX3107_ERR_FRAME |
+					      MAX3107_ERR_BREAK;
+
+	/* Get new baud rate generator configuration */
+	baud = tty_get_baud_rate(tty);
+
+	brg = max3107_get_brg(baud, s);
+	tty_termios_encode_baud_rate(termios, baud, baud);
+
+	/* Update timeout according to new baud rate */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	mutex_lock(&s->max3107_mutex);
+
+	regmap_write(s->regmap, MAX3107_LCR_REG, lcr);
+	regmap_write(s->regmap, MAX3107_BRGDIVMSB_REG, brg >> 16);
+	regmap_write(s->regmap, MAX3107_BRGDIVLSB_REG, brg >> 8);
+	regmap_write(s->regmap, MAX3107_BRGCFG_REG, brg);
+
+	mutex_unlock(&s->max3107_mutex);
+}
+
+static void max3107_register_init(struct max3107_port *s)
+{
+	unsigned int val;
+
+	/* Configure baud rate, 9600 as default */
+	val = max3107_get_brg(9600, s);
+
+	regmap_write(s->regmap, MAX3107_BRGDIVMSB_REG, val >> 16);
+	regmap_write(s->regmap, MAX3107_BRGDIVLSB_REG, val >> 8);
+	regmap_write(s->regmap, MAX3107_BRGCFG_REG, val);
+
+	/* Configure LCR register, 8N1 mode by default */
+	val = MAX3107_LCR_WORD_LEN_8;
+	regmap_write(s->regmap, MAX3107_LCR_REG, val);
+
+	/* Configure MODE1 register */
+	val = MAX3107_MODE1_IRQSEL_BIT; /* Enable IRQ pin */
+	if (s->pdata->flags & MAX3107_AUTO_DIR_CTRL)
+		val |= MAX3107_MODE1_TRNSCVCTRL_BIT;
+	regmap_write(s->regmap, MAX3107_MODE1_REG, val);
+
+	/* Configure MODE2 register */
+	val = MAX3107_MODE2_RXEMPTINV_BIT;
+	if (s->pdata->flags & MAX3107_LOOPBACK)
+		val |= MAX3107_MODE2_LOOPBACK_BIT;
+	if (s->pdata->flags & MAX3107_ECHO_SUPRESS)
+		val |= MAX3107_MODE2_ECHOSUPR_BIT;
+
+	/* Reset FIFOs */
+	val |= MAX3107_MODE2_FIFORST_BIT;
+	regmap_write(s->regmap, MAX3107_MODE2_REG, val);
+
+	/* Configure FIFO trigger level register */
+	/* RX FIFO trigger for 16 words, TX FIFO trigger for 64 words */
+	val = MAX3107_FIFOTRIGLVL_RX(16) | MAX3107_FIFOTRIGLVL_TX(64);
+	regmap_write(s->regmap, MAX3107_FIFOTRIGLVL_REG, val);
+
+	/* Configure flow control levels */
+	/* Flow control halt level 96, resume level 48 */
+	val = MAX3107_FLOWLVL_RES(48) | MAX3107_FLOWLVL_HALT(96);
+	regmap_write(s->regmap, MAX3107_FLOWLVL_REG, val);
+
+	/* Configure flow control */
+	val = (s->pdata->flags & MAX3107_AUTOCTS) ? MAX3107_FLOWCTRL_AUTOCTS_BIT : 0;
+	val |= (s->pdata->flags & MAX3107_AUTORTS) ? MAX3107_FLOWCTRL_AUTORTS_BIT : 0;
+	regmap_write(s->regmap, MAX3107_FLOWCTRL_REG, val);
+
+	/* Clear timeout register */
+	regmap_write(s->regmap, MAX3107_RXTO_REG, 0);
+
+	/* Configure LSR interrupt enable register */
+	/* Enable RX timeout interrupt */
+	val = MAX3107_LSR_RXTO_BIT;
+	regmap_write(s->regmap, MAX3107_LSR_IRQEN_REG, val);
+
+	/* Clear FIFO reset */
+	regmap_update_bits(s->regmap, MAX3107_MODE2_REG,
+			   MAX3107_MODE2_FIFORST_BIT, 0);
+
+	/* Clear IRQ status register by reading it */
+	regmap_read(s->regmap, MAX3107_IRQSTS_REG, &val);
+
+	/* Configure interrupt enable register */
+	/* Enable CTS change interrupt */
+	val = MAX3107_IRQ_CTS_BIT;
+	/* Enable RX, TX interrupts */
+	val |= MAX3107_IRQ_RX | MAX3107_IRQ_TX;
+	regmap_write(s->regmap, MAX3107_IRQEN_REG, val);
+}
+
+static int max3107_startup(struct uart_port *port)
+{
+	struct max3107_port *s = container_of(port, struct max3107_port, port);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(s, 0);
+
+	/* Init registers */
+	max3107_register_init(s);
+
+	/* Setup interrupt */
+	if (devm_request_threaded_irq(port->dev, port->irq, NULL, max3107_ist,
+				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				      "max3107", s)) {
+		dev_err(port->dev, "Unable to reguest IRQ %i\n", port->irq);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void max3107_shutdown(struct uart_port *port)
+{
+	struct max3107_port *s = container_of(port, struct max3107_port, port);
+
+	if (s->suspended && s->pdata->suspend)
+		s->pdata->suspend(s, 0);
+
+	/* Disable all interrupts */
+	mutex_lock(&s->max3107_mutex);
+	regmap_write(s->regmap, MAX3107_IRQEN_REG, 0);
+	mutex_unlock(&s->max3107_mutex);
+
+	/* Free the interrupt */
+	devm_free_irq(port->dev, port->irq, s);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(s, 1);
+}
+
+static const char *max3107_type(struct uart_port *port)
+{
+	return (port->type == PORT_MAX3107) ? "MAX3107" : NULL;
+}
+
+static void max3107_release_port(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static int max3107_request_port(struct uart_port *port)
+{
+	/* Do nothing */
+	return 0;
+}
+
+static void max3107_config_port(struct uart_port *port, int flags)
+{
+	struct max3107_port *s = container_of(port, struct max3107_port, port);
+
+	s->port.type = PORT_MAX3107;
+}
+
+static int max3107_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	if ((ser->type == PORT_UNKNOWN) || (ser->type == PORT_MAX3107))
+		return 0;
+
+	return -EINVAL;
+}
+
+static void max3107_break_ctl(struct uart_port *port, int break_state)
+{
+	/* We don't support break control, do nothing */
+}
+
+static struct uart_ops max3107_ops = {
+	.tx_empty	= max3107_tx_empty,
+	.set_mctrl	= max3107_set_mctrl,
+	.get_mctrl	= max3107_get_mctrl,
+	.stop_tx	= max3107_stop_tx,
+	.start_tx	= max3107_start_tx,
+	.stop_rx	= max3107_stop_rx,
+	.enable_ms	= max3107_enable_ms,
+	.break_ctl	= max3107_break_ctl,
+	.startup	= max3107_startup,
+	.shutdown	= max3107_shutdown,
+	.set_termios	= max3107_set_termios,
+	.type		= max3107_type,
+	.request_port	= max3107_request_port,
+	.release_port	= max3107_release_port,
+	.config_port	= max3107_config_port,
+	.verify_port	= max3107_verify_port,
+};
+
+static struct uart_driver max3107_uart_driver = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "ttyMAX",
+	.dev_name	= "ttyMAX",
+	.major		= MAX3107_MAJOR,
+	.minor		= MAX3107_MINOR,
+	.nr		= 1,
+	.cons		= NULL,
+};
+
+static volatile int driver_registered = 0;
+
+static void max3107_set_sleep(struct max3107_port *s, int mode)
+{
+	unsigned int val;
+
+	mutex_lock(&s->max3107_mutex);
+
+	regmap_read(s->regmap, MAX3107_MODE1_REG, &val);
+
+	switch (mode) {
+	case MAX3107_DISABLE_FORCED_SLEEP:
+		val &= ~MAX3107_MODE1_FORCESLEEP_BIT;
+		break;
+	case MAX3107_ENABLE_FORCED_SLEEP:
+		val |= MAX3107_MODE1_FORCESLEEP_BIT;
+		break;
+	case MAX3107_DISABLE_AUTOSLEEP:
+		val &= ~MAX3107_MODE1_AUTOSLEEP_BIT;
+		break;
+	case MAX3107_ENABLE_AUTOSLEEP:
+		val |= MAX3107_MODE1_AUTOSLEEP_BIT;
+		break;
+	default:
+		dev_warn(s->port.dev, "Invalid sleep mode %i\n", mode);
+		mutex_unlock(&s->max3107_mutex);
+		return;
+	}
+
+	regmap_write(s->regmap, MAX3107_MODE1_REG, val);
+
+	if ((mode == MAX3107_DISABLE_AUTOSLEEP) ||
+	    (mode == MAX3107_DISABLE_FORCED_SLEEP))
+		msleep(MAX3107_WAKEUP_DELAY);
+
+	mutex_unlock(&s->max3107_mutex);
+}
+
+static int max3107_suspend(struct spi_device *spi, pm_message_t state)
+{
+	int ret;
+	struct max3107_port *s = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(&spi->dev, "Suspend\n");
+
+	ret = uart_suspend_port(&max3107_uart_driver, &s->port);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(s, 1);
+
+	return ret;
+}
+
+static int max3107_resume(struct spi_device *spi)
+{
+	struct max3107_port *s = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(&spi->dev, "Resume\n");
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(s, 0);
+
+	return uart_resume_port(&max3107_uart_driver, &s->port);
+}
+
+void max3107_default_suspend(struct max3107_port *s, int do_suspend)
+{
+	dev_dbg(s->port.dev, "Change suspend state to %i\n", do_suspend);
+
+	s->suspended = do_suspend;
+	max3107_set_sleep(s, do_suspend ? MAX3107_ENABLE_AUTOSLEEP :
+					  MAX3107_DISABLE_AUTOSLEEP);
+}
+EXPORT_SYMBOL_GPL(max3107_default_suspend);
+
+/* Generic platform data */
+static struct max3107_plat generic_plat_data = {
+	.flags		= MAX3107_EXT_CLK | MAX3107_AUTOCTS | MAX3107_AUTORTS,
+	.baud_tbl	= brg_table_26m,
+	.suspend	= &max3107_default_suspend,
+};
+
+static int __devinit max3107_probe(struct spi_device *spi)
+{
+	struct max3107_port *s;
+	struct max3107_plat *pdata = spi->dev.platform_data;
+	int ret;
+	unsigned int val;
+
+	/* Check for IRQ */
+	if (spi->irq <= 0) {
+		dev_err(&spi->dev, "No IRQ specified\n");
+		return -ENOTSUPP;
+	}
+
+	/* Alloc port structure */
+	s = devm_kzalloc(&spi->dev, sizeof(struct max3107_port), GFP_KERNEL);
+	if (!s) {
+		dev_err(&spi->dev, "Error allocating port structure\n");
+		return -ENOMEM;
+	}
+
+	if (!pdata) {
+		dev_warn(&spi->dev, "No platform data supplied, using defaults\n");
+		pdata = &generic_plat_data;
+	}
+	s->pdata = pdata;
+	dev_set_drvdata(&spi->dev, s);
+
+	/* Board specific configure */
+	if (pdata->configure)
+		pdata->configure();
+
+	mutex_init(&s->max3107_mutex);
+
+	/* Setup SPI bus */
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+	spi->max_speed_hz = 26000000;
+	spi_setup(spi);
+
+	s->regmap = devm_regmap_init_spi(spi, &max3107_regmap_config);
+	if (IS_ERR(s->regmap)) {
+		ret = PTR_ERR(s->regmap);
+		dev_err(&spi->dev, "Failed to initialize register map: %d\n", ret);
+		goto err_out;
+	}
+
+	/* Check REV ID to ensure we are talking to what we expect */
+	if (regmap_read(s->regmap, MAX3107_REVID_REG, &val)) {
+		dev_err(&spi->dev, "SPI transfer failed\n");
+		ret = -EIO;
+		goto err_out;
+	}
+
+	if (((val & MAX3107_REV_MASK) != MAX3107_REV_ID)) {
+		dev_err(&spi->dev, "Device ID 0x%02x does not match\n", val);
+		ret = -ENODEV;
+		goto err_out;
+	}
+
+	/* Disable all interrupts */
+	regmap_write(s->regmap, MAX3107_IRQEN_REG, 0);
+
+	/* Configure clock source */
+	val = MAX3107_CLKSRC_PLLBYP_BIT; /* PLL bypass ON */
+	if (pdata->flags & MAX3107_EXT_CLK)
+		val |= MAX3107_CLKSRC_EXTCLK_BIT;
+	else
+		val |= MAX3107_CLKSRC_CRYST_BIT;
+	regmap_write(s->regmap, MAX3107_CLKSRC_REG, val);
+
+	/* Register UART driver */
+	if (!driver_registered) {
+		ret = uart_register_driver(&max3107_uart_driver);
+		if (ret) {
+			dev_err(&spi->dev, "Registering UART driver failed\n");
+			goto err_out;
+		}
+	}
+	driver_registered++;
+
+	/* Initialize UART port data */
+	s->port.fifosize	= MAX3107_FIFO_SIZE;
+	s->port.ops		= &max3107_ops;
+	s->port.dev		= &spi->dev;
+	s->port.uartclk		= 9600; /* Bogus value */
+	s->port.flags		= UPF_SKIP_TEST;
+	s->port.irq		= spi->irq;
+	s->port.type		= PORT_MAX3107;
+
+	uart_add_one_port(&max3107_uart_driver, &s->port);
+
+	/* Initialize workqueue for start TX */
+	s->wq = create_freezable_workqueue("max3107_wq");
+	INIT_WORK(&s->tx_work, max3107_wq_proc);
+
+	/* Go to suspend mode */
+	if (pdata->suspend)
+		pdata->suspend(s, 1);
+
+	dev_info(&spi->dev, "MAX3107 UART driver registered\n");
+
+	return 0;
+
+err_out:
+	devm_kfree(&spi->dev, s);
+
+	return ret;
+}
+
+static int __devexit max3107_remove(struct spi_device *spi)
+{
+	struct max3107_port *s = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(s->port.dev, "Removing port\n");
+
+	destroy_workqueue(s->wq);
+
+	uart_remove_one_port(&max3107_uart_driver, &s->port);
+	dev_set_drvdata(&spi->dev, NULL);
+
+	if (driver_registered == 1)
+		uart_unregister_driver(&max3107_uart_driver);
+	driver_registered--;
+
+	devm_kfree(&spi->dev, s);
+
+	return 0;
+}
+
+static struct spi_driver max3107_driver = {
+	.driver = {
+		.name	= "max3107",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max3107_probe,
+	.remove		= __devexit_p(max3107_remove),
+	.suspend	= max3107_suspend,
+	.resume		= max3107_resume,
+};
+module_spi_driver(max3107_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Aavamobile");
+MODULE_DESCRIPTION("MAX3107 UART driver");
diff --git a/include/linux/platform_data/max3107.h b/include/linux/platform_data/max3107.h
new file mode 100644
index 0000000..6e13701
--- /dev/null
+++ b/include/linux/platform_data/max3107.h
@@ -0,0 +1,56 @@
+/*
+ *  SPI UART protocol driver for Maxim (Dallas) MAX3107
+ *
+ *  Based on max3100.c
+ *    by Christian Pellegrin <chripell@evolware.org>
+ *  and max3110.c
+ *    by Feng Tang <feng.tang@intel.com>
+ *
+ *  Rewritten by Alexander Shiyan <shc_work@mail.ru>
+ *
+ *  Copyright (C) Aavamobile 2009
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+#ifndef _MAX3107_H_
+#define _MAX3107_H_
+
+struct baud_table {
+	int baud;
+	u32 brg;
+};
+
+struct max3107_port;
+
+/* MAX3107 platform data structure */
+struct max3107_plat {
+	/* Platform data flags definitions */
+	const unsigned int	flags;
+#define MAX3107_LOOPBACK	(0x00000001)	/* Loopback mode enable */
+#define MAX3107_EXT_CLK		(0x00000002)	/* External clock enable */
+#define MAX3107_AUTOCTS		(0x00000004)	/* Enable auto CTS flow control */
+#define MAX3107_AUTORTS		(0x00000008)	/* Enable auto RTS flow control */
+#define MAX3107_ECHO_SUPRESS	(0x00000010)	/* Enable echo supress */
+#define MAX3107_AUTO_DIR_CTRL	(0x00000020)	/* Enable Auto direction control (RS-485) */
+	/* Baudrate table */
+	const struct baud_table	*baud_tbl;
+	/* GPIO base number */
+	const unsigned int	gpio_base; /* Not implemented yet */
+	/* Called before initialization */
+	void (*configure)(void);
+	/* HW suspend function */
+	void (*suspend)(struct max3107_port *s, int do_suspend);
+};
+
+/* Functions that can be reused in board support code */
+void max3107_default_suspend(struct max3107_port *s, int do_suspend);
+
+/* Tables that can be reused in board support code */
+extern const struct baud_table brg_table_13m[];
+extern const struct baud_table brg_table_26m[];
+extern const struct baud_table brg_table_3_6864m[];
+
+#endif
-- 
1.7.3.4

