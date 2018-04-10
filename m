From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] tty: serial: xuartps: Setup early console when uartclk is also passed
Date: Tue, 10 Apr 2018 15:33:30 +0200
Message-ID: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Baudrate calculation depends on requested baudrate and uart clock.
This patch is checking that uartclk is also passed.

The same logic is used 8250_early.c/init_port function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b9b2bc76bcac..a654cda203c7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 	/* only set baud if specified on command line - otherwise
 	 * assume it has been initialized by a boot loader.
 	 */
-	if (device->baud) {
+	if (port->uartclk && device->baud) {
 		u32 cd = 0, bdiv = 0;
 		u32 mr;
 		int div8;
-- 
1.9.1
