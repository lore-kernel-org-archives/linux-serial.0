From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/3] serial: pl011: handle corruption at high clock speeds
Date: Thu, 20 Sep 2012 11:46:00 +0200
Message-ID: <1348134360-25628-1-git-send-email-linus.walleij@stericsson.com>
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
Cc: Linus Walleij <linus.walleij@linaro.org>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Bibek Basu <bibek.basu@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This works around a few glitches in the ST version of the PL011
serial driver when using very high baud rates, as we do in the
Ux500: 3, 3.25, 4 and 4.05 Mbps are used in our platform.

Problem Observed/rootcause:

In case of high baud-rates, where the baud-rate*8 is getting close to
the provided clock frequency (so a division factor close to 1) when
using bursts of characters (so they are abutted), then it seems as if
there is not enough time to detect the beginning of the start-bit which
is a timing reference for the entire character, and thus the sampling
moment of character bits is moving towards the end of each bit, instead
of the middle.

Fix:
Increase slightly the RX baud rate of the UART above the theoretical
baudrate by 5%. This will definitely give more margin time to the
UART_RX to sample correctly the data at the middle of the bit period.

Cc: Bibek Basu <bibek.basu@stericsson.com>
Cc: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Signed-off-by: Guillaume Jaunet <guillaume.jaunet@stericsson.com>
Signed-off-by: Christophe Arnal <christophe.arnal@stericsson.com>
Signed-off-by: Matthias Locher <matthias.locher@stericsson.com>
Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 9e16ea6..32240a7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1601,13 +1601,26 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 			old_cr &= ~ST_UART011_CR_OVSFACT;
 	}
 
+	/*
+	 * Workaround for the ST Micro oversampling variants to
+	 * increase the bitrate slightly, by lowering the divisor,
+	 * to avoid delayed sampling of start bit at high speeds,
+	 * else we see data corruption.
+	 */
+	if (uap->vendor->oversampling) {
+		if (baud > 3000000 && baud < 3250000 && quot > 1)
+			quot -= 1;
+		else if (baud > 3250000 && quot > 2)
+			quot -= 2;
+	}
 	/* Set baud rate */
 	writew(quot & 0x3f, port->membase + UART011_FBRD);
 	writew(quot >> 6, port->membase + UART011_IBRD);
 
 	/*
 	 * ----------v----------v----------v----------v-----
-	 * NOTE: MUST BE WRITTEN AFTER UARTLCR_M & UARTLCR_L
+	 * NOTE: lcrh_tx and lcrh_rx MUST BE WRITTEN AFTER
+	 * UARTLCR_M(IBRD)  & UARTLCR_L(FBRD).
 	 * ----------^----------^----------^----------^-----
 	 */
 	writew(lcr_h, port->membase + uap->lcrh_rx);
-- 
1.7.11.3
