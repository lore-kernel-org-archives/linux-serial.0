From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 3/8] serial: imx: allow waking up on RTSD
Date: Mon, 10 Aug 2015 18:35:44 -0700
Message-ID: <1439256949-626-4-git-send-email-edubezval@gmail.com>
References: <1439256949-626-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1439256949-626-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

This patch sets RTSDEN bit when going into idle (Stop mode).
We add the RTSDEN for the case RTS is sent from
the remote connection. This way we allow the system
to wakeup when RTS is received.

Cc: Fabio Stevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3c2b0ac..167dea1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1982,6 +1982,13 @@ static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
 	else
 		val &= ~UCR3_AWAKEN;
 	writel(val, sport->port.membase + UCR3);
+
+	val = readl(sport->port.membase + UCR1);
+	if (on)
+		val |= UCR1_RTSDEN;
+	else
+		val &= ~UCR1_RTSDEN;
+	writel(val, sport->port.membase + UCR1);
 }
 
 static int imx_serial_port_suspend_noirq(struct device *dev)
-- 
2.5.0

