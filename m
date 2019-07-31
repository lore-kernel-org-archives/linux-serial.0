From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/14] net: lpc-enet: factor out iram access
Date: Wed, 31 Jul 2019 21:56:48 +0200
Message-ID: <20190731195713.3150463-7-arnd@arndb.de>
References: <20190731195713.3150463-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731195713.3150463-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The lpc_eth driver uses a platform specific method to find
the internal sram. This prevents building it on other machines.

Rework to only use one function call and keep the other platform
internals where they belong. Ideally this would look up the
sram location from DT, but as this is a rarely used driver,
I want to keep the modifications to a minimum.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-lpc32xx/common.c             |  9 ++++++--
 arch/arm/mach-lpc32xx/common.h             |  1 -
 arch/arm/mach-lpc32xx/include/mach/board.h | 15 --------------
 drivers/net/ethernet/nxp/lpc_eth.c         | 17 ++++++++-------
 include/linux/soc/nxp/lpc32xx-misc.h       | 24 ++++++++++++++++++++++
 5 files changed, 39 insertions(+), 27 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/board.h
 create mode 100644 include/linux/soc/nxp/lpc32xx-misc.h

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 5b71b4fab2cd..f648324d5fb4 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/soc/nxp/lpc32xx-misc.h>
 
 #include <asm/mach/map.h>
 #include <asm/system_info.h>
@@ -32,7 +33,7 @@ void lpc32xx_get_uid(u32 devid[4])
  */
 #define LPC32XX_IRAM_BANK_SIZE SZ_128K
 static u32 iram_size;
-u32 lpc32xx_return_iram_size(void)
+u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
 {
 	if (iram_size == 0) {
 		u32 savedval1, savedval2;
@@ -53,10 +54,14 @@ u32 lpc32xx_return_iram_size(void)
 		} else
 			iram_size = LPC32XX_IRAM_BANK_SIZE * 2;
 	}
+	if (dmaaddr)
+		*dmaaddr = LPC32XX_IRAM_BASE;
+	if (mapbase)
+		*mapbase = io_p2v(LPC32XX_IRAM_BASE);
 
 	return iram_size;
 }
-EXPORT_SYMBOL_GPL(lpc32xx_return_iram_size);
+EXPORT_SYMBOL_GPL(lpc32xx_return_iram);
 
 static struct map_desc lpc32xx_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 8e597ce48a73..32f0ad217807 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -23,7 +23,6 @@ extern void __init lpc32xx_serial_init(void);
  */
 extern void lpc32xx_get_uid(u32 devid[4]);
 
-extern u32 lpc32xx_return_iram_size(void);
 /*
  * Pointers used for sizing and copying suspend function data
  */
diff --git a/arch/arm/mach-lpc32xx/include/mach/board.h b/arch/arm/mach-lpc32xx/include/mach/board.h
deleted file mode 100644
index 476513d970a4..000000000000
--- a/arch/arm/mach-lpc32xx/include/mach/board.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * arm/arch/mach-lpc32xx/include/mach/board.h
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
- */
-
-#ifndef __ASM_ARCH_BOARD_H
-#define __ASM_ARCH_BOARD_H
-
-extern u32 lpc32xx_return_iram_size(void);
-
-#endif  /* __ASM_ARCH_BOARD_H */
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index f7e11f1b0426..bcdd0adcfb0c 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -18,8 +18,8 @@
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/soc/nxp/lpc32xx-misc.h>
 
-#include <mach/board.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
 
@@ -1311,16 +1311,15 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	/* Get size of DMA buffers/descriptors region */
 	pldat->dma_buff_size = (ENET_TX_DESC + ENET_RX_DESC) * (ENET_MAXF_SIZE +
 		sizeof(struct txrx_desc_t) + sizeof(struct rx_status_t));
-	pldat->dma_buff_base_v = 0;
 
 	if (use_iram_for_net(dev)) {
-		dma_handle = LPC32XX_IRAM_BASE;
-		if (pldat->dma_buff_size <= lpc32xx_return_iram_size())
-			pldat->dma_buff_base_v =
-				io_p2v(LPC32XX_IRAM_BASE);
-		else
+		if (pldat->dma_buff_size >
+		    lpc32xx_return_iram(&pldat->dma_buff_base_v, &dma_handle)) {
+			pldat->dma_buff_base_v = NULL;
+			pldat->dma_buff_size = 0;
 			netdev_err(ndev,
 				"IRAM not big enough for net buffers, using SDRAM instead.\n");
+		}
 	}
 
 	if (pldat->dma_buff_base_v == 0) {
@@ -1409,7 +1408,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	unregister_netdev(ndev);
 err_out_dma_unmap:
 	if (!use_iram_for_net(dev) ||
-	    pldat->dma_buff_size > lpc32xx_return_iram_size())
+	    pldat->dma_buff_size > lpc32xx_return_iram(NULL, NULL))
 		dma_free_coherent(dev, pldat->dma_buff_size,
 				  pldat->dma_buff_base_v,
 				  pldat->dma_buff_base_p);
@@ -1436,7 +1435,7 @@ static int lpc_eth_drv_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 
 	if (!use_iram_for_net(&pldat->pdev->dev) ||
-	    pldat->dma_buff_size > lpc32xx_return_iram_size())
+	    pldat->dma_buff_size > lpc32xx_return_iram(NULL, NULL))
 		dma_free_coherent(&pldat->pdev->dev, pldat->dma_buff_size,
 				  pldat->dma_buff_base_v,
 				  pldat->dma_buff_base_p);
diff --git a/include/linux/soc/nxp/lpc32xx-misc.h b/include/linux/soc/nxp/lpc32xx-misc.h
new file mode 100644
index 000000000000..f232e1a1bcdc
--- /dev/null
+++ b/include/linux/soc/nxp/lpc32xx-misc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ */
+
+#ifndef __SOC_LPC32XX_MISC_H
+#define __SOC_LPC32XX_MISC_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_ARCH_LPC32XX
+extern u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr);
+#else
+static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
+{
+	*mapbase = NULL;
+	*dmaaddr = 0;
+	return 0;
+}
+#endif
+
+#endif  /* __SOC_LPC32XX_MISC_H */
-- 
2.20.0
