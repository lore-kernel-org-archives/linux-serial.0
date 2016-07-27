From: Pascal JEAN <epsilonrt@gmail.com>
Subject: [PATCH 1/2] sc16is7xx: fix RTS/CTS implementation
Date: Wed, 27 Jul 2016 22:58:42 +0200
Message-ID: <1469653123-21867-2-git-send-email-epsilonrt@gmail.com>
References: <1469653123-21867-1-git-send-email-epsilonrt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469653123-21867-1-git-send-email-epsilonrt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Pascal JEAN <epsilonrt@gmail.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Pascal JEAN <epsilonrt@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index f36e6df..3e65079 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -511,16 +511,18 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 
 	/* Enable enhanced features */
 	regcache_cache_bypass(s->regmap, true);
-	sc16is7xx_port_write(port, SC16IS7XX_EFR_REG,
-			     SC16IS7XX_EFR_ENABLE_BIT);
+	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+			     SC16IS7XX_EFR_ENABLE_BIT,
+			     SC16IS7XX_EFR_ENABLE_BIT);
+	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
+			      SC16IS7XX_MCR_CLKSEL_BIT,
+			      prescaler);
+	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+			     SC16IS7XX_EFR_ENABLE_BIT, 0);
 	regcache_cache_bypass(s->regmap, false);
 
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
-			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);
 
 	/* Open the LCR divisors for configuration */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
@@ -817,9 +819,9 @@ static unsigned int sc16is7xx_tx_empty(struct uart_port *port)
 static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
 {
 	/* DCD and DSR are not wired and CTS/RTS is handled automatically
-	 * so just indicate DSR and CAR asserted
+	 * so just indicate all inputs asserted
 	 */
-	return TIOCM_DSR | TIOCM_CAR;
+	return TIOCM_DSR | TIOCM_CAR | TIOCM_RI | TIOCM_CTS;
 }
 
 static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int mctrl)
-- 
2.7.4
