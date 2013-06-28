From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/mxs-auart: increase time to wait for transmitter to become idle
Date: Fri, 28 Jun 2013 11:49:41 +0200
Message-ID: <1372413017-23252-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51826 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab3F1Juf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Jun 2013 05:50:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org

Without this patch the driver waits ~1 ms for the UART to become idle. =
At
115200n8 this time is (theoretically) enough to transfer 11.5 character=
s
(=3D 115200 bits/s / (10 Bits/char) * 1ms). As the mxs-auart has a fifo=
 size
of 16 characters the clock is gated too early. The problem is worse for
lower baud rates.

This only happens to really shut down the transmitter in the middle of =
a
transfer if /dev/ttyAPPx isn't opened in userspace (e.g. by a getty) bu=
t
was at least once (because the bootloader doesn't disable the transmitt=
er).

So increase the timeout to 20 ms which should be enough for 9600n8, too=
=2E
Moreover skip gating the clock if the timeout is elapsed.

Cc: stable@vger.kernel.org # v2.6.39+
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
index 4f5f161..7645079 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -850,7 +850,7 @@ auart_console_write(struct console *co, const char =
*str, unsigned int count)
 	struct mxs_auart_port *s;
 	struct uart_port *port;
 	unsigned int old_ctrl0, old_ctrl2;
-	unsigned int to =3D 1000;
+	unsigned int to =3D 20000;
=20
 	if (co->index >=3D MXS_AUART_PORTS || co->index < 0)
 		return;
@@ -871,18 +871,23 @@ auart_console_write(struct console *co, const cha=
r *str, unsigned int count)
=20
 	uart_console_write(port, str, count, mxs_auart_console_putchar);
=20
-	/*
-	 * Finally, wait for transmitter to become empty
-	 * and restore the TCR
-	 */
+	/* Finally, wait for transmitter to become empty ... */
 	while (readl(port->membase + AUART_STAT) & AUART_STAT_BUSY) {
+		udelay(1);
 		if (!to--)
 			break;
-		udelay(1);
 	}
=20
-	writel(old_ctrl0, port->membase + AUART_CTRL0);
-	writel(old_ctrl2, port->membase + AUART_CTRL2);
+	/*
+	 * ... and restore the TCR if we waited long enough for the transmitt=
er
+	 * to be idle. This might keep the transmitter enabled although it is
+	 * unused, but that is better than to disable it while it is still
+	 * transmitting.
+	 */
+	if (!(readl(port->membase + AUART_STAT) & AUART_STAT_BUSY)) {
+		writel(old_ctrl0, port->membase + AUART_CTRL0);
+		writel(old_ctrl2, port->membase + AUART_CTRL2);
+	}
=20
 	clk_disable(s->clk);
 }
--=20
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
