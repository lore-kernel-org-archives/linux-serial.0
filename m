From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 1/4] serial: mxs-auart: ctrl removed from mxs_auart_port
Date: Sat, 27 Sep 2014 11:46:34 +0200
Message-ID: <1411811197-12638-2-git-send-email-j.uzycki@elproma.com.pl>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:63793 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751755AbaI0JoS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 05:44:18 -0400
In-Reply-To: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>

The ctrl variable duplicated mctrl, member of uart_port structure
in serial_core.h.
The code duplicated uart_update_mctrl() and uart_tiocmget()
in serial_core.c.
mxs_auart_get_mctrl() reads back RTS line. It could be removed too
but not sure.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/tty/serial/mxs-auart.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index e838e84..c712108 100644
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
@@ -418,16 +415,14 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 			ctrl |= AUART_CTRL2_RTS;
 	}
 
-	s->ctrl = mctrl;
 	writel(ctrl, u->membase + AUART_CTRL2);
 }
 
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
 {
-	struct mxs_auart_port *s = to_auart_port(u);
 	u32 stat = readl(u->membase + AUART_STAT);
 	int ctrl2 = readl(u->membase + AUART_CTRL2);
-	u32 mctrl = s->ctrl;
+	u32 mctrl = 0;
 
 	mctrl &= ~TIOCM_CTS;
 	if (stat & AUART_STAT_CTS)
@@ -1071,8 +1066,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.type = PORT_IMX;
 	s->port.dev = s->dev = &pdev->dev;
 
-	s->ctrl = 0;
-
 	s->irq = platform_get_irq(pdev, 0);
 	s->port.irq = s->irq;
 	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
-- 
1.7.11.3

