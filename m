From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] tty: ar933x_uart: use config_enabled() macro to clean up ifdefs
Date: Wed, 28 Aug 2013 17:08:39 +0200
Message-ID: <1377702519-8145-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:58223 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab3H1PKR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Aug 2013 11:10:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>

Add a new ar933x_uart_console_enabled() helper function
which uses the config_enable(CONFIG_SERIAL_AR933X_CONSOLE)
macro to decide if the console support is enabled or not.

Remove the 'ifdef CONFIG_SERIAL_AR933X_CONSOLE' statements
and use the new helper function to conditionally enable
console support instead.

If CONFIG_SERIAL_AR933X_CONSOLE is not enabled, the new
helper function will become a null stub which allows the
compiler to optimize out the unused console specific
functions/variables.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
The patch is agains the 'tty-next' branch of the
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree

Additionally, it depends on the following patches:

tty: ar933x_uart: use the clk API to get the uart clock, v2
http://marc.info/?l=linux-serial&m=137767737730297

tty: ar933x_uart: remove superfluous assignment of ar933x_uart_driver.nr
http://marc.info/?l=linux-serial&m=137769248003482
---
 drivers/tty/serial/ar933x_uart.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 2d83a45..0437a9e 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -50,6 +50,11 @@ struct ar933x_uart_port {
 	struct clk		*clk;
 };
 
+static inline bool ar933x_uart_console_enabled(void)
+{
+	return config_enabled(CONFIG_SERIAL_AR933X_CONSOLE);
+}
+
 static inline unsigned int ar933x_uart_read(struct ar933x_uart_port *up,
 					    int offset)
 {
@@ -500,8 +505,6 @@ static struct uart_ops ar933x_uart_ops = {
 	.verify_port	= ar933x_uart_verify_port,
 };
 
-#ifdef CONFIG_SERIAL_AR933X_CONSOLE
-
 static struct ar933x_uart_port *
 ar933x_console_ports[CONFIG_SERIAL_AR933X_NR_UARTS];
 
@@ -600,25 +603,18 @@ static struct console ar933x_uart_console = {
 
 static void ar933x_uart_add_console_port(struct ar933x_uart_port *up)
 {
+	if (!ar933x_uart_console_enabled())
+		return;
+
 	ar933x_console_ports[up->port.line] = up;
 }
 
-#define AR933X_SERIAL_CONSOLE	(&ar933x_uart_console)
-
-#else
-
-static inline void ar933x_uart_add_console_port(struct ar933x_uart_port *up) {}
-
-#define AR933X_SERIAL_CONSOLE	NULL
-
-#endif /* CONFIG_SERIAL_AR933X_CONSOLE */
-
 static struct uart_driver ar933x_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= DRIVER_NAME,
 	.dev_name	= "ttyATH",
 	.nr		= CONFIG_SERIAL_AR933X_NR_UARTS,
-	.cons		= AR933X_SERIAL_CONSOLE,
+	.cons		= NULL, /* filled in runtime */
 };
 
 static int ar933x_uart_probe(struct platform_device *pdev)
@@ -730,6 +726,9 @@ static int __init ar933x_uart_init(void)
 {
 	int ret;
 
+	if (ar933x_uart_console_enabled())
+		ar933x_uart_driver.cons = &ar933x_uart_console;
+
 	ret = uart_register_driver(&ar933x_uart_driver);
 	if (ret)
 		goto err_out;
-- 
1.7.10
