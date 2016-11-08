From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] serial: pxa2xx: mark PM functions as __maybe_unused
Date: Tue,  8 Nov 2016 15:50:42 +0100
Message-ID: <20161108145130.3502815-2-arnd@arndb.de>
References: <20161108145130.3502815-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108145130.3502815-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sergey Yanovich <ynvich@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The fresh new serial driver for pxa produces warnings when
CONFIG_PM_SLEEP is disabled:

drivers/tty/serial/8250/8250_pxa.c:50:12: error: 'serial_pxa_resume' defined but not used [-Werror=unused-function]
drivers/tty/serial/8250/8250_pxa.c:41:12: error: 'serial_pxa_suspend' defined but not used [-Werror=unused-function]

This removes the #ifdef around the two functions and instead marks both
as __maybe_unused, which is more robust and avoids the warning.

Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_pxa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 3b08f342851a..31f27d95d8b4 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -37,8 +37,7 @@ struct pxa8250_data {
 	struct clk		*clk;
 };
 
-#ifdef CONFIG_PM
-static int serial_pxa_suspend(struct device *dev)
+static int __maybe_unused serial_pxa_suspend(struct device *dev)
 {
 	struct pxa8250_data *data = dev_get_drvdata(dev);
 
@@ -47,7 +46,7 @@ static int serial_pxa_suspend(struct device *dev)
 	return 0;
 }
 
-static int serial_pxa_resume(struct device *dev)
+static int __maybe_unused serial_pxa_resume(struct device *dev)
 {
 	struct pxa8250_data *data = dev_get_drvdata(dev);
 
@@ -55,7 +54,6 @@ static int serial_pxa_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops serial_pxa_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(serial_pxa_suspend, serial_pxa_resume)
-- 
2.9.0
