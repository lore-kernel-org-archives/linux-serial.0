From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2] serial: The new version of the driver MAX3107, now called MAX310X.
Date: Mon, 30 Jul 2012 18:08:02 +0400
Message-ID: <1343657282-3508-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp23.mail.ru ([94.100.176.176]:39658 "EHLO smtp23.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754473Ab2G3OIO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Jul 2012 10:08:14 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This is NOT a patch. Only for initial review and comment. so, do NOT apply.

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
- Ability to load multiple instances of drivers.
- Header moved to include/linux/platform_data.
- Cleanup, cleanup, cleanup...

Changes since v1:
- Fixes that are indicated by Alan Cox.
- Proper hardware & software flow control support.
- Fixed bug with using uninitialized values passed to regmap_read.
- Tables for the data transfer speed is no longer needed. The input
  parameter "frequency" is calculated with all possible multipliers
  and dividers to get the value with minimal error. All possible
  options for the clock or crystal supported.
- Added support for MAX3108, so the driver is renamed to MAX310X.
  In the future, I plan to add support for MAX3109 and MAX14830 chips,
  which have a compatible registers set.
---
 drivers/tty/serial/Kconfig            |   11 +-
 drivers/tty/serial/Makefile           |    2 +-
 drivers/tty/serial/max3107.c          | 1215 ---------------------------------
 drivers/tty/serial/max3107.h          |  441 ------------
 drivers/tty/serial/max310x.c          | 1205 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/max310x.h |   47 ++
 include/linux/serial_core.h           |    4 +-
 7 files changed, 1263 insertions(+), 1662 deletions(-)
 delete mode 100644 drivers/tty/serial/max3107.c
 delete mode 100644 drivers/tty/serial/max3107.h
 create mode 100644 drivers/tty/serial/max310x.c
 create mode 100644 include/linux/platform_data/max310x.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 070b442..4ecef98 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -257,12 +257,17 @@ config SERIAL_MAX3100
 	help
 	  MAX3100 chip support
 
-config SERIAL_MAX3107
-	tristate "MAX3107 support"
+config SERIAL_MAX310X
+	bool "MAX310X support"
 	depends on SPI
 	select SERIAL_CORE
+	select REGMAP_SPI if SPI
 	help
-	  MAX3107 chip support
+	  The MAX3107/8 is an advanced universal asynchronous receiver-transmitter
+	  with 128 words each of receive and transmit first-in/first-out (FIFO)
+	  that can be controlled through I2C or high-speed SPI.
+
+	  Say Y here if you want to support this chip.
 
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
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
new file mode 100644
index 0000000..ed671e8
--- /dev/null
+++ b/drivers/tty/serial/max310x.c
@@ -0,0 +1,1205 @@
+/*
+ *  UART protocol driver for Maxim (Dallas) MAX3107/8
+ *
+ *  Based on max3100.c
+ *    by Christian Pellegrin <chripell@evolware.org>
+ *  and max3110.c
+ *    by Feng Tang <feng.tang@intel.com>
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
+/* TODO: MAX3109 support (Dual) */
+/* TODO: MAX14830 support (Quad) */
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
+#include <linux/platform_data/max310x.h>
+
+#define MAX310X_MAJOR			204
+#define MAX310X_MINOR			209
+
+/* Chip wakeup delay */
+#define MAX310X_WAKEUP_DELAY		50
+
+/* Sleep mode definitions */
+#define MAX310X_DISABLE_FORCED_SLEEP	0
+#define MAX310X_ENABLE_FORCED_SLEEP	1
+#define MAX310X_DISABLE_AUTOSLEEP	2
+#define MAX310X_ENABLE_AUTOSLEEP	3
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
+/* Baud rate generator configuration register masks and bits */
+#define MAX310X_BRGCFG_FRACT_MASK	(0x0f) /* Fractional portion of
+						* Baud rate generator divisor
+						*/
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
+/* Error status definitions */
+#define MAX310X_ERR_PARITY		MAX310X_LSR_RXPAR_BIT
+#define MAX310X_ERR_FRAME		MAX310X_LSR_FRERR_BIT
+#define MAX310X_ERR_OVERRUN		MAX310X_LSR_RXOVR_BIT
+#define MAX310X_ERR_BREAK		MAX310X_LSR_RXBRK_BIT
+
+/* IRQ status bits definitions */
+#define MAX310X_IRQ_TX			(MAX310X_IRQ_TXFIFO_BIT | \
+					 MAX310X_IRQ_TXEMPTY_BIT)
+#define MAX310X_IRQ_RX			(MAX310X_IRQ_RXFIFO_BIT | \
+					 MAX310X_IRQ_RXEMPTY_BIT)
+/* Supported chip types */
+enum {
+	MAX310X_TYPE_MAX3107,
+	MAX310X_TYPE_MAX3108,
+};
+
+struct max310x_port {
+	struct uart_port	port;
+	struct uart_driver	uart;
+
+	const char		*name;
+
+	struct regmap		*regmap;
+	struct regmap_config	regcfg;
+
+	struct workqueue_struct	*wq;
+	struct work_struct	tx_work;
+
+	struct mutex		max310x_mutex;
+
+	int			suspended;
+
+	struct max310x_pdata	*pdata;
+
+	unsigned int		nr_gpio;
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
+	unsigned int mode = 0, div = s->port.uartclk / baud;
+
+	if (!(div / 16)) {
+		/* Mode x2 */
+		mode = MAX310X_BRGCFG_2XMODE_BIT;
+		div = (s->port.uartclk * 2) / baud;
+	}
+
+	if (!(div / 16)) {
+		/* Mode x4 */
+		mode = MAX310X_BRGCFG_4XMODE_BIT;
+		div = (s->port.uartclk * 4) / baud;
+	}
+
+	regmap_write(s->regmap, MAX310X_BRGDIVMSB_REG, ((div / 16) >> 8) & 0xff);
+	regmap_write(s->regmap, MAX310X_BRGDIVLSB_REG, (div / 16) & 0xff);
+	regmap_write(s->regmap, MAX310X_BRGCFG_REG, (div % 16) | mode);
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
+	unsigned int div, clksrc, sts = 0, pllcfg = 0;
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
+		if ((fdiv >=500000) && (fdiv <= 800000))
+			if (!max310x_update_best_err(fmul, &besterr)) {
+				pllcfg = (0 << 6) | div;
+				bestfreq = fmul;
+			}
+		/* Try multiplier 48 */
+		fmul = fdiv * 48;
+		if ((fdiv >=850000) && (fdiv <= 1200000))
+			if (!max310x_update_best_err(fmul, &besterr)) {
+				pllcfg = (1 << 6) | div;
+				bestfreq = fmul;
+			}
+		/* Try multiplier 96 */
+		fmul = fdiv * 96;
+		if ((fdiv >=425000) && (fdiv <= 1000000))
+			if (!max310x_update_best_err(fmul, &besterr)) {
+				pllcfg = (2 << 6) | div;
+				bestfreq = fmul;
+			}
+		/* Try multiplier 144 */
+		fmul = fdiv * 144;
+		if ((fdiv >=390000) && (fdiv <= 667000))
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
+	if (pllcfg && !(s->pdata->driver_flags & MAX310X_EXT_CLK))
+		for (;;) {
+			/* Wait for PLL only if crystal is used */
+			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &sts);
+			if (sts & MAX310X_STS_CLKREADY_BIT)
+				break;
+		}
+
+	dev_dbg(s->port.dev, "Reference clock set to %lu Hz\n", bestfreq);
+
+	return (int)bestfreq;
+}
+
+static void max310x_handle_rx(struct max310x_port *s, unsigned int rxlen)
+{
+	unsigned int status = 0, ch = 0, flag;
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
+		regmap_read(s->regmap, MAX310X_LSR_IRQSTS_REG, &status);
+
+		status &= MAX310X_ERR_PARITY | MAX310X_ERR_FRAME |
+			  MAX310X_ERR_OVERRUN | MAX310X_ERR_BREAK;
+
+		s->port.icount.rx++;
+		flag = TTY_NORMAL;
+
+		if (unlikely(status)) {
+			if (status & MAX310X_ERR_BREAK) {
+				s->port.icount.brk++;
+				if (uart_handle_break(&s->port))
+					continue;
+			} else if (status & MAX310X_ERR_PARITY)
+				s->port.icount.parity++;
+			else if (status & MAX310X_ERR_FRAME)
+				s->port.icount.frame++;
+			else if (status & MAX310X_ERR_OVERRUN)
+				s->port.icount.overrun++;
+
+			status &= s->port.read_status_mask;
+			if (status & MAX310X_ERR_BREAK)
+				flag = TTY_BREAK;
+			else if (status & MAX310X_ERR_PARITY)
+				flag = TTY_PARITY;
+			else if (status & MAX310X_ERR_FRAME)
+				flag = TTY_FRAME;
+			else if (status & MAX310X_ERR_OVERRUN)
+				flag = TTY_OVERRUN;
+		}
+
+		if (uart_handle_sysrq_char(s->port, ch))
+			continue;
+
+		if (status & s->port.ignore_status_mask)
+			continue;
+
+		uart_insert_char(&s->port, status, MAX310X_ERR_OVERRUN, ch, flag);
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
+		do {
+			regmap_write(s->regmap, MAX310X_THR_REG, xmit->buf[xmit->tail]);
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		} while (--to_send > 0);
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&s->port);
+}
+
+static irqreturn_t max310x_ist(int irq, void *dev_id)
+{
+	struct max310x_port *s = (struct max310x_port*)dev_id;
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
+static void max310x_enable_ms(struct uart_port *port)
+{
+	/* Modem status not supported */
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
+	return val ? 0: TIOCSER_TEMT;
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
+	* so do nothing
+	*/
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
+	s->port.read_status_mask = MAX310X_ERR_OVERRUN;
+	if (termios->c_iflag & INPCK)
+		s->port.read_status_mask |= MAX310X_ERR_PARITY |
+					    MAX310X_ERR_FRAME;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		s->port.read_status_mask |= MAX310X_ERR_BREAK;
+
+	/* Set status ignore mask */
+	s->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNBRK)
+		s->port.ignore_status_mask |= MAX310X_ERR_BREAK;
+	if (!(termios->c_cflag & CREAD))
+		s->port.ignore_status_mask |= MAX310X_ERR_PARITY |
+					      MAX310X_ERR_OVERRUN |
+					      MAX310X_ERR_FRAME |
+					      MAX310X_ERR_BREAK;
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
+static void max310x_register_init(struct max310x_port *s)
+{
+	unsigned int val;
+
+	/* Configure baud rate, 9600 as default */
+	max310x_set_baud(s, 9600);
+
+	/* Configure LCR register, 8N1 mode by default */
+	val = MAX310X_LCR_WORD_LEN_8;
+	regmap_write(s->regmap, MAX310X_LCR_REG, val);
+
+	/* Configure MODE1 register */
+	val = MAX310X_MODE1_IRQSEL_BIT; /* Enable IRQ pin */
+	if (s->pdata->uart_flags[s->port.line] & MAX310X_AUTO_DIR_CTRL)
+		val |= MAX310X_MODE1_TRNSCVCTRL_BIT;
+	regmap_write(s->regmap, MAX310X_MODE1_REG, val);
+
+	/* Configure MODE2 register */
+	val = MAX310X_MODE2_RXEMPTINV_BIT;
+	if (s->pdata->uart_flags[s->port.line] & MAX310X_LOOPBACK)
+		val |= MAX310X_MODE2_LOOPBACK_BIT;
+	if (s->pdata->uart_flags[s->port.line] & MAX310X_ECHO_SUPRESS)
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
+}
+
+static int max310x_startup(struct uart_port *port)
+{
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(s, 0);
+
+	/* Init registers */
+	max310x_register_init(s);
+
+	/* Setup interrupt */
+	if (devm_request_threaded_irq(port->dev, port->irq, NULL, max310x_ist,
+				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				      dev_name(port->dev), s)) {
+		dev_err(port->dev, "Unable to reguest IRQ %i\n", port->irq);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void max310x_shutdown(struct uart_port *port)
+{
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	if (s->suspended && s->pdata->suspend)
+		s->pdata->suspend(s, 0);
+
+	/* Disable all interrupts */
+	mutex_lock(&s->max310x_mutex);
+	regmap_write(s->regmap, MAX310X_IRQEN_REG, 0);
+	mutex_unlock(&s->max310x_mutex);
+
+	/* Free the interrupt */
+	devm_free_irq(port->dev, port->irq, s);
+
+	if (s->pdata->suspend)
+		s->pdata->suspend(s, 1);
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
+	struct max310x_port *s = container_of(port, struct max310x_port, port);
+
+	s->port.type = PORT_MAX310X;
+}
+
+static int max310x_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	if ((ser->type == PORT_UNKNOWN) || (ser->type == PORT_MAX310X))
+		return 0;
+
+	return -EINVAL;
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
+static void max310x_set_sleep(struct max310x_port *s, int mode)
+{
+	unsigned int val = 0;
+
+	mutex_lock(&s->max310x_mutex);
+
+	regmap_read(s->regmap, MAX310X_MODE1_REG, &val);
+
+	switch (mode) {
+	case MAX310X_DISABLE_FORCED_SLEEP:
+		val &= ~MAX310X_MODE1_FORCESLEEP_BIT;
+		break;
+	case MAX310X_ENABLE_FORCED_SLEEP:
+		val |= MAX310X_MODE1_FORCESLEEP_BIT;
+		break;
+	case MAX310X_DISABLE_AUTOSLEEP:
+		val &= ~MAX310X_MODE1_AUTOSLEEP_BIT;
+		break;
+	case MAX310X_ENABLE_AUTOSLEEP:
+		val |= MAX310X_MODE1_AUTOSLEEP_BIT;
+		break;
+	default:
+		dev_warn(s->port.dev, "Invalid sleep mode %i\n", mode);
+		mutex_unlock(&s->max310x_mutex);
+		return;
+	}
+
+	regmap_write(s->regmap, MAX310X_MODE1_REG, val);
+
+	if ((mode == MAX310X_DISABLE_AUTOSLEEP) ||
+	    (mode == MAX310X_DISABLE_FORCED_SLEEP))
+		msleep(MAX310X_WAKEUP_DELAY);
+
+	mutex_unlock(&s->max310x_mutex);
+}
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
+	if (s->pdata->suspend)
+		s->pdata->suspend(s, 1);
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
+		s->pdata->suspend(s, 0);
+
+	return uart_resume_port(&s->uart, &s->port);
+}
+
+void max310x_default_suspend(struct max310x_port *s, int do_suspend)
+{
+	dev_dbg(s->port.dev, "Change suspend state to %i\n", do_suspend);
+
+	s->suspended = do_suspend;
+	max310x_set_sleep(s, do_suspend ? MAX310X_ENABLE_AUTOSLEEP :
+					  MAX310X_DISABLE_AUTOSLEEP);
+}
+EXPORT_SYMBOL_GPL(max310x_default_suspend);
+
+/* Generic platform data */
+static struct max310x_pdata generic_plat_data = {
+	.driver_flags	= MAX310X_EXT_CLK,
+	.uart_flags[0]	= MAX310X_ECHO_SUPRESS,
+	.frequency	= 26000000,
+	.suspend	= &max310x_default_suspend,
+};
+
+static int __devinit max310x_probe(struct spi_device *spi, int chiptype)
+{
+	struct max310x_port *s;
+	struct max310x_pdata *pdata = spi->dev.platform_data;
+	unsigned int val = 0;
+	int ret;
+
+	/* Check for IRQ */
+	if (spi->irq <= 0) {
+		dev_err(&spi->dev, "No IRQ specified\n");
+		return -ENOTSUPP;
+	}
+
+	/* Alloc port structure */
+	s = devm_kzalloc(&spi->dev, sizeof(struct max310x_port), GFP_KERNEL);
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
+	/* Individual settings for chips */
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
+	}
+
+	/* Check frequency for oscillator */
+	if ((pdata->driver_flags & MAX310X_EXT_CLK) &&
+	   ((pdata->frequency < 500000) || (pdata->frequency > 35000000)))
+		goto err_freq;
+	/* Check frequency for quartz */
+	if (!(pdata->driver_flags & MAX310X_EXT_CLK) &&
+	   ((pdata->frequency < 1000000) || (pdata->frequency > 4000000)))
+		goto err_freq;
+
+	/* Board specific configure */
+	if (pdata->configure)
+		pdata->configure();
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
+	s->regcfg.reg_bits		= 8,
+	s->regcfg.val_bits		= 8,
+	s->regcfg.read_flag_mask	= 0x00,
+	s->regcfg.write_flag_mask	= 0x80,
+	s->regcfg.cache_type		= REGCACHE_RBTREE,
+	s->regcfg.writeable_reg		= max3107_8_reg_writeable,
+	s->regcfg.volatile_reg		= max310x_reg_volatile,
+	s->regcfg.precious_reg		= max310x_reg_precious,
+	s->regmap = devm_regmap_init_spi(spi, &s->regcfg);
+	if (IS_ERR(s->regmap)) {
+		ret = PTR_ERR(s->regmap);
+		dev_err(&spi->dev, "Failed to initialize register map: %d\n", ret);
+		goto err_out;
+	}
+
+	/* Reset chip */
+	ret = regmap_write(s->regmap, MAX310X_MODE2_REG, MAX310X_MODE2_RST_BIT);
+	if (ret) {
+		dev_err(&spi->dev, "SPI transfer failed: %d\n", ret);
+		goto err_out;
+	}
+	/* Clear chip reset */
+	regmap_write(s->regmap, MAX310X_MODE2_REG, 0);
+
+	if (chiptype == MAX310X_TYPE_MAX3107) {
+		/* Check REV ID to ensure we are talking to what we expect */
+		regmap_read(s->regmap, MAX3107_REVID_REG, &val);
+		if (((val & MAX3107_REV_MASK) != MAX3107_REV_ID)) {
+			dev_err(&spi->dev, "%s ID 0x%02x does not match\n",
+				s->name, val);
+			ret = -ENODEV;
+			goto err_out;
+		}
+	} else if (chiptype == MAX310X_TYPE_MAX3108) {
+		/* MAX3108 have not REV ID register, we just read the reset
+		 * register to make sure everything works.
+		 */
+		regmap_read(s->regmap, MAX310X_MODE2_REG, &val);
+		if (val) {
+			dev_err(&spi->dev, "%s not present\n", s->name);
+			ret = -ENODEV;
+			goto err_out;
+		}
+	}
+
+	/* Disable all interrupts */
+	regmap_write(s->regmap, MAX310X_IRQEN_REG, 0);
+
+	/* Register UART driver */
+	s->uart.owner		= THIS_MODULE,
+	s->uart.driver_name	= "ttyMAX",
+	s->uart.dev_name	= "ttyMAX",
+	s->uart.major		= MAX310X_MAJOR,
+	s->uart.minor		= MAX310X_MINOR,
+	s->uart.cons		= NULL,
+	ret = uart_register_driver(&s->uart);
+	if (ret) {
+		dev_err(&spi->dev, "Registering UART driver failed: %d\n", ret);
+		goto err_out;
+	}
+
+	/* Initialize UART port data */
+	s->port.line		= 0;
+	s->port.dev		= &spi->dev;
+	s->port.irq		= spi->irq;
+	s->port.type		= PORT_MAX310X;
+	s->port.fifosize	= MAX310X_FIFO_SIZE;
+	s->port.flags		= UPF_SKIP_TEST | UPF_FIXED_TYPE;
+	s->port.iotype		= UPIO_PORT;
+	s->port.membase		= (void __iomem*)0xffffffff; /* Bogus value */
+	s->port.uartclk		= max310x_set_ref_clk(s);
+	s->port.ops		= &max310x_ops;
+	uart_add_one_port(&s->uart, &s->port);
+
+	/* Initialize workqueue for start TX */
+	s->wq = create_freezable_workqueue(dev_name(s->port.dev));
+	INIT_WORK(&s->tx_work, max310x_wq_proc);
+
+	/* Go to suspend mode */
+	if (pdata->suspend)
+		pdata->suspend(s, 1);
+
+	return 0;
+
+err_freq:
+	dev_err(&spi->dev, "Frequency parameter incorrect\n");
+	ret = -EINVAL;
+
+err_out:
+	devm_kfree(&spi->dev, s);
+
+	return ret;
+}
+
+static int __devinit max3107_probe(struct spi_device *spi)
+{
+	return max310x_probe(spi, MAX310X_TYPE_MAX3107);
+}
+
+static int __devinit max3108_probe(struct spi_device *spi)
+{
+	return max310x_probe(spi, MAX310X_TYPE_MAX3108);
+}
+
+static int __devexit max310x_remove(struct spi_device *spi)
+{
+	struct max310x_port *s = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(s->port.dev, "Removing port\n");
+
+	destroy_workqueue(s->wq);
+
+	uart_remove_one_port(&s->uart, &s->port);
+	dev_set_drvdata(&spi->dev, NULL);
+
+	uart_unregister_driver(&s->uart);
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
+	.remove		= __devexit_p(max310x_remove),
+	.suspend	= max310x_suspend,
+	.resume		= max310x_resume,
+};
+module_spi_driver(max3107_driver);
+
+static struct spi_driver max3108_driver = {
+	.driver = {
+		.name	= "max3108",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max3108_probe,
+	.remove		= __devexit_p(max310x_remove),
+	.suspend	= max310x_suspend,
+	.resume		= max310x_resume,
+};
+module_spi_driver(max3108_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Aavamobile");
+MODULE_DESCRIPTION("MAX310X UART driver");
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
new file mode 100644
index 0000000..dcd4c75
--- /dev/null
+++ b/include/linux/platform_data/max310x.h
@@ -0,0 +1,47 @@
+/*
+ *  UART protocol driver for Maxim (Dallas) MAX3107/8
+ *
+ *  Based on max3100.c
+ *    by Christian Pellegrin <chripell@evolware.org>
+ *  and max3110.c
+ *    by Feng Tang <feng.tang@intel.com>
+ *  Rewritten by Alexander Shiyan <shc_work@mail.ru>
+ *
+ *  Copyright (C) Aavamobile 2009
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+#ifndef _MAX310X_H_
+#define _MAX310X_H_
+
+struct max310x_port;
+
+#define MAX310X_MAX_UART_PER_DRIVER	1
+
+/* MAX310X platform data structure */
+struct max310x_pdata {
+	/* Flags global to driver */
+	const unsigned int	driver_flags;
+#define MAX310X_EXT_CLK		(0x00000001)	/* External clock enable */
+	/* Flags global to UART port */
+	const unsigned int	uart_flags[MAX310X_MAX_UART_PER_DRIVER];
+#define MAX310X_LOOPBACK	(0x00000001)	/* Loopback mode enable */
+#define MAX310X_ECHO_SUPRESS	(0x00000002)	/* Enable echo supress */
+#define MAX310X_AUTO_DIR_CTRL	(0x00000004)	/* Enable Auto direction control (RS-485) */
+	/* Frequency (extrenal clock or crystal) */
+	const int		frequency;
+	/* GPIO base number */
+	const unsigned int	gpio_base;	/* Not implemented yet */
+	/* Called before initialization */
+	void (*configure)(void);
+	/* HW suspend function */
+	void (*suspend)(struct max310x_port *s, int do_suspend);
+};
+
+/* Function that can be reused in board support code */
+void max310x_default_suspend(struct max310x_port *s, int do_suspend);
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

