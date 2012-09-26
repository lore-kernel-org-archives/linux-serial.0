From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH v3] serial: pl011: handle corruption at high clock speeds
Date: Wed, 26 Sep 2012 17:21:36 +0200
Message-ID: <1348672896-6005-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:40279 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750902Ab2IZPV6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Sep 2012 11:21:58 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Anmar Oueja <anmar.oueja@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, stable@kernel.org, Bibek Basu <bibek.basu@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, Matthias Locher <matthias.locher@stericsson.com>, Rajanikanth HV <rajanikanth.hv@stericsson.com>

From: Linus Walleij <linus.walleij@linaro.org>

This works around a few glitches in the ST version of the PL011
serial driver when using very high baud rates, as we do in the
Ux500: 3, 3.25, 4 and 4.05 Mbps.

Problem Observed/rootcause:

When using high baud-rates, and the baudrate*8 is getting close to
the provided clock frequency (so a division factor close to 1), when
using bursts of characters (so they are abutted), then it seems as if
there is not enough time to detect the beginning of the start-bit which
is a timing reference for the entire character, and thus the sampling
moment of character bits is moving towards the end of each bit, instead
of the middle.

Fix:
Increase slightly the RX baud rate of the UART above the theoretical
baudrate by 5%. This will definitely give more margin time to the
UART_RX to correctly sample the data at the middle of the bit period.

Also fix the ages old copy-paste error in the very stressed comment,
it's referencing the registers used in the PL010 driver rather than
the PL011 ones.

Cc: stable@kernel.org
Cc: Bibek Basu <bibek.basu@stericsson.com>
Cc: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Signed-off-by: Guillaume Jaunet <guillaume.jaunet@stericsson.com>
Signed-off-by: Christophe Arnal <christophe.arnal@stericsson.com>
Signed-off-by: Matthias Locher <matthias.locher@stericsson.com>
Signed-off-by: Rajanikanth HV <rajanikanth.hv@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Actually commit the v2 changes...
ChangeLog v1->v2:
- Use >= comparison for 3 Mbaud, add some parenthesis to make the
  logical expressions crystal clear.
---
 drivers/tty/serial/amba-pl011.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d626d84..25508c7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1594,13 +1594,26 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 			old_cr &= ~ST_UART011_CR_OVSFACT;
 	}
 
+	/*
+	 * Workaround for the ST Micro oversampling variants to
+	 * increase the bitrate slightly, by lowering the divisor,
+	 * to avoid delayed sampling of start bit at high speeds,
+	 * else we see data corruption.
+	 */
+	if (uap->vendor->oversampling) {
+		if ((baud >= 3000000) && (baud < 3250000) && (quot > 1))
+			quot -= 1;
+		else if ((baud > 3250000) && (quot > 2))
+			quot -= 2;
+	}
 	/* Set baud rate */
 	writew(quot & 0x3f, port->membase + UART011_FBRD);
 	writew(quot >> 6, port->membase + UART011_IBRD);
 
 	/*
 	 * ----------v----------v----------v----------v-----
-	 * NOTE: MUST BE WRITTEN AFTER UARTLCR_M & UARTLCR_L
+	 * NOTE: lcrh_tx and lcrh_rx MUST BE WRITTEN AFTER
+	 * UART011_FBRD & UART011_IBRD.
 	 * ----------^----------^----------^----------^-----
 	 */
 	writew(lcr_h, port->membase + uap->lcrh_rx);
-- 
1.7.11.3

