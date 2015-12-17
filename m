From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] drivers/tty/serial: delete unused MODULE_DEVICE_TABLE from atmel_serial.c
Date: Thu, 17 Dec 2015 10:05:46 -0500
Message-ID: <1450364746-815-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudip@vectorindia.org>
List-Id: linux-serial@vger.kernel.org

In commit c39dfebc7798956fd2140ae6321786ff35da30c3 ("drivers/tty/serial:
make serial/atmel_serial.c explicitly non-modular") we removed the code
relating to modular support since it currently only supports built in.

However, when redoing my build coverage for mips allmodconfig, which
sets CONFIG_OF, I noticed a remaining line that needs to be removed,
else we will get a build failure for an undefined module macro.

Unfortunately this didn't appear for any of the other arch I tested
more frequently, such as ARM.

Since MODULE_DEVICE_TABLE is a no-op for non-modular code, we can just
remove the offending line.

Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudip@vectorindia.org>
Reported-by: Sudip Mukherjee <sudip@vectorindia.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/atmel_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 50e785a0ea73..1c0884d8ef32 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -188,8 +188,6 @@ static const struct of_device_id atmel_serial_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-usart" },
 	{ /* sentinel */ }
 };
-
-MODULE_DEVICE_TABLE(of, atmel_serial_dt_ids);
 #endif
 
 static inline struct atmel_uart_port *
-- 
2.6.1
