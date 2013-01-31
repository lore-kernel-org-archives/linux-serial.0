From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] tty: of_serial: unexport tegra_serial_handle_break
Date: Thu, 31 Jan 2013 12:01:53 -0700
Message-ID: <1359658913-9828-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Tegra is only booted through device-tree now; there are no board files
left that use this function. Hence, don't export it. Move the static
inline definition into of_serial.c, so we can delete of_serial.h too.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/of_serial.c |    7 ++++---
 include/linux/of_serial.h      |   17 -----------------
 2 files changed, 4 insertions(+), 20 deletions(-)
 delete mode 100644 include/linux/of_serial.h

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e7cae1c..d587460 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -18,7 +18,6 @@
 #include <linux/serial_reg.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_serial.h>
 #include <linux/of_platform.h>
 #include <linux/nwpserial.h>
 #include <linux/clk.h>
@@ -45,8 +44,10 @@ void tegra_serial_handle_break(struct uart_port *p)
 		udelay(1);
 	} while (1);
 }
-/* FIXME remove this export when tegra finishes conversion to open firmware */
-EXPORT_SYMBOL_GPL(tegra_serial_handle_break);
+#else
+static inline void tegra_serial_handle_break(struct uart_port *port)
+{
+}
 #endif
 
 /*
diff --git a/include/linux/of_serial.h b/include/linux/of_serial.h
deleted file mode 100644
index 4a73ed8..0000000
--- a/include/linux/of_serial.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef __LINUX_OF_SERIAL_H
-#define __LINUX_OF_SERIAL_H
-
-/*
- * FIXME remove this file when tegra finishes conversion to open firmware,
- * expectation is that all quirks will then be self-contained in
- * drivers/tty/serial/of_serial.c.
- */
-#ifdef CONFIG_ARCH_TEGRA
-extern void tegra_serial_handle_break(struct uart_port *port);
-#else
-static inline void tegra_serial_handle_break(struct uart_port *port)
-{
-}
-#endif
-
-#endif /* __LINUX_OF_SERIAL */
-- 
1.7.10.4
