From: Richard Zhao <rizhao-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] serial: tegra: correct help message in Kconfig from 'ttyHS' to 'ttyTHS'
Date: Sun, 21 Jul 2013 10:43:26 +0800
Message-ID: <1374374607-31183-1-git-send-email-rizhao@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Richard Zhao <rizhao-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

ttyTHS is consistent with the name used in driver.

Signed-off-by: Richard Zhao <rizhao-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5e3d689..1456673 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -277,7 +277,7 @@ config SERIAL_TEGRA
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the NVIDIA Tegra series SOCs
-	  providing /dev/ttyHS0, 1, 2, 3 and 4 (note, some machines may not
+	  providing /dev/ttyTHS0, 1, 2, 3 and 4 (note, some machines may not
 	  provide all of these ports, depending on how the serial port
 	  are enabled). This driver uses the APB DMA to achieve higher baudrate
 	  and better performance.
-- 
1.8.1.5
