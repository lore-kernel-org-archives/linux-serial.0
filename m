From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] tty/serial: mark __init early_smh_setup() static
Date: Thu,  1 Sep 2016 19:43:31 +0800
Message-ID: <1472730211-17288-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn
List-Id: linux-serial@vger.kernel.org

We get 1 warning when building kernel with W=1:
drivers/tty/serial/earlycon-arm-semihost.c:56:12: warning: no previous prototype for 'early_smh_setup' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
so this patch marks this function with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/tty/serial/earlycon-arm-semihost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon-arm-semihost.c b/drivers/tty/serial/earlycon-arm-semihost.c
index 383db10..6bbeb69 100644
--- a/drivers/tty/serial/earlycon-arm-semihost.c
+++ b/drivers/tty/serial/earlycon-arm-semihost.c
@@ -53,7 +53,8 @@ static void smh_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, smh_putc);
 }
 
-int __init early_smh_setup(struct earlycon_device *device, const char *opt)
+static int
+__init early_smh_setup(struct earlycon_device *device, const char *opt)
 {
 	device->con->write = smh_write;
 	return 0;
-- 
2.7.4
