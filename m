From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 6/9] arm: samsung: register uart clocks to clock lookup list
Date: Tue, 27 Sep 2011 00:37:15 +0530
Message-ID: <1317064038-32428-7-git-send-email-thomas.abraham@linaro.org>
References: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-serial@vger.kernel.org

Samsung uart driver lookups the clock using the connectio id
'clk_uart_baud'. The uart clocks are reorganized to register them
with the lookup name as required by the uart driver.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/clock.c         |  106 ++++++++++++++++++++------------
 arch/arm/mach-exynos4/init.c          |    2 +-
 arch/arm/mach-s3c2410/s3c2410.c       |    6 ++
 arch/arm/mach-s3c2412/clock.c         |    7 ++
 arch/arm/mach-s3c2440/clock.c         |    7 ++
 arch/arm/mach-s3c64xx/clock.c         |   37 ++++++++---
 arch/arm/mach-s5p64x0/clock-s5p6440.c |   32 +++++++---
 arch/arm/mach-s5p64x0/clock-s5p6450.c |   32 +++++++---
 arch/arm/mach-s5pc100/clock.c         |   33 +++++++---
 arch/arm/mach-s5pv210/clock.c         |  107 ++++++++++++++++++++------------
 arch/arm/plat-s3c24xx/s3c2443-clock.c |   22 +++++--
 11 files changed, 265 insertions(+), 126 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index da9567a..81e2c01 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1014,46 +1014,6 @@ static struct clksrc_clk clk_dout_mmc4 = {
 
 static struct clksrc_clk clksrcs[] = {
 	{
-		.clk	= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.0",
-			.enable		= exynos4_clksrc_mask_peril0_ctrl,
-			.ctrlbit	= (1 << 0),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.1",
-			.enable		= exynos4_clksrc_mask_peril0_ctrl,
-			.ctrlbit	= (1 << 4),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 4, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 4, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.2",
-			.enable		= exynos4_clksrc_mask_peril0_ctrl,
-			.ctrlbit	= (1 << 8),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 8, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 8, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.3",
-			.enable		= exynos4_clksrc_mask_peril0_ctrl,
-			.ctrlbit	= (1 << 12),
-		},
-		.sources = &clkset_group,
-		.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 12, .size = 4 },
-		.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 12, .size = 4 },
-	}, {
 		.clk		= {
 			.name		= "sclk_pwm",
 			.enable		= exynos4_clksrc_mask_peril0_ctrl,
@@ -1244,6 +1204,54 @@ static struct clksrc_clk clksrcs[] = {
 	}
 };
 
+static struct clksrc_clk clk_sclk_uart0 = {
+	.clk	= {
+		.name		= "uclk1",
+		.devname	= "exynos4210-uart.0",
+		.enable		= exynos4_clksrc_mask_peril0_ctrl,
+		.ctrlbit	= (1 << 0),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 0, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_uart1 = {
+	.clk		= {
+		.name		= "uclk1",
+		.devname	= "exynos4210-uart.1",
+		.enable		= exynos4_clksrc_mask_peril0_ctrl,
+		.ctrlbit	= (1 << 4),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 4, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_uart2 = {
+	.clk		= {
+		.name		= "uclk1",
+		.devname	= "exynos4210-uart.2",
+		.enable		= exynos4_clksrc_mask_peril0_ctrl,
+		.ctrlbit	= (1 << 8),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 8, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_uart3 = {
+	.clk		= {
+		.name		= "uclk1",
+		.devname	= "exynos4210-uart.3",
+		.enable		= exynos4_clksrc_mask_peril0_ctrl,
+		.ctrlbit	= (1 << 12),
+	},
+	.sources = &clkset_group,
+	.reg_src = { .reg = S5P_CLKSRC_PERIL0, .shift = 12, .size = 4 },
+	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 12, .size = 4 },
+};
+
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1278,6 +1286,20 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_mfc1,
 };
 
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_uart0,
+	&clk_sclk_uart1,
+	&clk_sclk_uart2,
+	&clk_sclk_uart3,
+};
+
+static struct clk_lookup exynos4_clk_lookup[] = {
+	CLKDEV_INIT("exynos4210-uart.0", "clk_uart_baud0", &clk_sclk_uart0.clk),
+	CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_sclk_uart1.clk),
+	CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_sclk_uart2.clk),
+	CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_sclk_uart3.clk),
+};
+
 static int xtal_rate;
 
 static unsigned long exynos4_fout_apll_get_rate(struct clk *clk)
@@ -1485,11 +1507,15 @@ void __init exynos4_register_clocks(void)
 	for (ptr = 0; ptr < ARRAY_SIZE(sclk_tv); ptr++)
 		s3c_register_clksrc(sclk_tv[ptr], 1);
 
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	clkdev_add_table(exynos4_clk_lookup, ARRAY_SIZE(exynos4_clk_lookup));
 
 	register_syscore_ops(&exynos4_clock_syscore_ops);
 	s3c24xx_register_clock(&dummy_apb_pclk);
diff --git a/arch/arm/mach-exynos4/init.c b/arch/arm/mach-exynos4/init.c
index 3c9590b..5b35978 100644
--- a/arch/arm/mach-exynos4/init.c
+++ b/arch/arm/mach-exynos4/init.c
@@ -23,5 +23,5 @@ void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	for (ucnt = 0; ucnt < no; ucnt++, tcfg++)
 		tcfg->has_fracval = 1;
 
-	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
+	s3c24xx_init_uartdevs("exynos4210-uart", s5p_uart_resources, cfg, no);
 }
diff --git a/arch/arm/mach-s3c2410/s3c2410.c b/arch/arm/mach-s3c2410/s3c2410.c
index a99c2f4..ffec01c 100644
--- a/arch/arm/mach-s3c2410/s3c2410.c
+++ b/arch/arm/mach-s3c2410/s3c2410.c
@@ -123,12 +123,18 @@ static struct clk s3c2410_armclk = {
 	.id	= -1,
 };
 
+static struct clk_lookup s3c2410_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud0", &clk_p),
+	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
+};
+
 void __init s3c2410_init_clocks(int xtal)
 {
 	s3c24xx_register_baseclocks(xtal);
 	s3c2410_setup_clocks();
 	s3c2410_baseclk_add();
 	s3c24xx_register_clock(&s3c2410_armclk);
+	clkdev_add_table(s3c2410_clk_lookup, ARRAY_SIZE(s3c2410_clk_lookup));
 }
 
 struct sysdev_class s3c2410_sysclass = {
diff --git a/arch/arm/mach-s3c2412/clock.c b/arch/arm/mach-s3c2412/clock.c
index 140711d..cd50291 100644
--- a/arch/arm/mach-s3c2412/clock.c
+++ b/arch/arm/mach-s3c2412/clock.c
@@ -659,6 +659,12 @@ static struct clk *clks[] __initdata = {
 	&clk_armclk,
 };
 
+static struct clk_lookup s3c2412_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
+	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
+	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_usysclk),
+};
+
 int __init s3c2412_baseclk_add(void)
 {
 	unsigned long clkcon  = __raw_readl(S3C2410_CLKCON);
@@ -751,6 +757,7 @@ int __init s3c2412_baseclk_add(void)
 		s3c2412_clkcon_enable(clkp, 0);
 	}
 
+	clkdev_add_table(s3c2412_clk_lookup, ARRAY_SIZE(s3c2412_clk_lookup));
 	s3c_pwmclk_init();
 	return 0;
 }
diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index f85853c..c9879af 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -144,6 +144,12 @@ static struct clk s3c2440_clk_fclk_n = {
 	},
 };
 
+static struct clk_lookup s3c2440_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
+	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
+	CLKDEV_INIT(NULL, "clk_uart_baud3", &s3c2440_clk_fclk_n),
+};
+
 static int s3c2440_clk_add(struct sys_device *sysdev)
 {
 	struct clk *clock_upll;
@@ -167,6 +173,7 @@ static int s3c2440_clk_add(struct sys_device *sysdev)
 	s3c24xx_register_clock(&s3c2440_clk_ac97);
 	s3c24xx_register_clock(&s3c2440_clk_cam);
 	s3c24xx_register_clock(&s3c2440_clk_cam_upll);
+	clkdev_add_table(s3c2440_clk_lookup, ARRAY_SIZE(s3c2440_clk_lookup));
 
 	clk_disable(&s3c2440_clk_ac97);
 	clk_disable(&s3c2440_clk_cam);
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 872e683..4d1f08e 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -617,16 +617,6 @@ static struct clksrc_clk clksrcs[] = {
 		.sources	= &clkset_uhost,
 	}, {
 		.clk	= {
-			.name		= "uclk1",
-			.ctrlbit        = S3C_CLKCON_SCLK_UART,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 13, .size = 1  },
-		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 16, .size = 4  },
-		.sources	= &clkset_uart,
-	}, {
-/* Where does UCLK0 come from? */
-		.clk	= {
 			.name		= "spi-bus",
 			.devname	= "s3c64xx-spi.0",
 			.ctrlbit        = S3C_CLKCON_SCLK_SPI0,
@@ -695,6 +685,18 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+/* Where does UCLK0 come from? */
+static struct clksrc_clk clk_sclk_uclk = {
+	.clk	= {
+		.name		= "uclk1",
+		.ctrlbit        = S3C_CLKCON_SCLK_UART,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 13, .size = 1  },
+	.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 16, .size = 4  },
+	.sources	= &clkset_uart,
+};
+
 /* Clock initialisation code */
 
 static struct clksrc_clk *init_parents[] = {
@@ -703,6 +705,15 @@ static struct clksrc_clk *init_parents[] = {
 	&clk_mout_mpll,
 };
 
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_uclk,
+};
+
+static struct clk_lookup s3c64xx_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
+	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
+};
+
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
 
 void __init_or_cpufreq s3c6400_setup_clocks(void)
@@ -810,6 +821,8 @@ static struct clk *clks[] __initdata = {
 void __init s3c64xx_register_clocks(unsigned long xtal, 
 				    unsigned armclk_divlimit)
 {
+	unsigned int cnt;
+
 	armclk_mask = armclk_divlimit;
 
 	s3c24xx_register_baseclocks(xtal);
@@ -822,5 +835,9 @@ void __init s3c64xx_register_clocks(unsigned long xtal,
 
 	s3c24xx_register_clocks(clks1, ARRAY_SIZE(clks1));
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+	for (cnt = 0; cnt < ARRAY_SIZE(clksrc_cdev); cnt++)
+		s3c_register_clksrc(clksrc_cdev[cnt], 1);
+	clkdev_add_table(s3c64xx_clk_lookup, ARRAY_SIZE(s3c64xx_clk_lookup));
+
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index c54c65d..bfb1917 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -421,15 +421,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
 	}, {
 		.clk	= {
-			.name		= "uclk1",
-			.ctrlbit	= (1 << 5),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 13, .size = 1 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 16, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_spi",
 			.devname	= "s3c64xx-spi.0",
 			.ctrlbit	= (1 << 20),
@@ -487,6 +478,17 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_uclk = {
+	.clk	= {
+		.name		= "uclk1",
+		.ctrlbit	= (1 << 5),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_uart,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 13, .size = 1 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 16, .size = 4 },
+};
+
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -505,6 +507,15 @@ static struct clk dummy_apb_pclk = {
 	.id		= -1,
 };
 
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_uclk,
+};
+
+static struct clk_lookup s5p6440_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
+	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
+};
+
 void __init_or_cpufreq s5p6440_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -583,9 +594,12 @@ void __init s5p6440_register_clocks(void)
 
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	clkdev_add_table(s5p6440_clk_lookup, ARRAY_SIZE(s5p6440_clk_lookup));
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
 
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 2d04abf..d132638 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -443,15 +443,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
 	}, {
 		.clk	= {
-			.name		= "uclk1",
-			.ctrlbit	= (1 << 5),
-			.enable		= s5p64x0_sclk_ctrl,
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 13, .size = 1 },
-		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 16, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_spi",
 			.devname	= "s3c64xx-spi.0",
 			.ctrlbit	= (1 << 20),
@@ -536,6 +527,26 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_uclk = {
+	.clk	= {
+		.name		= "uclk1",
+		.ctrlbit	= (1 << 5),
+		.enable		= s5p64x0_sclk_ctrl,
+	},
+	.sources = &clkset_uart,
+	.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 13, .size = 1 },
+	.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_uclk,
+};
+
+static struct clk_lookup s5p6450_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_pclk_low.clk),
+	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
+};
+
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -634,9 +645,12 @@ void __init s5p6450_register_clocks(void)
 
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	clkdev_add_table(s5p6450_clk_lookup, ARRAY_SIZE(s5p6450_clk_lookup));
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
 
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 8d47709..9d644ec 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -962,16 +962,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 12, .size = 4 },
 	}, {
 		.clk	= {
-			.name		= "uclk1",
-			.ctrlbit	= (1 << 3),
-			.enable		= s5pc100_sclk0_ctrl,
-
-		},
-		.sources = &clk_src_group2,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 0, .size = 1 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_mixer",
 			.ctrlbit	= (1 << 6),
 			.enable		= s5pc100_sclk0_ctrl,
@@ -1098,6 +1088,17 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_uart = {
+	.clk	= {
+		.name		= "uclk1",
+		.ctrlbit	= (1 << 3),
+		.enable		= s5pc100_sclk0_ctrl,
+	},
+	.sources = &clk_src_group2,
+	.reg_src = { .reg = S5P_CLK_SRC1, .shift = 0, .size = 1 },
+	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
+};
+
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1127,6 +1128,10 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_spdif,
 };
 
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_uart,
+};
+
 void __init_or_cpufreq s5pc100_setup_clocks(void)
 {
 	unsigned long xtal;
@@ -1266,6 +1271,11 @@ static struct clk *clks[] __initdata = {
 	&clk_pcmcdclk1,
 };
 
+static struct clk_lookup s5pc100_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
+	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uart.clk),
+};
+
 void __init s5pc100_register_clocks(void)
 {
 	int ptr;
@@ -1277,9 +1287,12 @@ void __init s5pc100_register_clocks(void)
 
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	clkdev_add_table(s5pc100_clk_lookup, ARRAY_SIZE(s5pc100_clk_lookup));
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
 
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index ad553ee..bedb9c5 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -809,46 +809,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV6, .shift = 12, .size = 3 },
 	}, {
 		.clk	= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.0",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 12),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.1",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 13),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 20, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.2",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 14),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 24, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 24, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "uclk1",
-			.devname	= "s5pv210-uart.3",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 15),
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 28, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 28, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_fimc",
 			.devname	= "s5pv210-fimc.0",
 			.enable		= s5pv210_clk_mask1_ctrl,
@@ -1024,6 +984,61 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_uart0 = {
+	.clk	= {
+		.name		= "uclk1",
+		.devname	= "s5pv210-uart.0",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 12),
+	},
+	.sources = &clkset_uart,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 16, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_uart1 = {
+	.clk		= {
+		.name		= "uclk1",
+		.devname	= "s5pv210-uart.1",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 13),
+	},
+	.sources = &clkset_uart,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 20, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_uart2 = {
+	.clk		= {
+		.name		= "uclk1",
+		.devname	= "s5pv210-uart.2",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 14),
+	},
+	.sources = &clkset_uart,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 24, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 24, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_uart3	= {
+	.clk		= {
+		.name		= "uclk1",
+		.devname	= "s5pv210-uart.3",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 15),
+	},
+	.sources = &clkset_uart,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 28, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 28, .size = 4 },
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_uart0,
+	&clk_sclk_uart1,
+	&clk_sclk_uart2,
+	&clk_sclk_uart3,
+};
+
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1263,6 +1278,14 @@ static struct clk *clks[] __initdata = {
 	&clk_pcmcdclk2,
 };
 
+static struct clk_lookup s5pv210_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud0", &clk_p),
+	CLKDEV_INIT("s5pv210-uart.0", "clk_uart_baud1", &clk_sclk_uart0.clk),
+	CLKDEV_INIT("s5pv210-uart.1", "clk_uart_baud1", &clk_sclk_uart1.clk),
+	CLKDEV_INIT("s5pv210-uart.2", "clk_uart_baud1", &clk_sclk_uart2.clk),
+	CLKDEV_INIT("s5pv210-uart.3", "clk_uart_baud1", &clk_sclk_uart3.clk),
+};
+
 void __init s5pv210_register_clocks(void)
 {
 	int ptr;
@@ -1275,11 +1298,15 @@ void __init s5pv210_register_clocks(void)
 	for (ptr = 0; ptr < ARRAY_SIZE(sclk_tv); ptr++)
 		s3c_register_clksrc(sclk_tv[ptr], 1);
 
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	clkdev_add_table(s5pv210_clk_lookup, ARRAY_SIZE(s5pv210_clk_lookup));
 
 	s3c24xx_register_clock(&dummy_apb_pclk);
 	s3c_pwmclk_init();
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 59552c0..3683b63 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -179,13 +179,6 @@ static struct clksrc_clk clk_usb_bus_host = {
 
 static struct clksrc_clk clksrc_clks[] = {
 	{
-		/* ART baud-rate clock sourced from esysclk via a divisor */
-		.clk	= {
-			.name		= "uartclk",
-			.parent		= &clk_esysclk.clk,
-		},
-		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 8 },
-	}, {
 		/* camera interface bus-clock, divided down from esysclk */
 		.clk	= {
 			.name		= "camif-upll",	/* same as 2440 name */
@@ -205,6 +198,14 @@ static struct clksrc_clk clksrc_clks[] = {
 	},
 };
 
+static struct clksrc_clk clk_esys_uart = {
+	/* ART baud-rate clock sourced from esysclk via a divisor */
+	.clk	= {
+		.name		= "uartclk",
+		.parent		= &clk_esysclk.clk,
+	},
+	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 8 },
+};
 
 static struct clk init_clocks_off[] = {
 	{
@@ -412,6 +413,12 @@ static struct clksrc_clk *clksrcs[] __initdata = {
 	&clk_msysclk,
 };
 
+static struct clk_lookup s3c2443_clk_lookup[] = {
+	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
+	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
+	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_esys_uart.clk),
+};
+
 void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 				       fdiv_fn get_fdiv)
 {
@@ -436,6 +443,7 @@ void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 	/* See s3c2443/etc notes on disabling clocks at init time */
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	clkdev_add_table(s3c2443_clk_lookup, ARRAY_SIZE(s3c2443_clk_lookup));
 
 	s3c2443_common_setup_clocks(get_mpll, get_fdiv);
 }
-- 
1.6.6.rc2
