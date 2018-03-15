From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v3 1/3] serial: 8250_early: Add earlycon support for AMD Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 20:04:43 -0600
Message-ID: <20180315020445.150604-2-djkurtz@chromium.org>
References: <20180315020445.150604-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315020445.150604-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
input clock.

Allow these platforms to set up this clock by specifying a kernel command
line like:
earlycon=amdcz,mmio32,0xfedc6000,115200

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes since v1:
 * added Reviewed-by & Suggested-by

 drivers/tty/serial/8250/8250_early.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index ae6a256524d8..c6bf971a6038 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -195,3 +195,18 @@ static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
 OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
 
 #endif
+
+#ifdef CONFIG_SERIAL_8250_DW
+static int __init early_amdcz_setup(struct earlycon_device *dev,
+				    const char *opt)
+{
+	struct uart_port *port = &dev->port;
+
+	port->uartclk = 48000000;
+
+	return early_serial8250_setup(dev, opt);
+}
+
+EARLYCON_DECLARE(amdcz, early_amdcz_setup);
+
+#endif
-- 
2.16.2.804.g6dcf76e118-goog
