From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode switch for suspend
Date: Thu,  9 Aug 2018 18:06:09 +0800
Message-ID: <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

On some i.MX SoCs' low power mode, UART iomux settings
may be lost, need to add pinctrl sleep/default mode switch
during suspend/resume to make sure UART iomux settings are
correct after resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a09ccef..c280d43 100644
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
@@ -2447,6 +2448,8 @@ static int imx_uart_suspend_noirq(struct device *dev)
 
 	clk_disable(sport->clk_ipg);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -2455,6 +2458,8 @@ static int imx_uart_resume_noirq(struct device *dev)
 	struct imx_port *sport = dev_get_drvdata(dev);
 	int ret;
 
+	pinctrl_pm_select_default_state(dev);
+
 	ret = clk_enable(sport->clk_ipg);
 	if (ret)
 		return ret;
-- 
2.7.4
