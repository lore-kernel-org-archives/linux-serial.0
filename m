From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH v4 1/4] serial: mxs-auart: clean get_mctrl and set_mctrl
Date: Fri, 10 Oct 2014 18:53:24 +0200
Message-ID: <1412960007-28159-2-git-send-email-j.uzycki@elproma.com.pl>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:59202 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751356AbaJJQvI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2014 12:51:08 -0400
In-Reply-To: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

Russell King:
The only thing which the .get_mctrl method is supposed to do is
to return the state of the /input/ lines, which are CTS, DCD, DSR, RI.
The output line state is stored in port->mctrl, and is added to
the returned value by serial_core when it's required.
RTS output state should not be returned from the .get_mctrl method.

This patch removes ctrl variable from mxs_auart_port
and removes useless reading back RTS line.

The ctrl variable in mxs_auart_port duplicated mctrl,
member of uart_port structure in serial_core.h.
The removed code from mxs_auart_set_mctrl() and mxs_auart_get_mctrl
duplicated uart_update_mctrl() and uart_tiocmget()
in serial_core.c.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
v3 -> v4 changelog:
[PATCH 1/4] serial: mxs-auart: clean get_mctrl and set_mctrl
* renamed from "serial: mxs-auart: ctrl removed from mxs_auart_port"
* mxs_auart_get_mctrl() read back RTS line. It is removed too.

v2 -> v3 changelog:
The patch was introduced:
new [PATCH 1/4] serial: mxs-auart: ctrl removed from mxs_auart_port
* the ctrl variable duplicated mctrl, member of uart_port structure
  in serial_core.h
* the code duplicated uart_update_mctrl() and uart_tiocmget()
  in serial_core.c
* mxs_auart_get_mctrl() reads back RTS line. It could be removed too
  but not sure.

---
 drivers/tty/serial/mxs-auart.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index e838e84..2d49901 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -143,7 +143,6 @@ struct mxs_auart_port {
 #define MXS_AUART_DMA_RX_READY	3  /* bit 3 */
 #define MXS_AUART_RTSCTS	4  /* bit 4 */
 	unsigned long flags;
-	unsigned int ctrl;
 	enum mxs_auart_type devtype;
 
 	unsigned int irq;
@@ -406,8 +405,6 @@ static void mxs_auart_release_port(struct uart_port *u)
 
 static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 {
-	struct mxs_auart_port *s = to_auart_port(u);
-
 	u32 ctrl = readl(u->membase + AUART_CTRL2);
 
 	ctrl &= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
@@ -418,24 +415,17 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 			ctrl |= AUART_CTRL2_RTS;
 	}
 
-	s->ctrl = mctrl;
 	writel(ctrl, u->membase + AUART_CTRL2);
 }
 
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
 {
-	struct mxs_auart_port *s = to_auart_port(u);
 	u32 stat = readl(u->membase + AUART_STAT);
-	int ctrl2 = readl(u->membase + AUART_CTRL2);
-	u32 mctrl = s->ctrl;
+	u32 mctrl = 0;
 
-	mctrl &= ~TIOCM_CTS;
 	if (stat & AUART_STAT_CTS)
 		mctrl |= TIOCM_CTS;
 
-	if (ctrl2 & AUART_CTRL2_RTS)
-		mctrl |= TIOCM_RTS;
-
 	return mctrl;
 }
 
@@ -1071,8 +1061,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.type = PORT_IMX;
 	s->port.dev = s->dev = &pdev->dev;
 
-	s->ctrl = 0;
-
 	s->irq = platform_get_irq(pdev, 0);
 	s->port.irq = s->irq;
 	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
-- 
1.7.11.3

