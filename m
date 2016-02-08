From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] serial: 8250_early: Add earlycon support for Tegra
Date: Mon, 8 Feb 2016 16:27:35 +0000
Message-ID: <1454948855-26640-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Declare an OF early console for Tegra so that the early console device
can be specified via the "stdout-path" property in device-tree.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/8250/8250_early.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 3b3dbdc1b73e..8d08ff5c4e34 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -149,6 +149,7 @@ EARLYCON_DECLARE(uart8250, early_serial8250_setup);
 EARLYCON_DECLARE(uart, early_serial8250_setup);
 OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
 OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
+OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
 
 #ifdef CONFIG_SERIAL_8250_OMAP
 
-- 
2.1.4
