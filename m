From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/5] drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular
Date: Sun, 18 Oct 2015 18:21:16 -0400
Message-ID: <1445206878-12455-4-git-send-email-paul.gortmaker@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/Kconfig:config SERIAL_ATMEL
drivers/tty/serial/Kconfig:     bool "AT91 / AT32 on-chip serial port support"

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

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/atmel_serial.c | 45 ++++-----------------------------------
 1 file changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 94294558943c..d19a1e931529 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -22,7 +22,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
-#include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
@@ -2866,37 +2865,14 @@ err:
 	return ret;
 }
 
-static int atmel_serial_remove(struct platform_device *pdev)
-{
-	struct uart_port *port = platform_get_drvdata(pdev);
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	int ret = 0;
-
-	tasklet_kill(&atmel_port->tasklet);
-
-	device_init_wakeup(&pdev->dev, 0);
-
-	ret = uart_remove_one_port(&atmel_uart, port);
-
-	kfree(atmel_port->rx_ring.buf);
-
-	/* "port" is allocated statically, so we shouldn't free it */
-
-	clear_bit(port->line, atmel_ports_in_use);
-
-	clk_put(atmel_port->clk);
-
-	return ret;
-}
-
 static struct platform_driver atmel_serial_driver = {
 	.probe		= atmel_serial_probe,
-	.remove		= atmel_serial_remove,
 	.suspend	= atmel_serial_suspend,
 	.resume		= atmel_serial_resume,
 	.driver		= {
-		.name	= "atmel_usart",
-		.of_match_table	= of_match_ptr(atmel_serial_dt_ids),
+		.name			= "atmel_usart",
+		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
+		.suppress_bind_attrs    = true,
 	},
 };
 
@@ -2914,17 +2890,4 @@ static int __init atmel_serial_init(void)
 
 	return ret;
 }
-
-static void __exit atmel_serial_exit(void)
-{
-	platform_driver_unregister(&atmel_serial_driver);
-	uart_unregister_driver(&atmel_uart);
-}
-
-module_init(atmel_serial_init);
-module_exit(atmel_serial_exit);
-
-MODULE_AUTHOR("Rick Bronson");
-MODULE_DESCRIPTION("Atmel AT91 / AT32 serial port driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:atmel_usart");
+device_initcall(atmel_serial_init);
-- 
2.6.1
