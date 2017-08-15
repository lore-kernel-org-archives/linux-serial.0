From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] earlycon: initialise baud field of earlycon device structure
Date: Tue, 15 Aug 2017 20:21:41 +0300
Message-ID: <20170815172141.29115-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-serial@vger.kernel.org

For now baud field of earlycon structure device is't initialised at all
in of_setup_earlycon (in oppositе to register_earlycon).

So when I use stdout-path to point earlycon device
(like stdout-path = &serial or stdout-path = "serial:115200n8")
baud field of earlycon device structure remains uninitialised and
earlycon initialization is not performed correctly as
of_setup_earlycon is used.
When pass all arguments via bootargs
(like bootargs = "earlycon=uart8250,mmio32,0xf0005000,115200n8")
initialization is performed correctly as register_earlycon is used.

So initialise baud field of earlycon device structure by baud value
from device tree or from options (if they exist) when we use
of_setup_earlycon

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/tty/serial/earlycon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index c365154..6c2e2b6 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -240,6 +240,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
+	unsigned long baud;
 	const __be32 *val;
 	bool big_endian;
 	u64 addr;
@@ -282,7 +283,15 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		}
 	}
 
+	val = of_get_flat_dt_prop(node, "baud", NULL);
+	if (val)
+		early_console_dev.baud = be32_to_cpu(*val);
+
 	if (options) {
+		err = kstrtoul(options, 10, &baud);
+		if (!err)
+			early_console_dev.baud = baud;
+
 		strlcpy(early_console_dev.options, options,
 			sizeof(early_console_dev.options));
 	}
-- 
2.9.3
