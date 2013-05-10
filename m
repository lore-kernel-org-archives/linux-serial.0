From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 27/42] drivers/tty/serial: don't check resource with devm_ioremap_resource
Date: Fri, 10 May 2013 10:17:12 +0200
Message-ID: <1368173847-5661-28-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Warren <swarren@wwwdotorg.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/tty/serial/serial-tegra.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 9799d04..9570b55 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1295,13 +1295,9 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	tup->cdata = cdata;
 
 	platform_set_drvdata(pdev, tup);
-	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!resource) {
-		dev_err(&pdev->dev, "No IO memory resource\n");
-		return -ENODEV;
-	}
 
 	u->mapbase = resource->start;
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	u->membase = devm_ioremap_resource(&pdev->dev, resource);
 	if (IS_ERR(u->membase))
 		return PTR_ERR(u->membase);
-- 
1.7.10.4
