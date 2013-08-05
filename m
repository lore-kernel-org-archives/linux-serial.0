From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] serial: i.MX: evaluate linux,stdout-path property
Date: Mon,  5 Aug 2013 14:40:45 +0200
Message-ID: <1375706445-15375-3-git-send-email-s.hauer@pengutronix.de>
References: <1375706445-15375-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375706445-15375-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, devicetree@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

devicetrees may have the linux,stdout-path property to specify the
console. This patch adds support to the i.MX serial driver for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 415cec6..420ad02 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1472,6 +1472,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 
 	sport->devdata = of_id->data;
 
+	if (of_device_is_stdout_path(np))
+		add_preferred_console(imx_reg.cons->name, sport->port.line, 0);
+
 	return 0;
 }
 #else
-- 
1.8.4.rc0
