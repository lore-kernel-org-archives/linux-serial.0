From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 08/33] serial: sh-sci: Make sci_irq_desc[] const
Date: Fri, 21 Aug 2015 20:02:32 +0200
Message-ID: <1440180177-6924-9-git-send-email-geert+renesas@glider.be>
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
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9502f52d4b55808a..1758039066515fb7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1110,7 +1110,7 @@ static int sci_notifier(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct sci_irq_desc {
+static const struct sci_irq_desc {
 	const char	*desc;
 	irq_handler_t	handler;
 } sci_irq_desc[] = {
@@ -1152,7 +1152,7 @@ static int sci_request_irq(struct sci_port *port)
 	int i, j, ret = 0;
 
 	for (i = j = 0; i < SCIx_NR_IRQS; i++, j++) {
-		struct sci_irq_desc *desc;
+		const struct sci_irq_desc *desc;
 		int irq;
 
 		if (SCIx_IRQ_IS_MUXED(port)) {
-- 
1.9.1

