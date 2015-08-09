From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 3/8] serial: imx: allow waking up on RTSD
Date: Sun,  9 Aug 2015 11:19:04 -0700
Message-ID: <1439144349-10494-4-git-send-email-edubezval@gmail.com>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
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
index 6c6da8c..70802be 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1812,6 +1812,13 @@ static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
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
 
 static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
-- 
2.5.0

