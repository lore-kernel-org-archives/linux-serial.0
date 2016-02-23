From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v1] serial: mctrl_gpio: Add missing module license
Date: Tue, 23 Feb 2016 15:54:54 +0100
Message-ID: <1456239294-28342-1-git-send-email-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

As the mctrl_gpio driver can be built as a module, it needs to have its
license specified with MODULE_LICENSE. Otherwise, it cannot access
required symbols exported through EXPORT_SYMBOL_GPL.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 226ad23b136c..02147361eaa9 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -20,6 +20,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/termios.h>
 #include <linux/serial_core.h>
+#include <linux/module.h>
 
 #include "serial_mctrl_gpio.h"
 
@@ -249,3 +250,5 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 	}
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
+
+MODULE_LICENSE("GPL");
-- 
2.5.0
