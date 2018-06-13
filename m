From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] serdev: fix memleak on module unload
Date: Wed, 13 Jun 2018 17:08:59 +0200
Message-ID: <20180613150859.20879-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Make sure to free all resources associated with the ida on module
exit.

Fixes: cd6484e1830b ("serdev: Introduce new bus for serial attached devices")
Cc: stable <stable@vger.kernel.org>	# 4.11
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index df93b727e984..9e59f4788589 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -617,6 +617,7 @@ EXPORT_SYMBOL_GPL(__serdev_device_driver_register);
 static void __exit serdev_exit(void)
 {
 	bus_unregister(&serdev_bus_type);
+	ida_destroy(&ctrl_ida);
 }
 module_exit(serdev_exit);
 
-- 
2.17.1
