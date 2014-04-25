From: jon@ringle.org
Subject: [PATCH 1/2] serial: sc16is7xx: depend on I2C
Date: Fri, 25 Apr 2014 15:53:09 -0400
Message-ID: <1398455590-4374-1-git-send-email-jon@ringle.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, shc_work@mail.ru, Jon Ringle <jringle@gridpoint.com>
List-Id: linux-serial@vger.kernel.org

From: Jon Ringle <jringle@gridpoint.com>

Signed-off-by: Jon Ringle <jringle@gridpoint.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index c3e2b32..64c5659 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1180,6 +1180,7 @@ config SERIAL_SCCNXP_CONSOLE
 
 config SERIAL_SC16IS7XX
 	tristate "SC16IS7xx serial support"
+	depends on I2C
 	select SERIAL_CORE
 	select REGMAP_I2C if I2C
 	help
-- 
1.8.5.4
