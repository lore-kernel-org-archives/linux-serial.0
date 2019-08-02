From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] tty: serial: qcom_geni_serial: use devm_platform_ioremap_resource() to simplify code
Date: Fri, 2 Aug 2019 21:08:17 +0800
Message-ID: <20190802130817.16220-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-serial@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f879710..af695b6 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -198,10 +198,8 @@ static int qcom_geni_serial_request_port(struct uart_port *uport)
 {
 	struct platform_device *pdev = to_platform_device(uport->dev);
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
-	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	uport->membase = devm_ioremap_resource(&pdev->dev, res);
+	uport->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(uport->membase))
 		return PTR_ERR(uport->membase);
 	port->se.base = uport->membase;
-- 
2.7.4
