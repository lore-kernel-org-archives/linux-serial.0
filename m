From: dirk.eibach@gdsys.cc
Subject: [PATCH 2/2] sc16is7xx: Disable regmap cache
Date: Mon,  8 Aug 2016 15:32:16 +0200
Message-ID: <1470663136-26269-2-git-send-email-dirk.eibach@gdsys.cc>
References: <1470663136-26269-1-git-send-email-dirk.eibach@gdsys.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470663136-26269-1-git-send-email-dirk.eibach@gdsys.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org, jringle@gridpoint.com
Cc: Dirk Eibach <dirk.eibach@gdsys.cc>
List-Id: linux-serial@vger.kernel.org

From: Dirk Eibach <dirk.eibach@gdsys.cc>

The regcache_cache_bypass() calls are not implemented to be threadsafe.
Since I don't see the point in using a regmap cache on an UART
interface it is better to disable it alltogether and avoid these
problems.

Signed-off-by: Dirk Eibach <dirk.eibach@gdsys.cc>
---
 drivers/tty/serial/sc16is7xx.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 098c6dc..24ac6a2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -378,9 +378,7 @@ static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
 	const u8 line = sc16is7xx_line(port);
 	u8 addr = (SC16IS7XX_RHR_REG << SC16IS7XX_REG_SHIFT) | line;
 
-	regcache_cache_bypass(s->regmap, true);
 	regmap_raw_read(s->regmap, addr, s->buf, rxlen);
-	regcache_cache_bypass(s->regmap, false);
 }
 
 static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
@@ -396,9 +394,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regcache_cache_bypass(s->regmap, true);
 	regmap_raw_write(s->regmap, addr, s->buf, to_send);
-	regcache_cache_bypass(s->regmap, false);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
@@ -461,24 +457,6 @@ static const struct sc16is7xx_devtype sc16is762_devtype = {
 	.nr_uart	= 2,
 };
 
-static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
-{
-	switch (reg >> SC16IS7XX_REG_SHIFT) {
-	case SC16IS7XX_RHR_REG:
-	case SC16IS7XX_IIR_REG:
-	case SC16IS7XX_LSR_REG:
-	case SC16IS7XX_MSR_REG:
-	case SC16IS7XX_TXLVL_REG:
-	case SC16IS7XX_RXLVL_REG:
-	case SC16IS7XX_IOSTATE_REG:
-		return true;
-	default:
-		break;
-	}
-
-	return false;
-}
-
 static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 {
 	switch (reg >> SC16IS7XX_REG_SHIFT) {
@@ -493,7 +471,6 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	u8 lcr;
 	u8 prescaler = 0;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
@@ -510,10 +487,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			     SC16IS7XX_LCR_CONF_MODE_B);
 
 	/* Enable enhanced features */
-	regcache_cache_bypass(s->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
 			     SC16IS7XX_EFR_ENABLE_BIT);
-	regcache_cache_bypass(s->regmap, false);
 
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
@@ -527,10 +502,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			     SC16IS7XX_LCR_CONF_MODE_A);
 
 	/* Write the new divisor */
-	regcache_cache_bypass(s->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
 	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
-	regcache_cache_bypass(s->regmap, false);
 
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
@@ -664,7 +637,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	struct uart_port *port = &s->p[portno].port;
-	unsigned int iir, ier, msr, rxlen;
+	unsigned int iir, ier, rxlen;
 
 	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 	if (iir & SC16IS7XX_IIR_NO_INT_BIT)
@@ -838,7 +811,6 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 				  struct ktermios *termios,
 				  struct ktermios *old)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int lcr, flow = 0;
 	int baud;
 
@@ -896,7 +868,6 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 			     SC16IS7XX_LCR_CONF_MODE_B);
 
 	/* Configure flow control */
-	regcache_cache_bypass(s->regmap, true);
 	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
 	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
 	if (termios->c_cflag & CRTSCTS)
@@ -908,7 +879,6 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 		flow |= SC16IS7XX_EFR_SWFLOW1_BIT;
 
 	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG, flow);
-	regcache_cache_bypass(s->regmap, false);
 
 	/* Update LCR register */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
@@ -960,7 +930,6 @@ static int sc16is7xx_config_rs485(struct uart_port *port,
 
 static int sc16is7xx_startup(struct uart_port *port)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 
 	sc16is7xx_power(port, 1);
@@ -976,7 +945,6 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_B);
 
-	regcache_cache_bypass(s->regmap, true);
 
 	/* Enable write access to enhanced features and internal clock div */
 	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
@@ -993,8 +961,6 @@ static int sc16is7xx_startup(struct uart_port *port)
 			     SC16IS7XX_TCR_RX_RESUME(24) |
 			     SC16IS7XX_TCR_RX_HALT(48));
 
-	regcache_cache_bypass(s->regmap, false);
-
 	/* Now, initialize the UART */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_WORD_LEN_8);
 
@@ -1301,8 +1267,7 @@ static struct regmap_config regcfg = {
 	.reg_bits = 7,
 	.pad_bits = 1,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = sc16is7xx_regmap_volatile,
+	.cache_type = REGCACHE_NONE,
 	.precious_reg = sc16is7xx_regmap_precious,
 };
 
-- 
2.1.3
