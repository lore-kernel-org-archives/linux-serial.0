From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 28/33] serial: Convert to devm_ioremap_resource()
Date: Mon, 21 Jan 2013 11:09:21 +0100
Message-ID: <1358762966-20791-29-git-send-email-thierry.reding@avionic-design.de>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/sccnxp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 418b495..e869eab 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -15,6 +15,7 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/console.h>
@@ -875,10 +876,9 @@ static int sccnxp_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	membase = devm_request_and_ioremap(&pdev->dev, res);
-	if (!membase) {
-		dev_err(&pdev->dev, "Failed to ioremap\n");
-		ret = -EIO;
+	membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(membase)) {
+		ret = PTR_ERR(membase);
 		goto err_out;
 	}
 
-- 
1.8.1.1
