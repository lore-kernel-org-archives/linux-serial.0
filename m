From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V2] tty: serial: imx: Use platform_get_irq_optional() for optional IRQs
Date: Wed,  9 Oct 2019 17:49:19 +0800
Message-ID: <1570614559-11900-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, rafael.j.wysocki@intel.com, swboyd@chromium.org, andy.shevchenko@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

All i.MX SoCs except i.MX1 have ONLY one necessary IRQ, use
platform_get_irq_optional() to get second/third IRQ which are
optional to avoid below error message during probe:

[    0.726219] imx-uart 30860000.serial: IRQ index 1 not found
[    0.731329] imx-uart 30860000.serial: IRQ index 2 not found

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- use platform_get_irq_optional() directly instead of getting irq count.
---
 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 504d81c..357d3ff 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2221,8 +2221,8 @@ static int imx_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	rxirq = platform_get_irq(pdev, 0);
-	txirq = platform_get_irq(pdev, 1);
-	rtsirq = platform_get_irq(pdev, 2);
+	txirq = platform_get_irq_optional(pdev, 1);
+	rtsirq = platform_get_irq_optional(pdev, 2);
 
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
-- 
2.7.4
