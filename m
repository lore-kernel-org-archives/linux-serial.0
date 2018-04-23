From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC. PATCH] earlycon: Remove hardcoded port->uartclk initialization in of_setup_earlycon
Date: Mon, 23 Apr 2018 11:27:50 +0200
Message-ID: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, devicetree@vger.kernel.org, Rob Herring <robherring2@gmail.com>, matt.redfearn@mips.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
systems.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

It looks like from history that portclk = BASE_BAUD * 16 was setup to
get on calculation on x86 (divisor = 1) but it shouldn't be needed on DT based
system. That's why I think that there is no DT based system which really
requires this line.
---
 drivers/tty/serial/earlycon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a24278380fec..c12b1edcdd8e 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -244,7 +244,6 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		return -ENXIO;
 	}
 	port->mapbase = addr;
-	port->uartclk = BASE_BAUD * 16;
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
-- 
2.17.0
