From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 3/8] drivers: tty: serial: 8250_ingenic: use devm_ioremap_resource()
Date: Tue, 12 Mar 2019 15:57:35 +0100
Message-ID: <1552402660-31730-4-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use helper devm_ioremap_resource() to make the code a little bit
shorter and easier to read.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_ingenic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 424c07c..90ae3e2 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -249,8 +249,7 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	if (line >= 0)
 		uart.port.line = line;
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1
