From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v3 5/5] ARM: davinci: serial: platform code cleanup
Date: Wed, 19 Jun 2013 14:45:42 +0530
Message-ID: <1371633342-1210-6-git-send-email-prakash.pm@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42320 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934057Ab3FSJP2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Jun 2013 05:15:28 -0400
In-Reply-To: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-serial@vger.kernel.org
Cc: nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

1) "struct davinci_uart_config" is introduced to specify
   UART ports brought out or enabled on the board. But
   none of the boards use them for that purpose, so clean
   it up.
2) Have pointer to platform device as a argument for
   davinci_serial_init(), no need of serial_dev in
   struct soc_info now.
3) No need of davinci_serial_setup_clk(), not called from
   multiple places, hence reduce function call overhead.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Suggested-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-da830-evm.c        |    6 +---
 arch/arm/mach-davinci/board-da850-evm.c        |    6 +---
 arch/arm/mach-davinci/board-dm355-evm.c        |    6 +---
 arch/arm/mach-davinci/board-dm355-leopard.c    |    6 +---
 arch/arm/mach-davinci/board-dm365-evm.c        |    6 +---
 arch/arm/mach-davinci/board-dm644x-evm.c       |    6 +---
 arch/arm/mach-davinci/board-dm646x-evm.c       |    6 +---
 arch/arm/mach-davinci/board-mityomapl138.c     |    6 +---
 arch/arm/mach-davinci/board-neuros-osd2.c      |    6 +---
 arch/arm/mach-davinci/board-omapl138-hawk.c    |    6 +---
 arch/arm/mach-davinci/board-sffsdr.c           |    7 +---
 arch/arm/mach-davinci/da830.c                  |    1 -
 arch/arm/mach-davinci/da850.c                  |    1 -
 arch/arm/mach-davinci/davinci.h                |    5 +++
 arch/arm/mach-davinci/devices-tnetv107x.c      |    2 +-
 arch/arm/mach-davinci/dm355.c                  |    3 +-
 arch/arm/mach-davinci/dm365.c                  |    3 +-
 arch/arm/mach-davinci/dm644x.c                 |    3 +-
 arch/arm/mach-davinci/dm646x.c                 |    3 +-
 arch/arm/mach-davinci/include/mach/common.h    |    1 -
 arch/arm/mach-davinci/include/mach/serial.h    |   10 ++----
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    1 -
 arch/arm/mach-davinci/serial.c                 |   47 +++++++-----------------
 23 files changed, 39 insertions(+), 108 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 1332de8..c4bdc0a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -185,10 +185,6 @@ static __init void da830_evm_usb_init(void)
 			   __func__, ret);
 }
 
-static struct davinci_uart_config da830_evm_uart_config __initdata = {
-	.enabled_uarts = 0x7,
-};
-
 static const short da830_evm_mcasp1_pins[] = {
 	DA830_AHCLKX1, DA830_ACLKX1, DA830_AFSX1, DA830_AHCLKR1, DA830_AFSR1,
 	DA830_AMUTE1, DA830_AXR1_0, DA830_AXR1_1, DA830_AXR1_2, DA830_AXR1_5,
@@ -630,7 +626,7 @@ static __init void da830_evm_init(void)
 		pr_warning("da830_evm_init: watchdog registration failed: %d\n",
 				ret);
 
-	davinci_serial_init(&da830_evm_uart_config);
+	davinci_serial_init(da8xx_serial_device);
 	i2c_register_board_info(1, da830_evm_i2c_devices,
 			ARRAY_SIZE(da830_evm_i2c_devices));
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 8a24b6c..9ac76ee 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -746,10 +746,6 @@ static struct davinci_i2c_platform_data da850_evm_i2c_0_pdata = {
 	.bus_delay	= 0,	/* usec */
 };
 
-static struct davinci_uart_config da850_evm_uart_config __initdata = {
-	.enabled_uarts = 0x7,
-};
-
 /* davinci da850 evm audio machine driver */
 static u8 da850_iis_serializer_direction[] = {
 	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
@@ -1495,7 +1491,7 @@ static __init void da850_evm_init(void)
 				__func__, ret);
 	}
 
-	davinci_serial_init(&da850_evm_uart_config);
+	davinci_serial_init(da8xx_serial_device);
 
 	i2c_register_board_info(1, da850_evm_i2c_devices,
 			ARRAY_SIZE(da850_evm_i2c_devices));
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index c2a0a67..42b23a3 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -314,10 +314,6 @@ static struct platform_device *davinci_evm_devices[] __initdata = {
 	&davinci_nand_device,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 static void __init dm355_evm_map_io(void)
 {
 	dm355_init();
@@ -393,7 +389,7 @@ static __init void dm355_evm_init(void)
 	platform_add_devices(davinci_evm_devices,
 			     ARRAY_SIZE(davinci_evm_devices));
 	evm_init_i2c();
-	davinci_serial_init(&uart_config);
+	davinci_serial_init(dm355_serial_device);
 
 	/* NOTE:  NAND flash timings set by the UBL are slower than
 	 * needed by MT29F16G08FAA chips ... EMIF.A1CR is 0x40400204
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index dff4ddc..d9eb1c9 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -172,10 +172,6 @@ static struct platform_device *davinci_leopard_devices[] __initdata = {
 	&davinci_nand_device,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 static void __init dm355_leopard_map_io(void)
 {
 	dm355_init();
@@ -251,7 +247,7 @@ static __init void dm355_leopard_init(void)
 	platform_add_devices(davinci_leopard_devices,
 			     ARRAY_SIZE(davinci_leopard_devices));
 	leopard_init_i2c();
-	davinci_serial_init(&uart_config);
+	davinci_serial_init(dm355_serial_device);
 
 	/* NOTE:  NAND flash timings set by the UBL are slower than
 	 * needed by MT29F16G08FAA chips ... EMIF.A1CR is 0x40400204
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index fd38c8d..5f1ec9d 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -719,10 +719,6 @@ fail:
 	/* REVISIT export switches: NTSC/PAL (SW5.6), EXTRA1 (SW5.2), etc */
 }
 
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 static void __init dm365_evm_map_io(void)
 {
 	dm365_init();
@@ -749,7 +745,7 @@ static struct spi_board_info dm365_evm_spi_info[] __initconst = {
 static __init void dm365_evm_init(void)
 {
 	evm_init_i2c();
-	davinci_serial_init(&uart_config);
+	davinci_serial_init(dm365_serial_device);
 
 	dm365evm_emac_configure();
 	dm365evm_mmc_configure();
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index a33686a..462812b 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -726,10 +726,6 @@ static struct platform_device *davinci_evm_devices[] __initdata = {
 	&rtc_dev,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 static void __init
 davinci_evm_map_io(void)
 {
@@ -791,7 +787,7 @@ static __init void davinci_evm_init(void)
 	davinci_setup_mmc(0, &dm6446evm_mmc_config);
 	dm644x_init_video(&dm644xevm_capture_cfg, &dm644xevm_display_cfg);
 
-	davinci_serial_init(&uart_config);
+	davinci_serial_init(dm644x_serial_device);
 	dm644x_init_asp(&dm644x_evm_snd_data);
 
 	/* irlml6401 switches over 1A, in under 8 msec */
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index fbb8e5a..734cc02 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -749,10 +749,6 @@ static void __init davinci_map_io(void)
 	cdce_clk_init();
 }
 
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 #define DM646X_EVM_PHY_ID		"davinci_mdio-0:01"
 /*
  * The following EDMA channels/slots are not being used by drivers (for
@@ -792,7 +788,7 @@ static __init void evm_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	evm_init_i2c();
-	davinci_serial_init(&uart_config);
+	davinci_serial_init(dm646x_serial_device);
 	dm646x_init_mcasp0(&dm646x_evm_snd_data[0]);
 	dm646x_init_mcasp1(&dm646x_evm_snd_data[1]);
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 9549d53..cd0f587 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -434,10 +434,6 @@ static void __init mityomapl138_setup_nand(void)
 				 ARRAY_SIZE(mityomapl138_devices));
 }
 
-static struct davinci_uart_config mityomapl138_uart_config __initdata = {
-	.enabled_uarts = 0x7,
-};
-
 static const short mityomap_mii_pins[] = {
 	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
 	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
@@ -517,7 +513,7 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warning("watchdog registration failed: %d\n", ret);
 
-	davinci_serial_init(&mityomapl138_uart_config);
+	davinci_serial_init(da8xx_serial_device);
 
 	ret = da8xx_register_i2c(0, &mityomap_i2c_0_pdata);
 	if (ret)
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 2bc112a..8e156e0 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -153,10 +153,6 @@ static struct platform_device *davinci_ntosd2_devices[] __initdata = {
 	&ntosd2_leds_dev,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 static void __init davinci_ntosd2_map_io(void)
 {
 	dm644x_init();
@@ -197,7 +193,7 @@ static __init void davinci_ntosd2_init(void)
 	platform_add_devices(davinci_ntosd2_devices,
 				ARRAY_SIZE(davinci_ntosd2_devices));
 
-	davinci_serial_init(&uart_config);
+	davinci_serial_init(dm644x_serial_device);
 	dm644x_init_asp(&dm644x_ntosd2_snd_data);
 
 	soc_info->emac_pdata->phy_id = NEUROS_OSD2_PHY_ID;
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index b8c20de..ab98c75 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -286,15 +286,11 @@ usb11_setup_oc_fail:
 	gpio_free(DA850_USB1_VBUS_PIN);
 }
 
-static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
-	.enabled_uarts = 0x7,
-};
-
 static __init void omapl138_hawk_init(void)
 {
 	int ret;
 
-	davinci_serial_init(&omapl138_hawk_uart_config);
+	davinci_serial_init(da8xx_serial_device);
 
 	omapl138_hawk_config_emac();
 
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 739be7e..96ca11b 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -44,6 +44,7 @@
 #include "davinci.h"
 
 #define SFFSDR_PHY_ID		"davinci_mdio-0:01"
+
 static struct mtd_partition davinci_sffsdr_nandflash_partition[] = {
 	/* U-Boot Environment: Block 0
 	 * UBL:                Block 1
@@ -125,10 +126,6 @@ static struct platform_device *davinci_sffsdr_devices[] __initdata = {
 	&davinci_sffsdr_nandflash_device,
 };
 
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 static void __init davinci_sffsdr_map_io(void)
 {
 	dm644x_init();
@@ -141,7 +138,7 @@ static __init void davinci_sffsdr_init(void)
 	platform_add_devices(davinci_sffsdr_devices,
 			     ARRAY_SIZE(davinci_sffsdr_devices));
 	sffsdr_init_i2c();
-	davinci_serial_init(&uart_config);
+	davinci_serial_init(dm644x_serial_device);
 	soc_info->emac_pdata->phy_id = SFFSDR_PHY_ID;
 	davinci_setup_usb(0, 0); /* We support only peripheral mode. */
 
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index a3ffd52..111613b 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1199,7 +1199,6 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.gpio_base		= DA8XX_GPIO_BASE,
 	.gpio_num		= 128,
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
-	.serial_dev		= da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 7ce691c..b1d56e5 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1301,7 +1301,6 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_base		= DA8XX_GPIO_BASE,
 	.gpio_num		= 144,
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
-	.serial_dev		= da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 1ab3df4..d6049e8 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -106,4 +106,9 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv);
 void dm646x_video_init(void);
 void dm646x_setup_vpif(struct vpif_display_config *,
 		       struct vpif_capture_config *);
+
+extern struct platform_device dm365_serial_device[];
+extern struct platform_device dm355_serial_device[];
+extern struct platform_device dm644x_serial_device[];
+extern struct platform_device dm646x_serial_device[];
 #endif /*__DAVINCI_H */
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index d2d8db0..8101910 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -410,7 +410,7 @@ void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 	platform_device_register(&tsc_device);
 
 	if (info->serial_config)
-		davinci_serial_init(info->serial_config);
+		davinci_serial_init(tnetv107x_serial_device);
 
 	for (i = 0; i < 2; i++)
 		if (info->mmc_config[i]) {
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 1078cd6..b86e265 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -962,7 +962,7 @@ static struct plat_serial8250_port dm355_serial2_platform_data[] = {
 	}
 };
 
-static struct platform_device dm355_serial_device[] = {
+struct platform_device dm355_serial_device[] = {
 	{
 		.name			= "serial8250",
 		.id			= PLAT8250_DEV_PLATFORM,
@@ -1009,7 +1009,6 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM355_GPIOBNK0,
-	.serial_dev		= dm355_serial_device,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 6a78856..a34ec22 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1068,7 +1068,7 @@ static struct plat_serial8250_port dm365_serial1_platform_data[] = {
 	}
 };
 
-static struct platform_device dm365_serial_device[] = {
+struct platform_device dm365_serial_device[] = {
 	{
 		.name			= "serial8250",
 		.id			= PLAT8250_DEV_PLATFORM,
@@ -1109,7 +1109,6 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM365_GPIO0,
 	.gpio_unbanked		= 8,	/* really 16 ... skip muxed GPIOs */
-	.serial_dev		= dm365_serial_device,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 1129ff1..8428f61 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -853,7 +853,7 @@ static struct plat_serial8250_port dm644x_serial2_platform_data[] = {
 	}
 };
 
-static struct platform_device dm644x_serial_device[] = {
+struct platform_device dm644x_serial_device[] = {
 	{
 		.name			= "serial8250",
 		.id			= PLAT8250_DEV_PLATFORM,
@@ -900,7 +900,6 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 71,
 	.gpio_irq		= IRQ_GPIOBNK0,
-	.serial_dev		= dm644x_serial_device,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index d3fd760..3e44a97 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -830,7 +830,7 @@ static struct plat_serial8250_port dm646x_serial2_platform_data[] = {
 	}
 };
 
-static struct platform_device dm646x_serial_device[] = {
+struct platform_device dm646x_serial_device[] = {
 	{
 		.name			= "serial8250",
 		.id			= PLAT8250_DEV_PLATFORM,
@@ -877,7 +877,6 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 43, /* Only 33 usable */
 	.gpio_irq		= IRQ_DM646X_GPIOBNK0,
-	.serial_dev		= dm646x_serial_device,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b124b77..7f5a2e9 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -71,7 +71,6 @@ struct davinci_soc_info {
 	unsigned			gpio_unbanked;
 	struct davinci_gpio_controller	*gpio_ctlrs;
 	int				gpio_ctlrs_num;
-	struct platform_device		*serial_dev;
 	struct emac_platform_data	*emac_pdata;
 	dma_addr_t			sram_dma;
 	unsigned			sram_len;
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index 62ad300..52b8571 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -15,6 +15,8 @@
 
 #include <mach/hardware.h>
 
+#include <linux/platform_device.h>
+
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
 #define DAVINCI_UART2_BASE	(IO_PHYS + 0x20800)
@@ -37,13 +39,7 @@
 #define UART_DM646X_SCR_TX_WATERMARK	0x08
 
 #ifndef __ASSEMBLY__
-struct davinci_uart_config {
-	/* Bit field of UARTs present; bit 0 --> UART0 */
-	unsigned int enabled_uarts;
-};
-
-extern int davinci_serial_init(struct davinci_uart_config *);
-extern int davinci_serial_setup_clk(unsigned instance, unsigned int *rate);
+extern int davinci_serial_init(struct platform_device *);
 #endif
 
 #endif /* __ASM_ARCH_SERIAL_H */
diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index 07948a5..c68c7a9 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -41,7 +41,6 @@
 #include <mach/serial.h>
 
 struct tnetv107x_device_info {
-	struct davinci_uart_config	*serial_config;
 	struct davinci_mmc_config	*mmc_config[2];  /* 2 controllers */
 	struct davinci_nand_pdata	*nand_config[4]; /* 4 chipsels */
 	struct matrix_keypad_platform_data *keypad_config;
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 57e6150..5e93a73 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -70,54 +70,35 @@ static void __init davinci_serial_reset(struct plat_serial8250_port *p)
 				 UART_DM646X_SCR_TX_WATERMARK);
 }
 
-/* Enable UART clock and obtain its rate */
-int __init davinci_serial_setup_clk(unsigned instance, unsigned int *rate)
-{
-	char name[16];
-	struct clk *clk;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	struct device *dev = &soc_info->serial_dev[instance].dev;
-
-	sprintf(name, "uart%d", instance);
-	clk = clk_get(dev, name);
-	if (IS_ERR(clk)) {
-		pr_err("%s:%d: failed to get UART%d clock\n",
-					__func__, __LINE__, instance);
-		return PTR_ERR(clk);
-	}
-
-	clk_prepare_enable(clk);
-
-	if (rate)
-		*rate = clk_get_rate(clk);
-
-	return 0;
-}
-
-int __init davinci_serial_init(struct davinci_uart_config *info)
+int __init davinci_serial_init(struct platform_device *serial_dev)
 {
 	int i, ret = 0;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	struct device *dev;
 	struct plat_serial8250_port *p;
+	struct clk *clk;
 
 	/*
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on if not needed.
 	 */
-	for (i = 0; soc_info->serial_dev[i].dev.platform_data != NULL; i++) {
-		dev = &soc_info->serial_dev[i].dev;
+	for (i = 0; serial_dev[i].dev.platform_data != NULL; i++) {
+		dev = &serial_dev[i].dev;
 		p = dev->platform_data;
-		if (!(info->enabled_uarts & (1 << i)))
-			continue;
 
-		ret = platform_device_register(&soc_info->serial_dev[i]);
+		ret = platform_device_register(&serial_dev[i]);
 		if (ret)
 			continue;
 
-		ret = davinci_serial_setup_clk(i, &p->uartclk);
-		if (ret)
+		clk = clk_get(dev, NULL);
+		if (IS_ERR(clk)) {
+			pr_err("%s:%d: failed to get UART%d clock\n",
+			       __func__, __LINE__, i);
 			continue;
+		}
+
+		clk_prepare_enable(clk);
+
+		p->uartclk = clk_get_rate(clk);
 
 		if (!p->membase && p->mapbase) {
 			p->membase = ioremap(p->mapbase, SZ_4K);
-- 
1.7.4.1

