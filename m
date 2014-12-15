From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] serial: sh-sci: Add hardware flow control support of R-Car HSCIF
Date: Mon, 15 Dec 2014 23:14:06 +0900
Message-ID: <1418652846-6821-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

TIOCM_CTS is enabled to use hardware flow control of HSCIF.
And hardware flow control of HSCIF is handled by device tree.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

 drivers/tty/serial/sh-sci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bcec10a..6744702 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1216,7 +1216,11 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 	 * CTS/RTS is handled in hardware when supported, while nothing
 	 * else is wired up. Keep it simple and simply assert DSR/CAR.
 	 */
-	return TIOCM_DSR | TIOCM_CAR;
+	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
+
+	if (port->type == PORT_HSCIF)
+		mctrl |= TIOCM_CTS;
+	return mctrl;
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
@@ -2611,6 +2615,8 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	p->type = info->type;
 	p->regtype = info->regtype;
 	p->scscr = SCSCR_RE | SCSCR_TE;
+	if (of_property_read_bool(np, "ctsrts"))
+		p->capabilities = SCIx_HAVE_RTSCTS;
 
 	return p;
 }
-- 
1.9.1

