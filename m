From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] serial: 8250_omap: Make 8250_omap driver driver depend on ARCH_K3
Date: Mon, 27 Aug 2018 20:03:02 -0500
Message-ID: <20180828010302.2751-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-serial@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Allow 8250 omap serial driver to be used for K3 platforms.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Now that we have the device tree support merged integrated AND we have ARCH_K3,
Lets enable the 820 OMAP Driver to build for ARCH_K3 and make it operational.

 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f005eaf8bc57..15c2c5463835 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -375,7 +375,7 @@ config SERIAL_8250_RT288X
 
 config SERIAL_8250_OMAP
 	tristate "Support for OMAP internal UART (8250 based driver)"
-	depends on SERIAL_8250 && ARCH_OMAP2PLUS
+	depends on SERIAL_8250 && (ARCH_OMAP2PLUS || ARCH_K3)
 	help
 	  If you have a machine based on an Texas Instruments OMAP CPU you
 	  can enable its onboard serial ports by enabling this option.
-- 
2.15.1
