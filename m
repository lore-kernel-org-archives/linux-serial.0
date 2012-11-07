From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH 06/10] serial: sh-sci: support lower baud rate
Date: Wed, 07 Nov 2012 15:59:45 +0900
Message-ID: <509A06E1.6090908@renesas.com>
References: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <509A0658.1010503@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, takashi.yoshii.zj@renesas.com, alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: rjw@sisk.pl, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Support prescaler 1/16 and 1/64, in addition to current 1 and 1/4.

Supporting below 2400bps was dropped long time ago in mainline.
Since then, setting lower rate has been resulting in erroneous
register value, without indicating any errors through API.

This patch adds more prescaler to support lower rates again.
This still doesn't check range, but we won't hit the case because
even 50bps at 48MHz clock is now supported.

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ffeca65..3021912 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1814,7 +1814,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct sci_port *s = to_sci_port(port);
 	struct plat_sci_reg *reg;
-	unsigned int baud, smr_val, max_baud;
+	unsigned int baud, smr_val, max_baud, cks;
 	int t = -1;
 
 	/*
@@ -1848,21 +1848,18 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	serial_port_out(port, SCSMR, smr_val);
+	for (cks = 0; t >= 256 && cks <= 3; cks++)
+		t >>= 2;
 
-	dev_dbg(port->dev, "%s: SMR %x, t %x, SCSCR %x\n", __func__, smr_val, t,
-		s->cfg->scscr);
+	dev_dbg(port->dev, "%s: SMR %x, cks %x, t %x, SCSCR %x\n",
+		__func__, smr_val, cks, t, s->cfg->scscr);
 
 	if (t >= 0) {
-		if (t >= 256) {
-			serial_port_out(port, SCSMR, (serial_port_in(port, SCSMR) & ~3) | 1);
-			t >>= 2;
-		} else
-			serial_port_out(port, SCSMR, serial_port_in(port, SCSMR) & ~3);
-
+		serial_port_out(port, SCSMR, (smr_val & ~3) | cks);
 		serial_port_out(port, SCBRR, t);
 		udelay((1000000+(baud-1)) / baud); /* Wait one bit interval */
-	}
+	} else
+		serial_port_out(port, SCSMR, smr_val);
 
 	sci_init_pins(port, termios->c_cflag);
 
-- 
1.7.12.4

