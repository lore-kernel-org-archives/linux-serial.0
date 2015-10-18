From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/5] drivers/tty/serial: make msm_serial.c explicitly non-modular
Date: Sun, 18 Oct 2015 18:21:17 -0400
Message-ID: <1445206878-12455-5-git-send-email-paul.gortmaker@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/Kconfig:config SERIAL_MSM
drivers/tty/serial/Kconfig:     bool "MSM on-chip serial port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Kumar Gala <galak@codeaurora.org>
Cc: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/msm_serial.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index dcde955475dc..15afa8070b7d 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -23,7 +23,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/hrtimer.h>
-#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
@@ -1601,15 +1600,6 @@ static int msm_serial_probe(struct platform_device *pdev)
 	return uart_add_one_port(&msm_uart_driver, port);
 }
 
-static int msm_serial_remove(struct platform_device *pdev)
-{
-	struct uart_port *port = platform_get_drvdata(pdev);
-
-	uart_remove_one_port(&msm_uart_driver, port);
-
-	return 0;
-}
-
 static const struct of_device_id msm_match_table[] = {
 	{ .compatible = "qcom,msm-uart" },
 	{ .compatible = "qcom,msm-uartdm" },
@@ -1617,11 +1607,11 @@ static const struct of_device_id msm_match_table[] = {
 };
 
 static struct platform_driver msm_platform_driver = {
-	.remove = msm_serial_remove,
 	.probe = msm_serial_probe,
 	.driver = {
-		.name = "msm_serial",
-		.of_match_table = msm_match_table,
+		.name			= "msm_serial",
+		.of_match_table		= msm_match_table,
+		.suppress_bind_attrs	= true,
 	},
 };
 
@@ -1641,16 +1631,4 @@ static int __init msm_serial_init(void)
 
 	return ret;
 }
-
-static void __exit msm_serial_exit(void)
-{
-	platform_driver_unregister(&msm_platform_driver);
-	uart_unregister_driver(&msm_uart_driver);
-}
-
-module_init(msm_serial_init);
-module_exit(msm_serial_exit);
-
-MODULE_AUTHOR("Robert Love <rlove@google.com>");
-MODULE_DESCRIPTION("Driver for msm7x serial device");
-MODULE_LICENSE("GPL");
+device_initcall(msm_serial_init);
-- 
2.6.1
