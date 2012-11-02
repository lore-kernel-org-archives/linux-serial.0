From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/3] serial: i.MX: evaluate linux,stdout-path property
Date: Fri,  2 Nov 2012 10:48:54 +0100
Message-ID: <1351849734-9836-4-git-send-email-s.hauer@pengutronix.de>
References: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

devicetrees may have the linux,stdout-path property to specify the
console. This patch adds support to the i.MX serial driver for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3a9337e..41be237 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -47,6 +47,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_stdout.h>
 #include <linux/pinctrl/consumer.h>
 
 #include <asm/io.h>
@@ -1421,6 +1422,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 
 	sport->devdata = of_id->data;
 
+	if (of_device_is_stdout_path(np))
+		add_preferred_console(imx_reg.cons->name, sport->port.line, 0);
+
 	return 0;
 }
 #else
-- 
1.7.10.4
