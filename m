From: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 1/3] serial: lantiq: Use proper DT compatible string
Date: Thu,  8 Aug 2019 18:02:06 +0800
Message-ID: <57e2b69e9fbd93328a477b4c7dd2dcc78784ecb1.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.com, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Use explicit string instead of a macro for devicetree compatible string.

This series of patches is to add support for multiple SoCs which reuse the same
serial controller IP. The following patches will add another compatible string
to support new Lightning Mountain(LGM) SoC. So it makes sense to have the
compatible strings explicitly mentioned instead of a fixed macro.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/tty/serial/lantiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 42e27b48e9cc..660d21db57dc 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -693,7 +693,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
 	device->con->write = lqasc_serial_early_console_write;
 	return 0;
 }
-OF_EARLYCON_DECLARE(lantiq, DRVNAME, lqasc_serial_early_console_setup);
+OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
 
 static struct uart_driver lqasc_reg = {
 	.owner =	THIS_MODULE,
@@ -792,7 +792,7 @@ lqasc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ltq_asc_match[] = {
-	{ .compatible = DRVNAME },
+	{ .compatible = "lantiq,asc" },
 	{},
 };
 
-- 
2.11.0
