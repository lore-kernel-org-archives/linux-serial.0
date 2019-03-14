From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] tty: mxs-auart: fix a NULL pointer dereference
Date: Thu, 14 Mar 2019 02:21:51 -0500
Message-ID: <20190314072151.19753-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In case ioremap fails, the fix returns -ENOMEM to avoid NULL
pointer dereferences.
Multiple places use port.membase.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/serial/mxs-auart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 27235a526cce..4c188f4079b3 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1686,6 +1686,10 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	s->port.mapbase = r->start;
 	s->port.membase = ioremap(r->start, resource_size(r));
+	if (!s->port.membase) {
+		ret = -ENOMEM;
+		goto out_disable_clks;
+	}
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
-- 
2.17.1
