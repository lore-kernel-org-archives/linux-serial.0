From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v4 09/21] serial: omap: drop unnecessary check from remove
Date: Thu,  6 Sep 2012 15:45:28 +0300
Message-ID: <1346935540-1792-10-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-serial@vger.kernel.org

if platform_get_drvdata() returns NULL, that's
quite a nasty bug on the driver which we want to
catch ASAP. Otherwise, that check is hugely
unneeded.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 8a696a4..c19d340 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1369,13 +1369,10 @@ static int serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
 
-	if (up) {
-		pm_runtime_disable(up->dev);
-		uart_remove_one_port(&serial_omap_reg, &up->port);
-		pm_qos_remove_request(&up->pm_qos_request);
-	}
+	pm_runtime_disable(up->dev);
+	uart_remove_one_port(&serial_omap_reg, &up->port);
+	pm_qos_remove_request(&up->pm_qos_request);
 
-	platform_set_drvdata(dev, NULL);
 	return 0;
 }
 
-- 
1.7.12.rc3

