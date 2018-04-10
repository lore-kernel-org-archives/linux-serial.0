From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] earlycon: Initialize port->uartclk based on clock-frequency property
Date: Tue, 10 Apr 2018 15:32:28 +0200
Message-ID: <f483181cd3a234c2eae7e11b91a1767a0cbb88ed.1523367143.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, devicetree@vger.kernel.org, Rob Herring <robherring2@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On DT based platforms when current-speed property is present baudrate
is setup. Also port->uartclk is initialized to bogus BASE_BAUD * 16
value. Drivers like uartps/ns16550 contain logic when baudrate and
uartclk is used for baudrate calculation.

The patch is reading optional clock-frequency property to replace bogus
BASE_BAUD * 16 calculation to have proper baudrate calculation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

We should add documentation for current-speed, reg-offset, reg-shift,
big-endian, native-endian, reg-io-width and clock-frequency to any
generic location because they are all optional properties for all DT
earlycon drivers through of_setup_earlycon.

---
 drivers/tty/serial/earlycon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a24278380fec..eb1f84258c44 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -279,6 +279,10 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	if (val)
 		early_console_dev.baud = be32_to_cpu(*val);
 
+	val = of_get_flat_dt_prop(node, "clock-frequency", NULL);
+	if (val)
+		port->uartclk = be32_to_cpu(*val);
+
 	if (options) {
 		early_console_dev.baud = simple_strtoul(options, NULL, 0);
 		strlcpy(early_console_dev.options, options,
-- 
1.9.1
