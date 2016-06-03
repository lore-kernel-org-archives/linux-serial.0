From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 05/11] serial: sh-sci: Do not open-code sci_getreg()
Date: Fri,  3 Jun 2016 12:00:05 +0200
Message-ID: <1464948011-377-6-git-send-email-geert+renesas@glider.be>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Replace open-coded variants of sci_getreg() by function calls, and drop
intermediate variables where appropriate.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
v3:
  - Add Reviewed-by,

v2:
  - New.
---
 drivers/tty/serial/sh-sci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bf3780a7f700cad8..ce7bd165929ea078 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -703,7 +703,6 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 {
 	struct sci_port *s = to_sci_port(port);
-	const struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
 
 	/*
 	 * Use port-specific handler if provided.
@@ -717,7 +716,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 	 * For the generic path SCSPTR is necessary. Bail out if that's
 	 * unavailable, too.
 	 */
-	if (!reg->size)
+	if (!sci_getreg(port, SCSPTR)->size)
 		return;
 
 	if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
@@ -1866,12 +1865,10 @@ static void sci_enable_ms(struct uart_port *port)
 
 static void sci_break_ctl(struct uart_port *port, int break_state)
 {
-	struct sci_port *s = to_sci_port(port);
-	const struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
 	unsigned short scscr, scsptr;
 
 	/* check wheter the port has SCSPTR */
-	if (!reg->size) {
+	if (!sci_getreg(port, SCSPTR)->size) {
 		/*
 		 * Not supported by hardware. Most parts couple break and rx
 		 * interrupts together, with break detection always enabled.
-- 
1.9.1

