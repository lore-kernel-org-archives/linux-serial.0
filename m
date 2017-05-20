From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: of_serial: remove NULL pointer check for clk_disable_unprepare
Date: Sun, 21 May 2017 02:44:46 +0900
Message-ID: <1495302286-1503-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>, Sekhar Nori <nsekhar@ti.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Thor Thayer <tthayer@opensource.altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

After long term efforts of fixing non-common clock implementations,
clk_disable() is a no-op for a NULL pointer input, and this is now
tree-wide consistent.

All clock consumers can safely call clk_disable(_unprepare) without
NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_of.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 1cbadaf..89ba2b5 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -159,8 +159,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	return 0;
 out:
-	if (info->clk)
-		clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(info->clk);
+
 	return ret;
 }
 
@@ -229,8 +229,8 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 
 	serial8250_unregister_port(info->line);
 
-	if (info->clk)
-		clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(info->clk);
+
 	kfree(info);
 	return 0;
 }
@@ -244,7 +244,7 @@ static int of_serial_suspend(struct device *dev)
 
 	serial8250_suspend_port(info->line);
 
-	if (info->clk && (!uart_console(port) || console_suspend_enabled))
+	if (!uart_console(port) || console_suspend_enabled)
 		clk_disable_unprepare(info->clk);
 
 	return 0;
-- 
2.7.4
