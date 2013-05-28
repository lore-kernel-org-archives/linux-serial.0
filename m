From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v2 1/5] ARM: davinci: uart: move to devid based clk_get
Date: Tue, 28 May 2013 13:58:02 +0530
Message-ID: <1369729686-6595-2-git-send-email-prakash.pm@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45291 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933390Ab3E1I1H (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 May 2013 04:27:07 -0400
In-Reply-To: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-serial@vger.kernel.org
Cc: nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

For modules having single clock, clk_get should be done with dev_id.
But current davinci implementation handles multiple instances
of the UART devices with single platform_device_register. Hence clk_get
is based on con_id rather than dev_id, this is not correct. Do
platform_device_register for each instance and clk_get on dev_id.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da830.c                  |    8 ++--
 arch/arm/mach-davinci/da850.c                  |    8 ++--
 arch/arm/mach-davinci/devices-da8xx.c          |   41 ++++++++++++++------
 arch/arm/mach-davinci/devices-tnetv107x.c      |   34 ++++++++++++-----
 arch/arm/mach-davinci/dm355.c                  |   49 ++++++++++++++++--------
 arch/arm/mach-davinci/dm365.c                  |   37 +++++++++++-------
 arch/arm/mach-davinci/dm644x.c                 |   49 ++++++++++++++++--------
 arch/arm/mach-davinci/dm646x.c                 |   48 ++++++++++++++++-------
 arch/arm/mach-davinci/include/mach/da8xx.h     |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h    |    4 ++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +-
 arch/arm/mach-davinci/serial.c                 |   19 ++++++---
 arch/arm/mach-davinci/tnetv107x.c              |    8 ++--
 13 files changed, 205 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index abbaf02..a3ffd52 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -395,9 +395,9 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"tptc0",	&tptc0_clk),
 	CLK(NULL,		"tptc1",	&tptc1_clk),
 	CLK("da830-mmc.0",	NULL,		&mmcsd_clk),
-	CLK(NULL,		"uart0",	&uart0_clk),
-	CLK(NULL,		"uart1",	&uart1_clk),
-	CLK(NULL,		"uart2",	&uart2_clk),
+	CLK("serial8250.0",	NULL,		&uart0_clk),
+	CLK("serial8250.1",	NULL,		&uart1_clk),
+	CLK("serial8250.2",	NULL,		&uart2_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK(NULL,		"ecap0",	&ecap0_clk),
@@ -1199,7 +1199,7 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.gpio_base		= DA8XX_GPIO_BASE,
 	.gpio_num		= 128,
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
-	.serial_dev		= &da8xx_serial_device,
+	.serial_dev		= da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 4d69338..7ce691c 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -451,9 +451,9 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"tpcc1",	&tpcc1_clk),
 	CLK(NULL,		"tptc2",	&tptc2_clk),
 	CLK("pruss_uio",	"pruss",	&pruss_clk),
-	CLK(NULL,		"uart0",	&uart0_clk),
-	CLK(NULL,		"uart1",	&uart1_clk),
-	CLK(NULL,		"uart2",	&uart2_clk),
+	CLK("serial8250.0",	NULL,		&uart0_clk),
+	CLK("serial8250.1",	NULL,		&uart1_clk),
+	CLK("serial8250.2",	NULL,		&uart2_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"gpio",		&gpio_clk),
 	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
@@ -1301,7 +1301,7 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_base		= DA8XX_GPIO_BASE,
 	.gpio_num		= 144,
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
-	.serial_dev		= &da8xx_serial_device,
+	.serial_dev		= da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index bf57252..e243d97 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -67,7 +67,7 @@
 void __iomem *da8xx_syscfg0_base;
 void __iomem *da8xx_syscfg1_base;
 
-static struct plat_serial8250_port da8xx_serial_pdata[] = {
+static struct plat_serial8250_port da8xx_serial0_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART0_BASE,
 		.irq		= IRQ_DA8XX_UARTINT0,
@@ -75,7 +75,9 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port da8xx_serial1_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART1_BASE,
 		.irq		= IRQ_DA8XX_UARTINT1,
@@ -83,7 +85,9 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port da8xx_serial2_pdata[] = {
 	{
 		.mapbase	= DA8XX_UART2_BASE,
 		.irq		= IRQ_DA8XX_UARTINT2,
@@ -91,18 +95,31 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
 					UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
-	{
-		.flags	= 0,
-	},
+	}
 };
 
-struct platform_device da8xx_serial_device = {
-	.name	= "serial8250",
-	.id	= PLAT8250_DEV_PLATFORM,
-	.dev	= {
-		.platform_data	= da8xx_serial_pdata,
+struct platform_device da8xx_serial_device[] = {
+	{
+		.name	= "serial8250",
+		.id	= PLAT8250_DEV_PLATFORM,
+		.dev	= {
+			.platform_data	= da8xx_serial0_pdata
+		}
 	},
+	{
+		.name	= "serial8250",
+		.id	= PLAT8250_DEV_PLATFORM1,
+		.dev	= {
+			.platform_data	= da8xx_serial1_pdata
+		}
+	},
+	{
+		.name	= "serial8250",
+		.id	= PLAT8250_DEV_PLATFORM2,
+		.dev	= {
+			.platform_data	= da8xx_serial2_pdata
+		}
+	}
 };
 
 static const s8 da8xx_queue_tc_mapping[][2] = {
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index cfb194d..35e5594 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -126,7 +126,7 @@ static struct platform_device edma_device = {
 	.dev.platform_data = tnetv107x_edma_info,
 };
 
-static struct plat_serial8250_port serial_data[] = {
+static struct plat_serial8250_port serial0_platform_data[] = {
 	{
 		.mapbase	= TNETV107X_UART0_BASE,
 		.irq		= IRQ_TNETV107X_UART0,
@@ -135,7 +135,9 @@ static struct plat_serial8250_port serial_data[] = {
 		.type		= PORT_AR7,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port serial1_platform_data[] = {
 	{
 		.mapbase	= TNETV107X_UART1_BASE,
 		.irq		= IRQ_TNETV107X_UART1,
@@ -144,7 +146,9 @@ static struct plat_serial8250_port serial_data[] = {
 		.type		= PORT_AR7,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port serial2_platform_data[] = {
 	{
 		.mapbase	= TNETV107X_UART2_BASE,
 		.irq		= IRQ_TNETV107X_UART2,
@@ -153,16 +157,26 @@ static struct plat_serial8250_port serial_data[] = {
 		.type		= PORT_AR7,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
+	}
+};
+
+
+struct platform_device tnetv107x_serial_device[] = {
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM,
+		.dev.platform_data	= serial0_platform_data
 	},
 	{
-		.flags	= 0,
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev.platform_data	= serial1_platform_data
 	},
-};
-
-struct platform_device tnetv107x_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev.platform_data	= serial_data,
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev.platform_data	= serial2_platform_data
+	}
 };
 
 static struct resource mmc0_resources[] = {
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a11034a..a7ef0e3 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -357,9 +357,9 @@ static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "clkout3", &clkout3_clk),
 	CLK(NULL, "arm", &arm_clk),
 	CLK(NULL, "mjcp", &mjcp_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
-	CLK(NULL, "uart2", &uart2_clk),
+	CLK("serial8250.0", NULL, &uart0_clk),
+	CLK("serial8250.1", NULL, &uart1_clk),
+	CLK("serial8250.2", NULL, &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("davinci-mcbsp.0", NULL, &asp0_clk),
 	CLK("davinci-mcbsp.1", NULL, &asp1_clk),
@@ -922,7 +922,7 @@ static struct davinci_timer_info dm355_timer_info = {
 	.clocksource_id	= T0_TOP,
 };
 
-static struct plat_serial8250_port dm355_serial_platform_data[] = {
+static struct plat_serial8250_port dm355_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -930,7 +930,9 @@ static struct plat_serial8250_port dm355_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port dm355_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
@@ -938,7 +940,9 @@ static struct plat_serial8250_port dm355_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port dm355_serial2_platform_data[] = {
 	{
 		.mapbase	= DM355_UART2_BASE,
 		.irq		= IRQ_DM355_UARTINT2,
@@ -946,18 +950,31 @@ static struct plat_serial8250_port dm355_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
-	{
-		.flags		= 0
-	},
+	}
 };
 
-static struct platform_device dm355_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= dm355_serial_platform_data,
+static struct platform_device dm355_serial_device[] = {
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM,
+		.dev			= {
+			.platform_data	= dm355_serial0_platform_data
+		}
 	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm355_serial1_platform_data
+		}
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev			= {
+			.platform_data	= dm355_serial2_platform_data
+		}
+	}
 };
 
 static struct davinci_soc_info davinci_soc_info_dm355 = {
@@ -981,7 +998,7 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM355_GPIOBNK0,
-	.serial_dev		= &dm355_serial_device,
+	.serial_dev		= dm355_serial_device,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 40fa4fe..abeac28 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -455,8 +455,8 @@ static struct clk_lookup dm365_clks[] = {
 	CLK("vpss", "master", &vpss_master_clk),
 	CLK("vpss", "slave", &vpss_slave_clk),
 	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
+	CLK("serial8250.0", NULL, &uart0_clk),
+	CLK("serial8250.1", NULL, &uart1_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("da830-mmc.0", NULL, &mmcsd0_clk),
 	CLK("da830-mmc.1", NULL, &mmcsd1_clk),
@@ -1041,7 +1041,7 @@ static struct davinci_timer_info dm365_timer_info = {
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
 
-static struct plat_serial8250_port dm365_serial_platform_data[] = {
+static struct plat_serial8250_port dm365_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -1049,7 +1049,9 @@ static struct plat_serial8250_port dm365_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port dm365_serial1_platform_data[] = {
 	{
 		.mapbase	= DM365_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
@@ -1057,20 +1059,27 @@ static struct plat_serial8250_port dm365_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
-	{
-		.flags		= 0
-	},
+	}
 };
 
-static struct platform_device dm365_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= dm365_serial_platform_data,
+static struct platform_device dm365_serial_device[] = {
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM,
+		.dev			= {
+			.platform_data	= dm365_serial0_platform_data
+		}
 	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm365_serial1_platform_data
+		}
+	}
 };
 
+
 static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.io_desc		= dm365_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm365_io_desc),
@@ -1093,7 +1102,7 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM365_GPIO0,
 	.gpio_unbanked		= 8,	/* really 16 ... skip muxed GPIOs */
-	.serial_dev		= &dm365_serial_device,
+	.serial_dev		= dm365_serial_device,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 4d37d3e..cc68266 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -303,9 +303,9 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK("vpss", "master", &vpss_master_clk),
 	CLK("vpss", "slave", &vpss_slave_clk),
 	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
-	CLK(NULL, "uart2", &uart2_clk),
+	CLK("serial8250.0", NULL, &uart0_clk),
+	CLK("serial8250.1", NULL, &uart1_clk),
+	CLK("serial8250.2", NULL, &uart2_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("palm_bk3710", NULL, &ide_clk),
@@ -813,7 +813,7 @@ static struct davinci_timer_info dm644x_timer_info = {
 	.clocksource_id	= T0_TOP,
 };
 
-static struct plat_serial8250_port dm644x_serial_platform_data[] = {
+static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -821,7 +821,9 @@ static struct plat_serial8250_port dm644x_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port dm644x_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
@@ -829,7 +831,9 @@ static struct plat_serial8250_port dm644x_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port dm644x_serial2_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART2_BASE,
 		.irq		= IRQ_UARTINT2,
@@ -837,18 +841,31 @@ static struct plat_serial8250_port dm644x_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-	},
-	{
-		.flags		= 0
-	},
+	}
 };
 
-static struct platform_device dm644x_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= dm644x_serial_platform_data,
+static struct platform_device dm644x_serial_device[] = {
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM,
+		.dev			= {
+			.platform_data	= dm644x_serial0_platform_data
+		}
 	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm644x_serial1_platform_data
+		}
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev			= {
+			.platform_data	= dm644x_serial2_platform_data
+		}
+	}
 };
 
 static struct davinci_soc_info davinci_soc_info_dm644x = {
@@ -872,7 +889,7 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 71,
 	.gpio_irq		= IRQ_GPIOBNK0,
-	.serial_dev		= &dm644x_serial_device,
+	.serial_dev		= dm644x_serial_device,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index ac7b431..1fec246 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -342,9 +342,9 @@ static struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "edma_tc1", &edma_tc1_clk),
 	CLK(NULL, "edma_tc2", &edma_tc2_clk),
 	CLK(NULL, "edma_tc3", &edma_tc3_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
-	CLK(NULL, "uart2", &uart2_clk),
+	CLK("serial8250.0", NULL, &uart0_clk),
+	CLK("serial8250.1", NULL, &uart1_clk),
+	CLK("serial8250.2", NULL, &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK(NULL, "gpio", &gpio_clk),
 	CLK("davinci-mcasp.0", NULL, &mcasp0_clk),
@@ -790,7 +790,7 @@ static struct davinci_timer_info dm646x_timer_info = {
 	.clocksource_id	= T0_TOP,
 };
 
-static struct plat_serial8250_port dm646x_serial_platform_data[] = {
+static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -798,7 +798,9 @@ static struct plat_serial8250_port dm646x_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port dm646x_serial1_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
@@ -806,7 +808,9 @@ static struct plat_serial8250_port dm646x_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
-	},
+	}
+};
+static struct plat_serial8250_port dm646x_serial2_platform_data[] = {
 	{
 		.mapbase	= DAVINCI_UART2_BASE,
 		.irq		= IRQ_DM646X_UARTINT2,
@@ -814,19 +818,33 @@ static struct plat_serial8250_port dm646x_serial_platform_data[] = {
 				  UPF_IOREMAP,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
+	}
+};
+
+static struct platform_device dm646x_serial_device[] = {
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM,
+		.dev			= {
+			.platform_data	= dm646x_serial0_platform_data
+		}
 	},
 	{
-		.flags		= 0
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm646x_serial1_platform_data
+		}
 	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev			= {
+			.platform_data	= dm646x_serial2_platform_data
+		}
+	}
 };
 
-static struct platform_device dm646x_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= dm646x_serial_platform_data,
-	},
-};
 
 static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.io_desc		= dm646x_io_desc,
@@ -849,7 +867,7 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 43, /* Only 33 usable */
 	.gpio_irq		= IRQ_DM646X_GPIOBNK0,
-	.serial_dev		= &dm646x_serial_device,
+	.serial_dev		= dm646x_serial_device,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 2e1c9ea..71aa7d0 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -110,7 +110,7 @@ void da8xx_restart(char mode, const char *cmd);
 void da8xx_rproc_reserve_cma(void);
 int da8xx_register_rproc(void);
 
-extern struct platform_device da8xx_serial_device;
+extern struct platform_device da8xx_serial_device[];
 extern struct emac_platform_data da8xx_emac_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index 62ad300..34d9877 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -44,6 +44,10 @@ struct davinci_uart_config {
 
 extern int davinci_serial_init(struct davinci_uart_config *);
 extern int davinci_serial_setup_clk(unsigned instance, unsigned int *rate);
+extern struct platform_device dm365_serial_device[];
+extern struct platform_device dm355_serial_device[];
+extern struct platform_device dm644x_serial_device[];
+extern struct platform_device dm646x_serial_device[];
 #endif
 
 #endif /* __ASM_ARCH_SERIAL_H */
diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index 1656a02..07948a5 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -49,7 +49,7 @@ struct tnetv107x_device_info {
 };
 
 extern struct platform_device tnetv107x_wdt_device;
-extern struct platform_device tnetv107x_serial_device;
+extern struct platform_device tnetv107x_serial_device[];
 
 extern void __init tnetv107x_init(void);
 extern void __init tnetv107x_devices_init(struct tnetv107x_device_info *);
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index f262581..57e6150 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -76,7 +76,7 @@ int __init davinci_serial_setup_clk(unsigned instance, unsigned int *rate)
 	char name[16];
 	struct clk *clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	struct device *dev = &soc_info->serial_dev->dev;
+	struct device *dev = &soc_info->serial_dev[instance].dev;
 
 	sprintf(name, "uart%d", instance);
 	clk = clk_get(dev, name);
@@ -96,19 +96,25 @@ int __init davinci_serial_setup_clk(unsigned instance, unsigned int *rate)
 
 int __init davinci_serial_init(struct davinci_uart_config *info)
 {
-	int i, ret;
+	int i, ret = 0;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	struct device *dev = &soc_info->serial_dev->dev;
-	struct plat_serial8250_port *p = dev->platform_data;
+	struct device *dev;
+	struct plat_serial8250_port *p;
 
 	/*
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on if not needed.
 	 */
-	for (i = 0; p->flags; i++, p++) {
+	for (i = 0; soc_info->serial_dev[i].dev.platform_data != NULL; i++) {
+		dev = &soc_info->serial_dev[i].dev;
+		p = dev->platform_data;
 		if (!(info->enabled_uarts & (1 << i)))
 			continue;
 
+		ret = platform_device_register(&soc_info->serial_dev[i]);
+		if (ret)
+			continue;
+
 		ret = davinci_serial_setup_clk(i, &p->uartclk);
 		if (ret)
 			continue;
@@ -125,6 +131,5 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
 		if (p->membase && p->type != PORT_AR7)
 			davinci_serial_reset(p);
 	}
-
-	return platform_device_register(soc_info->serial_dev);
+	return ret;
 }
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 3b2a70d..d8a9516 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -263,7 +263,7 @@ static struct clk_lookup clks[] = {
 	CLK(NULL,		"clk_chipcfg",		&clk_chipcfg),
 	CLK("tnetv107x-ts.0",	NULL,			&clk_tsc),
 	CLK(NULL,		"clk_rom",		&clk_rom),
-	CLK(NULL,		"uart2",		&clk_uart2),
+	CLK("serial8250.2",     NULL,			&clk_uart2),
 	CLK(NULL,		"clk_pktsec",		&clk_pktsec),
 	CLK("tnetv107x-rng.0",	NULL,			&clk_rng),
 	CLK("tnetv107x-pka.0",	NULL,			&clk_pka),
@@ -273,8 +273,8 @@ static struct clk_lookup clks[] = {
 	CLK(NULL,		"clk_gpio",		&clk_gpio),
 	CLK(NULL,		"clk_mdio",		&clk_mdio),
 	CLK("dm6441-mmc.0",	NULL,			&clk_sdio0),
-	CLK(NULL,		"uart0",		&clk_uart0),
-	CLK(NULL,		"uart1",		&clk_uart1),
+	CLK("serial8250.0",	NULL,			&clk_uart0),
+	CLK("serial8250.1",	NULL,			&clk_uart1),
 	CLK(NULL,		"timer0",		&clk_timer0),
 	CLK(NULL,		"timer1",		&clk_timer1),
 	CLK("tnetv107x_wdt.0",	NULL,			&clk_wdt_arm),
@@ -756,7 +756,7 @@ static struct davinci_soc_info tnetv107x_soc_info = {
 	.gpio_type		= GPIO_TYPE_TNETV107X,
 	.gpio_num		= TNETV107X_N_GPIO,
 	.timer_info		= &timer_info,
-	.serial_dev		= &tnetv107x_serial_device,
+	.serial_dev		= tnetv107x_serial_device,
 };
 
 void __init tnetv107x_init(void)
-- 
1.7.4.1

