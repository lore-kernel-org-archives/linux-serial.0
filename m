From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD Carrizo / Stoneyridge
Date: Tue, 13 Mar 2018 18:36:53 -0600
Message-ID: <20180314003655.12141-2-djkurtz@chromium.org>
References: <20180314003655.12141-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314003655.12141-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: adurbin@chromium.org, Daniel Kurtz <djkurtz@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Douglas Anderson <dianders@chromium.org>, Matt Redfearn <matt.redfearn@mips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
input clock.

Allow these platforms to set up this clock by specifying a kernel command
line like:
earlycon=amdcz,mmio32,0xfedc6000,115200

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
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
