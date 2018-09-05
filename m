From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V2 2/2] tty: serial: imx: add pinctrl sleep/default mode switch for suspend
Date: Wed,  5 Sep 2018 09:24:27 +0800
Message-ID: <1536110667-23530-2-git-send-email-Anson.Huang@nxp.com>
References: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc: Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

On some i.MX SoCs' low power mode, such as i.MX7D's LPSR(low power
state retention), UART iomux settings will be lost, need to add
pinctrl sleep/default mode switch during suspend/resume to make
sure UART iomux settings are correct after resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c15332d..6ccb5c4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -24,6 +24,7 @@
 #include <linux/serial.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -2449,6 +2450,8 @@ static int imx_uart_suspend_noirq(struct device *dev)
 
 	clk_disable(sport->clk_ipg);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -2457,6 +2460,8 @@ static int imx_uart_resume_noirq(struct device *dev)
 	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
+	pinctrl_pm_select_default_state(dev);
+
 	ret = clk_enable(sport->clk_ipg);
 	if (ret)
 		return ret;
-- 
2.7.4
