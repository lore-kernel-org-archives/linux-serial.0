From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 02/10] tty: serial: bcm63xx: Add support for unnamed clock outputs from DT
Date: Tue, 21 Oct 2014 15:22:58 -0700
Message-ID: <1413930186-23168-3-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39444 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933387AbaJUWX0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 18:23:26 -0400
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

The original non-DT bcm63xx clk code ignores the struct device argument
and looks up a global clock name.  DT platforms, by contrast, often just
use a phandle to reference a clock node with no "clock-output-names"
property.  Modify the UART driver to support both schemes.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 2315190..de95573 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -824,7 +824,8 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
-	clk = clk_get(&pdev->dev, "periph");
+	clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
+				  clk_get(&pdev->dev, "periph");
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
2.1.1

