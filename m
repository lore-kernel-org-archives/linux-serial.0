From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 4/9] serial: samsung: remove struct 's3c24xx_uart_clksrc' and
 all uses of it
Date: Tue, 27 Sep 2011 00:37:13 +0530
Message-ID: <1317064038-32428-5-git-send-email-thomas.abraham@linaro.org>
References: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org, Ramax Lo <ramaxlo@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: linux-serial@vger.kernel.org

With clkdev based clock lookup added to samsung serial driver, the use
of 'struct s3c24xx_uart_clksrc' to supply clock names in platform
data can be removed.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Ramax Lo <ramaxlo@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/init.c                     |   15 +----------
 arch/arm/mach-s3c2410/mach-bast.c                |   22 ---------------
 arch/arm/mach-s3c2410/mach-vr1000.c              |   24 -----------------
 arch/arm/mach-s3c2440/mach-anubis.c              |   22 +--------------
 arch/arm/mach-s3c2440/mach-at2440evb.c           |   22 +--------------
 arch/arm/mach-s3c2440/mach-osiris.c              |   24 ++---------------
 arch/arm/mach-s3c2440/mach-rx1950.c              |   18 ++----------
 arch/arm/mach-s3c2440/mach-rx3715.c              |   19 ++-----------
 arch/arm/mach-s5p64x0/init.c                     |   31 ----------------------
 arch/arm/mach-s5pv210/init.c                     |   19 -------------
 arch/arm/plat-samsung/include/plat/regs-serial.h |   23 ----------------
 drivers/tty/serial/samsung.h                     |    1 -
 12 files changed, 14 insertions(+), 226 deletions(-)

diff --git a/arch/arm/mach-exynos4/init.c b/arch/arm/mach-exynos4/init.c
index a8a83e3..e836c9c 100644
--- a/arch/arm/mach-exynos4/init.c
+++ b/arch/arm/mach-exynos4/init.c
@@ -14,15 +14,6 @@
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
 
-static struct s3c24xx_uart_clksrc exynos4_serial_clocks[] = {
-	[0] = {
-		.name		= "uclk1",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
 /* uart registration process */
 void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
@@ -30,11 +21,7 @@ void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	u32 ucnt;
 
 	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->has_fracval = 1;
-			tcfg->clocks = exynos4_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(exynos4_serial_clocks);
-		}
+		tcfg->has_fracval = 1;
 		tcfg->flags |= NO_NEED_CHECK_CLKSRC;
 	}
 
diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 1e2d536..e92e29b 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -164,22 +164,6 @@ static struct map_desc bast_iodesc[] __initdata = {
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
 #define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
 
-static struct s3c24xx_uart_clksrc bast_serial_clocks[] = {
-	[0] = {
-		.name		= "uclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	}
-};
-
-
 static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
@@ -187,8 +171,6 @@ static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = bast_serial_clocks,
-		.clocks_size = ARRAY_SIZE(bast_serial_clocks),
 	},
 	[1] = {
 		.hwport	     = 1,
@@ -196,8 +178,6 @@ static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = bast_serial_clocks,
-		.clocks_size = ARRAY_SIZE(bast_serial_clocks),
 	},
 	/* port 2 is not actually used */
 	[2] = {
@@ -206,8 +186,6 @@ static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = bast_serial_clocks,
-		.clocks_size = ARRAY_SIZE(bast_serial_clocks),
 	}
 };
 
diff --git a/arch/arm/mach-s3c2410/mach-vr1000.c b/arch/arm/mach-s3c2410/mach-vr1000.c
index 6ccce5a..208d83a 100644
--- a/arch/arm/mach-s3c2410/mach-vr1000.c
+++ b/arch/arm/mach-s3c2410/mach-vr1000.c
@@ -109,23 +109,6 @@ static struct map_desc vr1000_iodesc[] __initdata = {
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
 #define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
 
-/* uart clock source(s) */
-
-static struct s3c24xx_uart_clksrc vr1000_serial_clocks[] = {
-	[0] = {
-		.name		= "uclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0.
-	}
-};
-
 static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
@@ -133,8 +116,6 @@ static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = vr1000_serial_clocks,
-		.clocks_size = ARRAY_SIZE(vr1000_serial_clocks),
 	},
 	[1] = {
 		.hwport	     = 1,
@@ -142,8 +123,6 @@ static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = vr1000_serial_clocks,
-		.clocks_size = ARRAY_SIZE(vr1000_serial_clocks),
 	},
 	/* port 2 is not actually used */
 	[2] = {
@@ -152,9 +131,6 @@ static struct s3c2410_uartcfg vr1000_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = vr1000_serial_clocks,
-		.clocks_size = ARRAY_SIZE(vr1000_serial_clocks),
-
 	}
 };
 
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index d708678..0097585 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -96,22 +96,6 @@ static struct map_desc anubis_iodesc[] __initdata = {
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
 #define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
 
-static struct s3c24xx_uart_clksrc anubis_serial_clocks[] = {
-	[0] = {
-		.name		= "uclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	}
-};
-
-
 static struct s3c2410_uartcfg anubis_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
@@ -119,8 +103,7 @@ static struct s3c2410_uartcfg anubis_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = anubis_serial_clocks,
-		.clocks_size = ARRAY_SIZE(anubis_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL1 | S3C2410_UCON_CLKSEL2,
 	},
 	[1] = {
 		.hwport	     = 2,
@@ -128,8 +111,7 @@ static struct s3c2410_uartcfg anubis_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = anubis_serial_clocks,
-		.clocks_size = ARRAY_SIZE(anubis_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL1 | S3C2410_UCON_CLKSEL2,
 	},
 };
 
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 6c98b78..4cc60b1 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -57,22 +57,6 @@ static struct map_desc at2440evb_iodesc[] __initdata = {
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
 #define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
 
-static struct s3c24xx_uart_clksrc at2440evb_serial_clocks[] = {
-	[0] = {
-		.name		= "uclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	}
-};
-
-
 static struct s3c2410_uartcfg at2440evb_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
@@ -80,8 +64,7 @@ static struct s3c2410_uartcfg at2440evb_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = at2440evb_serial_clocks,
-		.clocks_size = ARRAY_SIZE(at2440evb_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL1 | S3C2410_UCON_CLKSEL2,
 	},
 	[1] = {
 		.hwport	     = 1,
@@ -89,8 +72,7 @@ static struct s3c2410_uartcfg at2440evb_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = at2440evb_serial_clocks,
-		.clocks_size = ARRAY_SIZE(at2440evb_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL1 | S3C2410_UCON_CLKSEL2,
 	},
 };
 
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index d885363..b75ed46 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -100,21 +100,6 @@ static struct map_desc osiris_iodesc[] __initdata = {
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
 #define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
 
-static struct s3c24xx_uart_clksrc osiris_serial_clocks[] = {
-	[0] = {
-		.name		= "uclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	}
-};
-
 static struct s3c2410_uartcfg osiris_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
@@ -122,8 +107,7 @@ static struct s3c2410_uartcfg osiris_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = osiris_serial_clocks,
-		.clocks_size = ARRAY_SIZE(osiris_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL1 | S3C2410_UCON_CLKSEL2,
 	},
 	[1] = {
 		.hwport	     = 1,
@@ -131,8 +115,7 @@ static struct s3c2410_uartcfg osiris_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = osiris_serial_clocks,
-		.clocks_size = ARRAY_SIZE(osiris_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL1 | S3C2410_UCON_CLKSEL2,
 	},
 	[2] = {
 		.hwport	     = 2,
@@ -140,8 +123,7 @@ static struct s3c2410_uartcfg osiris_uartcfgs[] __initdata = {
 		.ucon	     = UCON,
 		.ulcon	     = ULCON,
 		.ufcon	     = UFCON,
-		.clocks	     = osiris_serial_clocks,
-		.clocks_size = ARRAY_SIZE(osiris_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL1 | S3C2410_UCON_CLKSEL2,
 	}
 };
 
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 9528b37..04bb392 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -67,15 +67,6 @@
 static struct map_desc rx1950_iodesc[] __initdata = {
 };
 
-static struct s3c24xx_uart_clksrc rx1950_serial_clocks[] = {
-	[0] = {
-	       .name = "fclk_n",
-	       .divisor = 1,
-	       .min_baud = 0,
-	       .max_baud = 0,
-	},
-};
-
 static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
 	[0] = {
 	       .hwport = 0,
@@ -83,8 +74,7 @@ static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
 	       .ucon = 0x3c5,
 	       .ulcon = 0x03,
 	       .ufcon = 0x51,
-	       .clocks = rx1950_serial_clocks,
-	       .clocks_size = ARRAY_SIZE(rx1950_serial_clocks),
+		.clk_sel = S3C2410_UCON_CLKSEL3,
 	},
 	[1] = {
 	       .hwport = 1,
@@ -92,8 +82,7 @@ static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
 	       .ucon = 0x3c5,
 	       .ulcon = 0x03,
 	       .ufcon = 0x51,
-	       .clocks = rx1950_serial_clocks,
-	       .clocks_size = ARRAY_SIZE(rx1950_serial_clocks),
+		.clk_sel = S3C2410_UCON_CLKSEL3,
 	},
 	/* IR port */
 	[2] = {
@@ -102,8 +91,7 @@ static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
 	       .ucon = 0x3c5,
 	       .ulcon = 0x43,
 	       .ufcon = 0xf1,
-	       .clocks = rx1950_serial_clocks,
-	       .clocks_size = ARRAY_SIZE(rx1950_serial_clocks),
+		.clk_sel = S3C2410_UCON_CLKSEL3,
 	},
 };
 
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index a88247e..3c0d17c 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -67,16 +67,6 @@ static struct map_desc rx3715_iodesc[] __initdata = {
 	},
 };
 
-
-static struct s3c24xx_uart_clksrc rx3715_serial_clocks[] = {
-	[0] = {
-		.name		= "fclk_n",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	}
-};
-
 static struct s3c2410_uartcfg rx3715_uartcfgs[] = {
 	[0] = {
 		.hwport	     = 0,
@@ -84,8 +74,7 @@ static struct s3c2410_uartcfg rx3715_uartcfgs[] = {
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x51,
-		.clocks	     = rx3715_serial_clocks,
-		.clocks_size = ARRAY_SIZE(rx3715_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL3,
 	},
 	[1] = {
 		.hwport	     = 1,
@@ -93,8 +82,7 @@ static struct s3c2410_uartcfg rx3715_uartcfgs[] = {
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x03,
 		.ufcon	     = 0x00,
-		.clocks	     = rx3715_serial_clocks,
-		.clocks_size = ARRAY_SIZE(rx3715_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL3,
 	},
 	/* IR port */
 	[2] = {
@@ -103,8 +91,7 @@ static struct s3c2410_uartcfg rx3715_uartcfgs[] = {
 		.ucon	     = 0x3c5,
 		.ulcon	     = 0x43,
 		.ufcon	     = 0x51,
-		.clocks	     = rx3715_serial_clocks,
-		.clocks_size = ARRAY_SIZE(rx3715_serial_clocks),
+		.clk_sel	= S3C2410_UCON_CLKSEL3,
 	}
 };
 
diff --git a/arch/arm/mach-s5p64x0/init.c b/arch/arm/mach-s5p64x0/init.c
index 79833ca..659a66c 100644
--- a/arch/arm/mach-s5p64x0/init.c
+++ b/arch/arm/mach-s5p64x0/init.c
@@ -23,36 +23,7 @@
 #include <plat/s5p6450.h>
 #include <plat/regs-serial.h>
 
-static struct s3c24xx_uart_clksrc s5p64x0_serial_clocks[] = {
-	[0] = {
-		.name		= "pclk_low",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-	[1] = {
-		.name		= "uclk1",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
 /* uart registration process */
-
-void __init s5p64x0_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->clocks = s5p64x0_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5p64x0_serial_clocks);
-		}
-	}
-}
-
 void __init s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	int uart;
@@ -62,12 +33,10 @@ void __init s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 		s5p_uart_resources[uart].resources->end = S5P6440_PA_UART(uart) + S5P_SZ_UART;
 	}
 
-	s5p64x0_common_init_uarts(cfg, no);
 	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
 }
 
 void __init s5p6450_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
-	s5p64x0_common_init_uarts(cfg, no);
 	s3c24xx_init_uartdevs("s3c6400-uart", s5p_uart_resources, cfg, no);
 }
diff --git a/arch/arm/mach-s5pv210/init.c b/arch/arm/mach-s5pv210/init.c
index 4865ae2..468a5f8 100644
--- a/arch/arm/mach-s5pv210/init.c
+++ b/arch/arm/mach-s5pv210/init.c
@@ -18,27 +18,8 @@
 #include <plat/s5pv210.h>
 #include <plat/regs-serial.h>
 
-static struct s3c24xx_uart_clksrc s5pv210_serial_clocks[] = {
-	[0] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
 /* uart registration process */
 void __init s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->clocks = s5pv210_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5pv210_serial_clocks);
-		}
-	}
-
 	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
 }
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index b493d8d..25f0c36 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -229,26 +229,6 @@
 
 #ifndef __ASSEMBLY__
 
-/* struct s3c24xx_uart_clksrc
- *
- * this structure defines a named clock source that can be used for the
- * uart, so that the best clock can be selected for the requested baud
- * rate.
- *
- * min_baud and max_baud define the range of baud-rates this clock is
- * acceptable for, if they are both zero, it is assumed any baud rate that
- * can be generated from this clock will be used.
- *
- * divisor gives the divisor from the clock to the one seen by the uart
-*/
-
-struct s3c24xx_uart_clksrc {
-	const char	*name;
-	unsigned int	 divisor;
-	unsigned int	 min_baud;
-	unsigned int	 max_baud;
-};
-
 /* configuration structure for per-machine configurations for the
  * serial port
  *
@@ -268,9 +248,6 @@ struct s3c2410_uartcfg {
 	unsigned long	   ucon;	 /* value of ucon for port */
 	unsigned long	   ulcon;	 /* value of ulcon for port */
 	unsigned long	   ufcon;	 /* value of ufcon for port */
-
-	struct s3c24xx_uart_clksrc *clocks;
-	unsigned int		    clocks_size;
 };
 
 /* s3c24xx_uart_devs
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 11369f3..40e9ef1 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -47,7 +47,6 @@ struct s3c24xx_uart_port {
 	unsigned int			tx_irq;
 
 	struct s3c24xx_uart_info	*info;
-	struct s3c24xx_uart_clksrc	*clksrc;
 	struct clk			*clk;
 	struct clk			*baudclk;
 	struct uart_port		port;
-- 
1.6.6.rc2
