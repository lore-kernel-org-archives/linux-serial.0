From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: of-serial: Remove device_type = "serial" registration
Date: Mon, 13 Apr 2015 16:35:27 +0200
Message-ID: <b8ba9c125be49a8a70a04807179c5f7fe79b1ae0.1428935724.git.michal.simek@xilinx.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Do not probe all serial drivers by of_serial.c which are using
device_type = "serial"; property. Only drivers which have valid
compatible strings listed in the driver should be probed.

When PORT_UNKNOWN probe will fail anyway.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
CC: <stable@vger.kernel.org>
---

 drivers/tty/serial/of_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 33fb94f78967..0a52c8b55a5f 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -344,7 +344,6 @@ static struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "ibm,qpace-nwp-serial",
 		.data = (void *)PORT_NWPSERIAL, },
 #endif
-	{ .type = "serial",         .data = (void *)PORT_UNKNOWN, },
 	{ /* end of list */ },
 };
 
-- 
2.3.5
