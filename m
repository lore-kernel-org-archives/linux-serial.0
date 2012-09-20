From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/3] serial: pl011: safeguard against impossible baudrates
Date: Thu, 20 Sep 2012 11:45:46 +0200
Message-ID: <1348134346-25593-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The PL011 generates it's bitrate from the clock to the block,
and this in turn will be divided by a minimum of 16 (ARM PL011)
or 8 (ST Micro PL011 derivate). Safeguard against illegal
rates exceeding that of what the port clock can be divided
down to.

Since the clkdiv variable is only ever used for calculating the
maximum baud rate, let's skip that variable and add a new
max_baud variable instead, then use this to check limits and
as parameter for getting the baud rate.

Cc: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Cc: Guillaume Jaunet <guillaume.jaunet@stericsson.com>
Cc: Christophe Arnal <christophe.arnal@stericsson.com>
Cc: Matthias Locher <matthias.locher@stericsson.com>
Cc: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d626d84..9e16ea6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1492,18 +1492,25 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int lcr_h, old_cr;
 	unsigned long flags;
-	unsigned int baud, quot, clkdiv;
+	unsigned int max_baud, baud, quot;
 
 	if (uap->vendor->oversampling)
-		clkdiv = 8;
+		max_baud = port->uartclk / 8;
 	else
-		clkdiv = 16;
+		max_baud = port->uartclk / 16;
+
+	if ((termios->c_ispeed > max_baud) ||
+	    (termios->c_ospeed > max_baud)) {
+		dev_err(port->dev,
+			"requested a baud rate > clock/mindivisor\n");
+		return;
+	}
 
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
 	baud = uart_get_baud_rate(port, termios, old, 0,
-				  port->uartclk / clkdiv);
+				  max_baud);
 
 	if (baud > port->uartclk/16)
 		quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
-- 
1.7.11.3
