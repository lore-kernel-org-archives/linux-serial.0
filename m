From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 3/5] serial: sprd: Remove unnecessary resource validation
Date: Mon, 17 Sep 2018 11:33:42 -0700
Message-ID: <8aa7a92468beb45348bf113696deb263c3f27792.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The devm_ioremap_resource() will valid the resources, thus remove the
unnecessary resource validation in the driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index e18d8af..03b0cd4 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -710,15 +710,12 @@ static int sprd_probe(struct platform_device *pdev)
 		up->uartclk = clk_get_rate(clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "not provide mem resource\n");
-		return -ENODEV;
-	}
-	up->mapbase = res->start;
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(up->membase))
 		return PTR_ERR(up->membase);
 
+	up->mapbase = res->start;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
-- 
1.9.1
