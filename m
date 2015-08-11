From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 8/8] serial: imx: use SET_*SYSTEM_PM_OPS helper functions
Date: Mon, 10 Aug 2015 18:35:49 -0700
Message-ID: <1439256949-626-9-git-send-email-edubezval@gmail.com>
References: <1439256949-626-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1439256949-626-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

Instead of setting manually each field, use the helper functions
provided by the PM subsystem.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 5053c82..8cd7e63 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2250,10 +2250,10 @@ static int imx_serial_port_resume(struct device *dev)
 static const struct dev_pm_ops imx_serial_port_pm_ops = {
 	SET_RUNTIME_PM_OPS(serial_imx_runtime_suspend,
 			   serial_imx_runtime_resume, NULL)
-	.suspend_noirq = imx_serial_port_suspend_noirq,
-	.resume_noirq = imx_serial_port_resume_noirq,
-	.suspend = imx_serial_port_suspend,
-	.resume = imx_serial_port_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(imx_serial_port_suspend_noirq,
+				imx_serial_port_resume_noirq)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_serial_port_suspend,
+				      imx_serial_port_resume)
 	.prepare = serial_imx_prepare,
 	.complete = serial_imx_complete,
 };
-- 
2.5.0

