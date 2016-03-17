From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 5/5] serial: sh-sci: Replace SCIx_HAVE_RTSCTS by standard UPF_HARD_FLOW
Date: Thu, 17 Mar 2016 14:47:29 +0100
Message-ID: <1458222449-12324-6-git-send-email-geert+renesas@glider.be>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Replace the custom SCIx_HAVE_RTSCTS flag in the
plat_sci_port.capabilities field by the standard UPF_HARD_FLOW flag in
the uart_port.flags and plat_sci_port.flags fields.
Remove the now unused plat_sci_port.capabilities field.
Legacy pllatform data can enable UPF_HARD_FLOW in plat_sci_port.flags.

Note that currently nothing sets the SCIx_HAVE_RTSCTS flag.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 include/linux/serial_sci.h  | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6897100ed5197df3..51b436e2334c3efc 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -720,7 +720,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 	if (!reg->size)
 		return;
 
-	if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
+	if ((port->flags & UPF_HARD_FLOW) &&
 	    ((!(cflag & CRTSCTS)))) {
 		unsigned short status;
 
@@ -2247,7 +2247,7 @@ done:
 	if (reg->size) {
 		unsigned short ctrl = serial_port_in(port, SCFCR);
 
-		if (s->cfg->capabilities & SCIx_HAVE_RTSCTS) {
+		if (port->flags & UPF_HARD_FLOW) {
 			if (termios->c_cflag & CRTSCTS)
 				ctrl |= SCFCR_MCE;
 			else
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 9f2bfd0557429ac3..95640ee68462190f 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -48,17 +48,11 @@ struct plat_sci_port_ops {
 };
 
 /*
- * Port-specific capabilities
- */
-#define SCIx_HAVE_RTSCTS	BIT(0)
-
-/*
  * Platform device specific platform_data struct
  */
 struct plat_sci_port {
 	unsigned int	type;			/* SCI / SCIF / IRDA / HSCIF */
 	upf_t		flags;			/* UPF_* flags */
-	unsigned long	capabilities;		/* Port features/capabilities */
 
 	unsigned int	sampling_rate;
 	unsigned int	scscr;			/* SCSCR initialization */
-- 
1.9.1
