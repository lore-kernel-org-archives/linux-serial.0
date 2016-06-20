From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] serial: m32r_sio: make it explicitly non-modular
Date: Mon, 20 Jun 2016 18:55:05 -0400
Message-ID: <20160620225505.7320-4-paul.gortmaker@windriver.com>
References: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/Kconfig:config SERIAL_M32R_SIO
drivers/tty/serial/Kconfig:     bool "M32R SIO I/F"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We don't replace module.h with init.h since the file already has that.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/m32r_sio.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 68765f7c2645..ea29017d320a 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -30,7 +30,6 @@
 #define SUPPORT_SYSRQ
 #endif
 
-#include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/ioport.h>
@@ -1060,19 +1059,4 @@ static int __init m32r_sio_init(void)
 
 	return ret;
 }
-
-static void __exit m32r_sio_exit(void)
-{
-	int i;
-
-	for (i = 0; i < UART_NR; i++)
-		uart_remove_one_port(&m32r_sio_reg, &m32r_sio_ports[i].port);
-
-	uart_unregister_driver(&m32r_sio_reg);
-}
-
-module_init(m32r_sio_init);
-module_exit(m32r_sio_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Generic M32R SIO serial driver");
+device_initcall(m32r_sio_init);
-- 
2.8.4
