From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 4/4] serial: imx: use SET_*SYSTEM_PM_OPS helper functions
Date: Fri, 14 Aug 2015 21:37:48 -0700
Message-ID: <1439613468-22366-5-git-send-email-edubezval@gmail.com>
References: <1439613468-22366-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439613468-22366-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
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
index 24ed0fa..bdda44d5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2277,10 +2277,10 @@ static int imx_serial_port_resume(struct device *dev)
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
