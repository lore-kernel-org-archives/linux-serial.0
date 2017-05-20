From: Sam Povilus <kernel.development@povil.us>
Subject: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the number of xilinx ps uarts
Date: Fri, 19 May 2017 20:21:54 -0600
Message-ID: <20170520022154.6766-1-kernel.development@povil.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sam Povilus <kernel.development@povil.us>
List-Id: linux-serial@vger.kernel.org

The number of xilinx ps uart should be set by a kernel parameter instead of
using a #define. This allows the user to set the number of xilinx ps uart
using only kconfig and not modifying kernel source.

The ps uart is used in Xilnx Zynq chips usually in quantities maxing at
two, but there may be other chips that use more in the future or that I
don't know about. 

Signed-off-by: Sam Povilus <kernel.development@povil.us>
---
 drivers/tty/serial/Kconfig         | 9 +++++++++
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5c8850f7a2a0..fef25f17a4cc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1461,6 +1461,15 @@ config SERIAL_XILINX_PS_UART_CONSOLE
 	help
 	  Enable a Cadence UART port to be the system console.
 
+config SERIAL_XILINX_PS_UART_NR_UARTS
+       int "Maximum number of Cadence UART ports"
+       depends on CONFIG_SERIAL_XILINX_NR_UARTS
+       range 1 64
+       default 2
+       help
+         Set this to the number of Cadence UARTS in your system, or the number
+	 you think you might implement.
+
 config SERIAL_AR933X
 	tristate "AR933X serial port support"
 	depends on HAVE_CLK && SOC_AR933X
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c0539950f8d7..a2c51c35da65 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -36,7 +36,7 @@
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
 #define CDNS_UART_MINOR		0	/* works best with devtmpfs */
-#define CDNS_UART_NR_PORTS	2
+#define CDNS_UART_NR_PORTS	CONFIG_SERIAL_XILINX_NR_UARTS
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 
-- 
2.11.0
