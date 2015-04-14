From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2] serial: of-serial: Remove device_type = "serial" registration
Date: Tue, 14 Apr 2015 12:03:09 +0200
Message-ID: <ffb577a257d14087e1d2d0347a071f5aef519e52.1429005786.git.michal.simek@xilinx.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Do not probe all serial drivers by of_serial.c which are using
device_type = "serial"; property. Only drivers which have valid
compatible strings listed in the driver should be probed.

When PORT_UNKNOWN is setup probe will fail anyway.

Arnd quotation about driver historical background:
"when I wrote that driver initially, the idea was that it would
get used as a stub to hook up all other serial drivers but after
that, the common code learned to create platform devices from DT"

This patch fix the problem with on the system with xilinx_uartps and
16550a where of_serial failed to register for xilinx_uartps and because
of irq_dispose_mapping() removed irq_desc. Then when xilinx_uartps was asking
for irq with request_irq() EINVAL is returned.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
CC: <stable@vger.kernel.org>
---

Changes in v2:
- Extend patch description

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
