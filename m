From: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Subject: [PATCH] drivers: tty: serial: use devm_ioremap_resource()
Date: Thu, 11 Apr 2013 22:58:57 +0300
Message-ID: <1365710337-12251-1-git-send-email-silviupopescu1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Warren <swarren@wwwdotorg.org>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
List-Id: linux-serial@vger.kernel.org

Convert  use of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

This was found with coccinelle.

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
---
 drivers/tty/serial/serial-tegra.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 372de8a..2080fd7 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1301,11 +1301,9 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	}
 
 	u->mapbase = resource->start;
-	u->membase = devm_request_and_ioremap(&pdev->dev, resource);
-	if (!u->membase) {
-		dev_err(&pdev->dev, "memregion/iomap address req failed\n");
-		return -EADDRNOTAVAIL;
-	}
+	u->membase = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR(u->membase))
+		return PTR_ERR(u->membase);
 
 	tup->uart_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(tup->uart_clk)) {
-- 
1.7.9.5
