From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 09/33] serial: sh-sci: Make sci_regmap[] const
Date: Fri, 21 Aug 2015 20:02:33 +0200
Message-ID: <1440180177-6924-10-git-send-email-geert+renesas@glider.be>
References: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1440180177-6924-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1758039066515fb7..383f6df3815a1747 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -147,7 +147,7 @@ struct plat_sci_reg {
 /* Helper for invalidating specific entries of an inherited map. */
 #define sci_reg_invalid	{ .offset = 0, .size = 0 }
 
-static struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
+static const struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
 	[SCIx_PROBE_REGTYPE] = {
 		[0 ... SCIx_NR_REGS - 1] = sci_reg_invalid,
 	},
@@ -400,7 +400,7 @@ static struct plat_sci_reg sci_regmap[SCIx_NR_REGTYPES][SCIx_NR_REGS] = {
  */
 static unsigned int sci_serial_in(struct uart_port *p, int offset)
 {
-	struct plat_sci_reg *reg = sci_getreg(p, offset);
+	const struct plat_sci_reg *reg = sci_getreg(p, offset);
 
 	if (reg->size == 8)
 		return ioread8(p->membase + (reg->offset << p->regshift));
@@ -414,7 +414,7 @@ static unsigned int sci_serial_in(struct uart_port *p, int offset)
 
 static void sci_serial_out(struct uart_port *p, int offset, int value)
 {
-	struct plat_sci_reg *reg = sci_getreg(p, offset);
+	const struct plat_sci_reg *reg = sci_getreg(p, offset);
 
 	if (reg->size == 8)
 		iowrite8(value, p->membase + (reg->offset << p->regshift));
@@ -552,7 +552,7 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 {
 	struct sci_port *s = to_sci_port(port);
-	struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
+	const struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
 
 	/*
 	 * Use port-specific handler if provided.
@@ -582,7 +582,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 
 static int sci_txfill(struct uart_port *port)
 {
-	struct plat_sci_reg *reg;
+	const struct plat_sci_reg *reg;
 
 	reg = sci_getreg(port, SCTFDR);
 	if (reg->size)
@@ -602,7 +602,7 @@ static int sci_txroom(struct uart_port *port)
 
 static int sci_rxfill(struct uart_port *port)
 {
-	struct plat_sci_reg *reg;
+	const struct plat_sci_reg *reg;
 
 	reg = sci_getreg(port, SCRFDR);
 	if (reg->size)
@@ -883,7 +883,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 	struct sci_port *s = to_sci_port(port);
-	struct plat_sci_reg *reg;
+	const struct plat_sci_reg *reg;
 	int copied = 0;
 	u16 status;
 
@@ -1250,7 +1250,7 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	if (mctrl & TIOCM_LOOP) {
-		struct plat_sci_reg *reg;
+		const struct plat_sci_reg *reg;
 
 		/*
 		 * Standard loopback mode for SCFCR ports.
@@ -1621,7 +1621,7 @@ static void sci_stop_rx(struct uart_port *port)
 static void sci_break_ctl(struct uart_port *port, int break_state)
 {
 	struct sci_port *s = to_sci_port(port);
-	struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
+	const struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
 	unsigned short scscr, scsptr;
 
 	/* check wheter the port has SCSPTR */
@@ -1910,7 +1910,7 @@ static void sci_baud_calc_hscif(unsigned int bps, unsigned long freq,
 
 static void sci_reset(struct uart_port *port)
 {
-	struct plat_sci_reg *reg;
+	const struct plat_sci_reg *reg;
 	unsigned int status;
 
 	do {
@@ -1928,7 +1928,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct sci_port *s = to_sci_port(port);
-	struct plat_sci_reg *reg;
+	const struct plat_sci_reg *reg;
 	unsigned int baud, smr_val = 0, max_baud, cks = 0;
 	int t = -1;
 	unsigned int srr = 15;
-- 
1.9.1

