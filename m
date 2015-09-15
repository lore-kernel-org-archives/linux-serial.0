From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [RESEND PATCH] serial: 8250: Add OF earlycon support
Date: Mon, 14 Sep 2015 19:56:03 -0500
Message-ID: <20150915005603.GA20045@home.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This allows earlycon to be used without needing to specify the I/O
address on the kernel command line, if linux,stdout-path is specified
in the chosen node.

Signed-off-by: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Sorry, forgot to include the mailing lists on previous sending.

 drivers/tty/serial/8250/8250_early.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index faed05f..ceb8579 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -29,6 +29,8 @@
 #include <linux/tty.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/serial_reg.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
@@ -152,3 +154,5 @@ int __init early_serial8250_setup(struct earlycon_device *device,
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
 EARLYCON_DECLARE(uart, early_serial8250_setup);
+OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
+OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
