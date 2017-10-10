From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] serial: sh-sci: Remove __init attribute from static struct 'port_cfg'
Date: Mon,  9 Oct 2017 17:04:11 -0700
Message-ID: <20171010000411.140016-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <groeck@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-serial@vger.kernel.org

This fixes the following error when building with clang:

drivers/tty/serial/sh-sci.c:3247:15: error: '__section__' attribute only
  applies to functions, methods, properties, and global variables
    static struct __init plat_sci_port port_cfg;

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 784dd42002ea..0d1df1df9e89 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3244,7 +3244,7 @@ early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-static struct __init plat_sci_port port_cfg;
+static struct plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
-- 
2.14.2.920.gcf0c67979c-goog
