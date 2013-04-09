From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH 1/4] ARM: davinci: uart: move to dev_id based clk_get
Date: Tue, 9 Apr 2013 18:01:01 +0530
Message-ID: <1365510664-1394-2-git-send-email-prakash.pm@ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-serial@vger.kernel.org
Cc: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, "Manjunathappa, Prakash" <prakash.pm@ti.com>, hs@denx.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For modules having single clock, clk_get should be done with dev_id.
But current davinci implementation handles multiple instances
of the UART devices with single platform_device_register. Hence clk_get
is based on con_id rather than dev_id, this is not correct. Do
platform_device_register for each instance and clk_get on dev_id.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da830.c                  |    8 ++--
 arch/arm/mach-davinci/da850.c                  |    8 ++--
 arch/arm/mach-davinci/devices-da8xx.c          |   40 ++++++++++++++++---
 arch/arm/mach-davinci/devices-tnetv107x.c      |   35 ++++++++++++++---
 arch/arm/mach-davinci/dm355.c                  |   48 ++++++++++++++++++-----
 arch/arm/mach-davinci/dm365.c                  |   35 ++++++++++++----
 arch/arm/mach-davinci/dm644x.c                 |   48 ++++++++++++++++++-----
 arch/arm/mach-davinci/dm646x.c                 |   49 +++++++++++++++++++-----
 arch/arm/mach-davinci/include/mach/da8xx.h     |    2 +-
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +-
 arch/arm/mach-davinci/serial.c                 |   19 ++++++---
 arch/arm/mach-davinci/tnetv107x.c              |    8 ++--
 12 files changed, 230 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 678a54a..4a13ac9d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -395,9 +395,9 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"tptc0",	&tptc0_clk),
 	CLK(NULL,		"tptc1",	&tptc1_clk),
 	CLK("davinci_mmc.0",	NULL,		&mmcsd_clk),
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
index 0c4a26d..8c041e4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -408,9 +408,9 @@ static struct clk_lookup da850_clks[] = {
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
@@ -1255,7 +1255,7 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_base		= DA8XX_GPIO_BASE,
 	.gpio_num		= 144,
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
-	.serial_dev		= &da8xx_serial_device,
+	.serial_dev		= da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fc50243..eec7132 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -67,7 +67,7 @@
 void __iomem *da8xx_syscfg0_base;
 void __iomem *da8xx_syscfg1_base;
 
-static struct plat_serial8250_port da8xx_serial_pdata[] = {
+static struct plat_serial8250_port da8xx_serial_pdata0[] = {
 	{
 		.mapbase	= DA8XX_UART0_BASE,
 		.irq		= IRQ_DA8XX_UARTINT0,
@@ -77,6 +77,11 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags	= 0,
+	},
+};
+static struct plat_serial8250_port da8xx_serial_pdata1[] = {
+	{
 		.mapbase	= DA8XX_UART1_BASE,
 		.irq		= IRQ_DA8XX_UARTINT1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -85,6 +90,11 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags	= 0,
+	},
+};
+static struct plat_serial8250_port da8xx_serial_pdata2[] = {
+	{
 		.mapbase	= DA8XX_UART2_BASE,
 		.irq		= IRQ_DA8XX_UARTINT2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -97,11 +107,29 @@ static struct plat_serial8250_port da8xx_serial_pdata[] = {
 	},
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
+			.platform_data	= da8xx_serial_pdata0,
+		},
+	},
+	{
+		.name	= "serial8250",
+		.id	= PLAT8250_DEV_PLATFORM1,
+		.dev	= {
+			.platform_data	= da8xx_serial_pdata1,
+		},
+	},
+	{
+		.name	= "serial8250",
+		.id	= PLAT8250_DEV_PLATFORM2,
+		.dev	= {
+			.platform_data	= da8xx_serial_pdata2,
+		},
+	},
+	{
 	},
 };
 
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 773ab07..665748f 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -126,7 +126,7 @@ static struct platform_device edma_device = {
 	.dev.platform_data = tnetv107x_edma_info,
 };
 
-static struct plat_serial8250_port serial_data[] = {
+static struct plat_serial8250_port serial_platform_data0[] = {
 	{
 		.mapbase	= TNETV107X_UART0_BASE,
 		.irq		= IRQ_TNETV107X_UART0,
@@ -137,6 +137,11 @@ static struct plat_serial8250_port serial_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port serial_platform_data1[] = {
+	{
 		.mapbase	= TNETV107X_UART1_BASE,
 		.irq		= IRQ_TNETV107X_UART1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -146,6 +151,11 @@ static struct plat_serial8250_port serial_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port serial_platform_data2[] = {
+	{
 		.mapbase	= TNETV107X_UART2_BASE,
 		.irq		= IRQ_TNETV107X_UART2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -155,14 +165,27 @@ static struct plat_serial8250_port serial_data[] = {
 		.regshift	= 2,
 	},
 	{
-		.flags	= 0,
+		.flags		= 0
 	},
 };
 
-struct platform_device tnetv107x_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev.platform_data	= serial_data,
+
+struct platform_device tnetv107x_serial_device[] = {
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM,
+		.dev.platform_data	= serial_platform_data0,
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev.platform_data	= serial_platform_data1,
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev.platform_data	= serial_platform_data2,
+	},
 };
 
 static struct resource mmc0_resources[] = {
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index b49c3b7..844541e 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -355,9 +355,9 @@ static struct clk_lookup dm355_clks[] = {
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
@@ -785,7 +785,7 @@ static struct davinci_timer_info dm355_timer_info = {
 	.clocksource_id	= T0_TOP,
 };
 
-static struct plat_serial8250_port dm355_serial_platform_data[] = {
+static struct plat_serial8250_port dm355_serial_platform_data0[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -795,6 +795,11 @@ static struct plat_serial8250_port dm355_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port dm355_serial_platform_data1[] = {
+	{
 		.mapbase	= DAVINCI_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -803,6 +808,11 @@ static struct plat_serial8250_port dm355_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port dm355_serial_platform_data2[] = {
+	{
 		.mapbase	= DM355_UART2_BASE,
 		.irq		= IRQ_DM355_UARTINT2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -815,11 +825,29 @@ static struct plat_serial8250_port dm355_serial_platform_data[] = {
 	},
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
+			.platform_data	= dm355_serial_platform_data0,
+		},
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm355_serial_platform_data1,
+		},
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev			= {
+			.platform_data	= dm355_serial_platform_data2,
+		},
+	},
+	{
 	},
 };
 
@@ -844,7 +872,7 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM355_GPIOBNK0,
-	.serial_dev		= &dm355_serial_device,
+	.serial_dev		= dm355_serial_device,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 6c39805..5492cbc 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -451,8 +451,8 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "vpss_dac", &vpss_dac_clk),
 	CLK(NULL, "vpss_master", &vpss_master_clk),
 	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
+	CLK("serial8250.0", NULL, &uart0_clk),
+	CLK("serial8250.1", NULL, &uart1_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
 	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
@@ -1037,7 +1037,7 @@ static struct davinci_timer_info dm365_timer_info = {
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
 
-static struct plat_serial8250_port dm365_serial_platform_data[] = {
+static struct plat_serial8250_port dm365_serial_platform_data0[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -1047,6 +1047,11 @@ static struct plat_serial8250_port dm365_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port dm365_serial_platform_data1[] = {
+	{
 		.mapbase	= DM365_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -1059,14 +1064,26 @@ static struct plat_serial8250_port dm365_serial_platform_data[] = {
 	},
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
+			.platform_data	= dm365_serial_platform_data0,
+		},
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm365_serial_platform_data1,
+		},
+	},
+	{
 	},
 };
 
+
 static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.io_desc		= dm365_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm365_io_desc),
@@ -1089,7 +1106,7 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM365_GPIO0,
 	.gpio_unbanked		= 8,	/* really 16 ... skip muxed GPIOs */
-	.serial_dev		= &dm365_serial_device,
+	.serial_dev		= dm365_serial_device,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index db1dd92..8134c47 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -303,9 +303,9 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK(NULL, "vpss_master", &vpss_master_clk),
 	CLK(NULL, "vpss_slave", &vpss_slave_clk),
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
+static struct plat_serial8250_port dm644x_serial_platform_data0[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -823,6 +823,11 @@ static struct plat_serial8250_port dm644x_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port dm644x_serial_platform_data1[] = {
+	{
 		.mapbase	= DAVINCI_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -831,6 +836,11 @@ static struct plat_serial8250_port dm644x_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port dm644x_serial_platform_data2[] = {
+	{
 		.mapbase	= DAVINCI_UART2_BASE,
 		.irq		= IRQ_UARTINT2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -843,11 +853,29 @@ static struct plat_serial8250_port dm644x_serial_platform_data[] = {
 	},
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
+			.platform_data	= dm644x_serial_platform_data0,
+		},
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm644x_serial_platform_data1,
+		},
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev			= {
+			.platform_data	= dm644x_serial_platform_data2,
+		},
+	},
+	{
 	},
 };
 
@@ -872,7 +900,7 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 71,
 	.gpio_irq		= IRQ_GPIOBNK0,
-	.serial_dev		= &dm644x_serial_device,
+	.serial_dev		= dm644x_serial_device,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index ac7b431..0f0cac6 100644
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
+static struct plat_serial8250_port dm646x_serial_platform_data0[] = {
 	{
 		.mapbase	= DAVINCI_UART0_BASE,
 		.irq		= IRQ_UARTINT0,
@@ -800,6 +800,11 @@ static struct plat_serial8250_port dm646x_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port dm646x_serial_platform_data1[] = {
+	{
 		.mapbase	= DAVINCI_UART1_BASE,
 		.irq		= IRQ_UARTINT1,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -808,6 +813,11 @@ static struct plat_serial8250_port dm646x_serial_platform_data[] = {
 		.regshift	= 2,
 	},
 	{
+		.flags		= 0
+	},
+};
+static struct plat_serial8250_port dm646x_serial_platform_data2[] = {
+	{
 		.mapbase	= DAVINCI_UART2_BASE,
 		.irq		= IRQ_DM646X_UARTINT2,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
@@ -820,14 +830,33 @@ static struct plat_serial8250_port dm646x_serial_platform_data[] = {
 	},
 };
 
-static struct platform_device dm646x_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= dm646x_serial_platform_data,
+static struct platform_device dm646x_serial_device[] = {
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM,
+		.dev			= {
+			.platform_data	= dm646x_serial_platform_data0,
+		},
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM1,
+		.dev			= {
+			.platform_data	= dm646x_serial_platform_data1,
+		},
+	},
+	{
+		.name			= "serial8250",
+		.id			= PLAT8250_DEV_PLATFORM2,
+		.dev			= {
+			.platform_data	= dm646x_serial_platform_data2,
+		},
+	},
+	{
 	},
 };
 
+
 static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.io_desc		= dm646x_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm646x_io_desc),
@@ -849,7 +878,7 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.gpio_base		= DAVINCI_GPIO_BASE,
 	.gpio_num		= 43, /* Only 33 usable */
 	.gpio_irq		= IRQ_DM646X_GPIOBNK0,
-	.serial_dev		= &dm646x_serial_device,
+	.serial_dev		= dm646x_serial_device,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index de439b7..9453fd2 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -105,7 +105,7 @@ int __init da850_register_vpif_capture
 			(struct vpif_capture_config *capture_config);
 void da8xx_restart(char mode, const char *cmd);
 
-extern struct platform_device da8xx_serial_device;
+extern struct platform_device da8xx_serial_device[];
 extern struct emac_platform_data da8xx_emac_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
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
index dc1a209..0a3601a 100644
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
 	CLK("davinci_mmc.0",	NULL,			&clk_sdio0),
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
