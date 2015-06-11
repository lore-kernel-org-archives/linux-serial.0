From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Subject: [PATCH] serial: sprd: check for NULL after calling devm_clk_get
Date: Thu, 11 Jun 2015 10:39:46 +0800
Message-ID: <1433990386-14722-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <serial-sprd>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <serial-sprd>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: peter@hurleysoftware.com, zhang.lyra@gmail.com, fernando.guzman.lugo@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Fernando Guzman Lugo <fernando.guzman.lugo@intel.com>

In platforms which does not use CLK framework (HAVE_CLK not set), the
clk_* functions return NULL instead of an error. This patch handles that
scenario.

Signed-off-by: Fernando Guzman Lugo <fernando.guzman.lugo@intel.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 582d272..3866516 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -716,7 +716,7 @@ static int sprd_probe(struct platform_device *pdev)
 	up->flags = UPF_BOOT_AUTOCONF;
 
 	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk))
+	if (!IS_ERR_OR_NULL(clk))
 		up->uartclk = clk_get_rate(clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.9.1
