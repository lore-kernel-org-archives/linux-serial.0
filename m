From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [Patch v2 3/3] serial: pch_uart: Add support for reading clock-frequency from DT
Date: Fri, 12 Aug 2016 12:48:54 +0100
Message-ID: <1471002534-10673-4-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1471002534-10673-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471002534-10673-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: linux-serial@vger.kernel.org

The MIPS based Boston platform provides a 25MHz clock to the UART.

Enable the driver for MIPS and add support in the driver to read
the frequency from device tree.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V1 -> V2

Added #include <linux/of.h>
---
 drivers/tty/serial/Kconfig    | 2 +-
 drivers/tty/serial/pch_uart.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 518db24a..c783140 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1380,7 +1380,7 @@ config SERIAL_IFX6X60
 
 config SERIAL_PCH_UART
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) UART"
-	depends on PCI && (X86_32 || COMPILE_TEST)
+	depends on PCI && (X86_32 || MIPS ||  COMPILE_TEST)
 	select SERIAL_CORE
 	help
 	  This driver is for PCH(Platform controller Hub) UART of Intel EG20T
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index ea4ffc2..23672f8 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -31,6 +31,7 @@
 #include <linux/dmi.h>
 #include <linux/nmi.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 
 #include <linux/debugfs.h>
 #include <linux/dmaengine.h>
@@ -1826,6 +1827,10 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	priv->trigger_level = 1;
 	priv->fcr = 0;
 
+	if (pdev->dev.of_node)
+		of_property_read_u32(pdev->dev.of_node, "clock-frequency"
+					 , &user_uartclk);
+
 #ifdef CONFIG_SERIAL_PCH_UART_CONSOLE
 	pch_uart_ports[board->line_no] = priv;
 #endif
-- 
1.9.1
