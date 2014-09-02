From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v11 14/19] serial: amba-pl011: Move pl011_hwinit()
Date: Tue,  2 Sep 2014 14:00:48 +0100
Message-ID: <1409662853-29313-15-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linaro-kernel@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, linux-serial@vger.kernel.org, patches@linaro.org, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, John Stultz <john.stultz@linaro.org>, Fabio Estevam <festevam@gmail.com>, Colin Cross <ccross@android.com>, Jiri Slaby <jslaby@suse.cz>, kernel-team@android.com, Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This patch hoists pl011_hwinit() further up within the driver. This
permits a later patch to introduce an extended .poll_init callback
that does more than pure hardware initialization.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c | 78 ++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 02016fc..0b06dcf 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1425,6 +1425,45 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
+static int pl011_hwinit(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+	int retval;
+
+	/* Optionaly enable pins to be muxed in and configured */
+	pinctrl_pm_select_default_state(port->dev);
+
+	/*
+	 * Try to enable the clock producer.
+	 */
+	retval = clk_prepare_enable(uap->clk);
+	if (retval)
+		return retval;
+
+	uap->port.uartclk = clk_get_rate(uap->clk);
+
+	/* Clear pending error and receive interrupts */
+	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
+	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
+
+	/*
+	 * Save interrupts enable mask, and enable RX interrupts in case if
+	 * the interrupt is used for NMI entry.
+	 */
+	uap->im = readw(uap->port.membase + UART011_IMSC);
+	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
+
+	if (dev_get_platdata(uap->port.dev)) {
+		struct amba_pl011_data *plat;
+
+		plat = dev_get_platdata(uap->port.dev);
+		if (plat->init)
+			plat->init();
+	}
+	return 0;
+}
+
 #ifdef CONFIG_CONSOLE_POLL
 
 static void pl011_quiesce_irqs(struct uart_port *port)
@@ -1483,45 +1522,6 @@ static void pl011_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-static int pl011_hwinit(struct uart_port *port)
-{
-	struct uart_amba_port *uap =
-	    container_of(port, struct uart_amba_port, port);
-	int retval;
-
-	/* Optionaly enable pins to be muxed in and configured */
-	pinctrl_pm_select_default_state(port->dev);
-
-	/*
-	 * Try to enable the clock producer.
-	 */
-	retval = clk_prepare_enable(uap->clk);
-	if (retval)
-		return retval;
-
-	uap->port.uartclk = clk_get_rate(uap->clk);
-
-	/* Clear pending error and receive interrupts */
-	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
-	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
-
-	/*
-	 * Save interrupts enable mask, and enable RX interrupts in case if
-	 * the interrupt is used for NMI entry.
-	 */
-	uap->im = readw(uap->port.membase + UART011_IMSC);
-	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
-
-	if (dev_get_platdata(uap->port.dev)) {
-		struct amba_pl011_data *plat;
-
-		plat = dev_get_platdata(uap->port.dev);
-		if (plat->init)
-			plat->init();
-	}
-	return 0;
-}
-
 static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 {
 	writew(lcr_h, uap->port.membase + uap->lcrh_rx);
-- 
1.9.3
