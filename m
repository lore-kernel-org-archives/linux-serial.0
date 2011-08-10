From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 2/2] ARM: SAMSUNG: Remove uart irq handling from plaform code
Date: Wed, 10 Aug 2011 15:51:20 +0530
Message-ID: <1312971680-3898-3-git-send-email-thomas.abraham@linaro.org>
References: <1312971680-3898-1-git-send-email-thomas.abraham@linaro.org>
 <1312971680-3898-2-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1312971680-3898-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, grant.likely@secretlab.ca, ben-linux@fluff.org
List-Id: linux-serial@vger.kernel.org

With uart tx/rx/err interrupt handling moved into the driver for s3c64xx
and later SoC's, the uart interrupt handling in plaform code can be removed.
The uart device irq resources is reduced to one and the related unused
macros are removed.

Suggested-by: Grant Likely <grant.likely@secretlab.ca>
CC: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/Kconfig                                 |    1 -
 arch/arm/mach-s3c64xx/dev-uart.c                 |   60 ++------------
 arch/arm/mach-s3c64xx/include/mach/irqs.h        |   30 -------
 arch/arm/mach-s3c64xx/irq.c                      |   25 ------
 arch/arm/plat-s5p/Kconfig                        |    1 -
 arch/arm/plat-s5p/dev-uart.c                     |   84 +++----------------
 arch/arm/plat-s5p/include/plat/irqs.h            |   35 --------
 arch/arm/plat-s5p/irq.c                          |   34 --------
 arch/arm/plat-samsung/Kconfig                    |    5 -
 arch/arm/plat-samsung/Makefile                   |    1 -
 arch/arm/plat-samsung/include/plat/regs-serial.h |    5 +
 arch/arm/plat-samsung/irq-uart.c                 |   96 ----------------------
 12 files changed, 25 insertions(+), 352 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/irq-uart.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c71a8f..94228f7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -723,7 +723,6 @@ config ARCH_S3C64XX
 	select ARCH_REQUIRE_GPIOLIB
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_IRQ_VIC_TIMER
-	select SAMSUNG_IRQ_UART
 	select S3C_GPIO_TRACK
 	select S3C_GPIO_PULL_UPDOWN
 	select S3C_GPIO_CFG_S3C24XX
diff --git a/arch/arm/mach-s3c64xx/dev-uart.c b/arch/arm/mach-s3c64xx/dev-uart.c
index f797f74..c681b99 100644
--- a/arch/arm/mach-s3c64xx/dev-uart.c
+++ b/arch/arm/mach-s3c64xx/dev-uart.c
@@ -37,21 +37,10 @@ static struct resource s3c64xx_uart0_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S3CUART_RX0,
-		.end	= IRQ_S3CUART_RX0,
+		.start	= IRQ_UART0,
+		.end	= IRQ_UART0,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= IRQ_S3CUART_TX0,
-		.end	= IRQ_S3CUART_TX0,
-		.flags	= IORESOURCE_IRQ,
-
-	},
-	[3] = {
-		.start	= IRQ_S3CUART_ERR0,
-		.end	= IRQ_S3CUART_ERR0,
-		.flags	= IORESOURCE_IRQ,
-	}
 };
 
 static struct resource s3c64xx_uart1_resource[] = {
@@ -61,19 +50,8 @@ static struct resource s3c64xx_uart1_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S3CUART_RX1,
-		.end	= IRQ_S3CUART_RX1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S3CUART_TX1,
-		.end	= IRQ_S3CUART_TX1,
-		.flags	= IORESOURCE_IRQ,
-
-	},
-	[3] = {
-		.start	= IRQ_S3CUART_ERR1,
-		.end	= IRQ_S3CUART_ERR1,
+		.start	= IRQ_UART1,
+		.end	= IRQ_UART1,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -85,19 +63,8 @@ static struct resource s3c6xx_uart2_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S3CUART_RX2,
-		.end	= IRQ_S3CUART_RX2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S3CUART_TX2,
-		.end	= IRQ_S3CUART_TX2,
-		.flags	= IORESOURCE_IRQ,
-
-	},
-	[3] = {
-		.start	= IRQ_S3CUART_ERR2,
-		.end	= IRQ_S3CUART_ERR2,
+		.start	= IRQ_UART2,
+		.end	= IRQ_UART2,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -109,19 +76,8 @@ static struct resource s3c64xx_uart3_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S3CUART_RX3,
-		.end	= IRQ_S3CUART_RX3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S3CUART_TX3,
-		.end	= IRQ_S3CUART_TX3,
-		.flags	= IORESOURCE_IRQ,
-
-	},
-	[3] = {
-		.start	= IRQ_S3CUART_ERR3,
-		.end	= IRQ_S3CUART_ERR3,
+		.start	= IRQ_UART3,
+		.end	= IRQ_UART3,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
index c026f67..443f85b 100644
--- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
@@ -27,36 +27,6 @@
 #define IRQ_VIC0_BASE	S3C_IRQ(0)
 #define IRQ_VIC1_BASE	S3C_IRQ(32)
 
-/* UART interrupts, each UART has 4 intterupts per channel so
- * use the space between the ISA and S3C main interrupts. Note, these
- * are not in the same order as the S3C24XX series! */
-
-#define IRQ_S3CUART_BASE0	(16)
-#define IRQ_S3CUART_BASE1	(20)
-#define IRQ_S3CUART_BASE2	(24)
-#define IRQ_S3CUART_BASE3	(28)
-
-#define UART_IRQ_RXD		(0)
-#define UART_IRQ_ERR		(1)
-#define UART_IRQ_TXD		(2)
-#define UART_IRQ_MODEM		(3)
-
-#define IRQ_S3CUART_RX0		(IRQ_S3CUART_BASE0 + UART_IRQ_RXD)
-#define IRQ_S3CUART_TX0		(IRQ_S3CUART_BASE0 + UART_IRQ_TXD)
-#define IRQ_S3CUART_ERR0	(IRQ_S3CUART_BASE0 + UART_IRQ_ERR)
-
-#define IRQ_S3CUART_RX1		(IRQ_S3CUART_BASE1 + UART_IRQ_RXD)
-#define IRQ_S3CUART_TX1		(IRQ_S3CUART_BASE1 + UART_IRQ_TXD)
-#define IRQ_S3CUART_ERR1	(IRQ_S3CUART_BASE1 + UART_IRQ_ERR)
-
-#define IRQ_S3CUART_RX2		(IRQ_S3CUART_BASE2 + UART_IRQ_RXD)
-#define IRQ_S3CUART_TX2		(IRQ_S3CUART_BASE2 + UART_IRQ_TXD)
-#define IRQ_S3CUART_ERR2	(IRQ_S3CUART_BASE2 + UART_IRQ_ERR)
-
-#define IRQ_S3CUART_RX3		(IRQ_S3CUART_BASE3 + UART_IRQ_RXD)
-#define IRQ_S3CUART_TX3		(IRQ_S3CUART_BASE3 + UART_IRQ_TXD)
-#define IRQ_S3CUART_ERR3	(IRQ_S3CUART_BASE3 + UART_IRQ_ERR)
-
 /* VIC based IRQs */
 
 #define S3C64XX_IRQ_VIC0(x)	(IRQ_VIC0_BASE + (x))
diff --git a/arch/arm/mach-s3c64xx/irq.c b/arch/arm/mach-s3c64xx/irq.c
index 75d9a0e..b07357e 100644
--- a/arch/arm/mach-s3c64xx/irq.c
+++ b/arch/arm/mach-s3c64xx/irq.c
@@ -25,29 +25,6 @@
 #include <plat/irq-uart.h>
 #include <plat/cpu.h>
 
-static struct s3c_uart_irq uart_irqs[] = {
-	[0] = {
-		.regs		= S3C_VA_UART0,
-		.base_irq	= IRQ_S3CUART_BASE0,
-		.parent_irq	= IRQ_UART0,
-	},
-	[1] = {
-		.regs		= S3C_VA_UART1,
-		.base_irq	= IRQ_S3CUART_BASE1,
-		.parent_irq	= IRQ_UART1,
-	},
-	[2] = {
-		.regs		= S3C_VA_UART2,
-		.base_irq	= IRQ_S3CUART_BASE2,
-		.parent_irq	= IRQ_UART2,
-	},
-	[3] = {
-		.regs		= S3C_VA_UART3,
-		.base_irq	= IRQ_S3CUART_BASE3,
-		.parent_irq	= IRQ_UART3,
-	},
-};
-
 /* setup the sources the vic should advertise resume for, even though it
  * is not doing the wake (set_irq_wake needs to be valid) */
 #define IRQ_VIC0_RESUME (1 << (IRQ_RTC_TIC - IRQ_VIC0_BASE))
@@ -67,6 +44,4 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 
 	/* add the timer sub-irqs */
 	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
-
-	s3c_init_uart_irqs(uart_irqs, ARRAY_SIZE(uart_irqs));
 }
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 9843c95..9a197e5 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -22,7 +22,6 @@ config PLAT_S5P
 	select PLAT_SAMSUNG
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_IRQ_VIC_TIMER
-	select SAMSUNG_IRQ_UART
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-s5p/dev-uart.c
index afaf87f..c9308db 100644
--- a/arch/arm/plat-s5p/dev-uart.c
+++ b/arch/arm/plat-s5p/dev-uart.c
@@ -32,20 +32,10 @@ static struct resource s5p_uart0_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S5P_UART_RX0,
-		.end	= IRQ_S5P_UART_RX0,
+		.start	= IRQ_UART0,
+		.end	= IRQ_UART0,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX0,
-		.end	= IRQ_S5P_UART_TX0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR0,
-		.end	= IRQ_S5P_UART_ERR0,
-		.flags	= IORESOURCE_IRQ,
-	}
 };
 
 static struct resource s5p_uart1_resource[] = {
@@ -55,18 +45,8 @@ static struct resource s5p_uart1_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S5P_UART_RX1,
-		.end	= IRQ_S5P_UART_RX1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX1,
-		.end	= IRQ_S5P_UART_TX1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR1,
-		.end	= IRQ_S5P_UART_ERR1,
+		.start	= IRQ_UART1,
+		.end	= IRQ_UART1,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -78,18 +58,8 @@ static struct resource s5p_uart2_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S5P_UART_RX2,
-		.end	= IRQ_S5P_UART_RX2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX2,
-		.end	= IRQ_S5P_UART_TX2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR2,
-		.end	= IRQ_S5P_UART_ERR2,
+		.start	= IRQ_UART2,
+		.end	= IRQ_UART2,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -102,18 +72,8 @@ static struct resource s5p_uart3_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S5P_UART_RX3,
-		.end	= IRQ_S5P_UART_RX3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX3,
-		.end	= IRQ_S5P_UART_TX3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR3,
-		.end	= IRQ_S5P_UART_ERR3,
+		.start	= IRQ_UART3,
+		.end	= IRQ_UART3,
 		.flags	= IORESOURCE_IRQ,
 	},
 #endif
@@ -127,18 +87,8 @@ static struct resource s5p_uart4_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S5P_UART_RX4,
-		.end	= IRQ_S5P_UART_RX4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX4,
-		.end	= IRQ_S5P_UART_TX4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR4,
-		.end	= IRQ_S5P_UART_ERR4,
+		.start	= IRQ_UART4,
+		.end	= IRQ_UART4,
 		.flags	= IORESOURCE_IRQ,
 	},
 #endif
@@ -152,18 +102,8 @@ static struct resource s5p_uart5_resource[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= IRQ_S5P_UART_RX5,
-		.end	= IRQ_S5P_UART_RX5,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX5,
-		.end	= IRQ_S5P_UART_TX5,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR5,
-		.end	= IRQ_S5P_UART_ERR5,
+		.start	= IRQ_UART5,
+		.end	= IRQ_UART5,
 		.flags	= IORESOURCE_IRQ,
 	},
 #endif
diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
index ba9121c..144dbfc 100644
--- a/arch/arm/plat-s5p/include/plat/irqs.h
+++ b/arch/arm/plat-s5p/include/plat/irqs.h
@@ -37,41 +37,6 @@
 #define IRQ_VIC1_BASE		S5P_VIC1_BASE
 #define IRQ_VIC2_BASE		S5P_VIC2_BASE
 
-/* UART interrupts, each UART has 4 intterupts per channel so
- * use the space between the ISA and S3C main interrupts. Note, these
- * are not in the same order as the S3C24XX series! */
-
-#define IRQ_S5P_UART_BASE0	(16)
-#define IRQ_S5P_UART_BASE1	(20)
-#define IRQ_S5P_UART_BASE2	(24)
-#define IRQ_S5P_UART_BASE3	(28)
-
-#define UART_IRQ_RXD		(0)
-#define UART_IRQ_ERR		(1)
-#define UART_IRQ_TXD		(2)
-
-#define IRQ_S5P_UART_RX0	(IRQ_S5P_UART_BASE0 + UART_IRQ_RXD)
-#define IRQ_S5P_UART_TX0	(IRQ_S5P_UART_BASE0 + UART_IRQ_TXD)
-#define IRQ_S5P_UART_ERR0	(IRQ_S5P_UART_BASE0 + UART_IRQ_ERR)
-
-#define IRQ_S5P_UART_RX1	(IRQ_S5P_UART_BASE1 + UART_IRQ_RXD)
-#define IRQ_S5P_UART_TX1	(IRQ_S5P_UART_BASE1 + UART_IRQ_TXD)
-#define IRQ_S5P_UART_ERR1	(IRQ_S5P_UART_BASE1 + UART_IRQ_ERR)
-
-#define IRQ_S5P_UART_RX2	(IRQ_S5P_UART_BASE2 + UART_IRQ_RXD)
-#define IRQ_S5P_UART_TX2	(IRQ_S5P_UART_BASE2 + UART_IRQ_TXD)
-#define IRQ_S5P_UART_ERR2	(IRQ_S5P_UART_BASE2 + UART_IRQ_ERR)
-
-#define IRQ_S5P_UART_RX3	(IRQ_S5P_UART_BASE3 + UART_IRQ_RXD)
-#define IRQ_S5P_UART_TX3	(IRQ_S5P_UART_BASE3 + UART_IRQ_TXD)
-#define IRQ_S5P_UART_ERR3	(IRQ_S5P_UART_BASE3 + UART_IRQ_ERR)
-
-/* S3C compatibilty defines */
-#define IRQ_S3CUART_RX0		IRQ_S5P_UART_RX0
-#define IRQ_S3CUART_RX1		IRQ_S5P_UART_RX1
-#define IRQ_S3CUART_RX2		IRQ_S5P_UART_RX2
-#define IRQ_S3CUART_RX3		IRQ_S5P_UART_RX3
-
 /* VIC based IRQs */
 
 #define S5P_IRQ_VIC0(x)		(S5P_VIC0_BASE + (x))
diff --git a/arch/arm/plat-s5p/irq.c b/arch/arm/plat-s5p/irq.c
index a97c089..afdaa10 100644
--- a/arch/arm/plat-s5p/irq.c
+++ b/arch/arm/plat-s5p/irq.c
@@ -17,42 +17,10 @@
 
 #include <asm/hardware/vic.h>
 
-#include <linux/serial_core.h>
 #include <mach/map.h>
 #include <plat/regs-timer.h>
-#include <plat/regs-serial.h>
 #include <plat/cpu.h>
 #include <plat/irq-vic-timer.h>
-#include <plat/irq-uart.h>
-
-/*
- * Note, we make use of the fact that the parent IRQs, IRQ_UART[0..3]
- * are consecutive when looking up the interrupt in the demux routines.
- */
-static struct s3c_uart_irq uart_irqs[] = {
-	[0] = {
-		.regs		= S5P_VA_UART0,
-		.base_irq	= IRQ_S5P_UART_BASE0,
-		.parent_irq	= IRQ_UART0,
-	},
-	[1] = {
-		.regs		= S5P_VA_UART1,
-		.base_irq	= IRQ_S5P_UART_BASE1,
-		.parent_irq	= IRQ_UART1,
-	},
-	[2] = {
-		.regs		= S5P_VA_UART2,
-		.base_irq	= IRQ_S5P_UART_BASE2,
-		.parent_irq	= IRQ_UART2,
-	},
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
-	[3] = {
-		.regs		= S5P_VA_UART3,
-		.base_irq	= IRQ_S5P_UART_BASE3,
-		.parent_irq	= IRQ_UART3,
-	},
-#endif
-};
 
 void __init s5p_init_irq(u32 *vic, u32 num_vic)
 {
@@ -65,6 +33,4 @@ void __init s5p_init_irq(u32 *vic, u32 num_vic)
 #endif
 
 	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
-
-	s3c_init_uart_irqs(uart_irqs, ARRAY_SIZE(uart_irqs));
 }
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b3e1065..dffa37b 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -65,11 +65,6 @@ config SAMSUNG_IRQ_VIC_TIMER
        help
          Internal configuration to build the VIC timer interrupt code.
 
-config SAMSUNG_IRQ_UART
-       bool
-       help
-         Internal configuration to build the IRQ UART demux code.
-
 # options for gpio configuration support
 
 config SAMSUNG_GPIOLIB_4BIT
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 853764b..1105922 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -21,7 +21,6 @@ obj-y				+= dev-asocdma.o
 
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 
-obj-$(CONFIG_SAMSUNG_IRQ_UART)	+= irq-uart.o
 obj-$(CONFIG_SAMSUNG_IRQ_VIC_TIMER) += irq-vic-timer.o
 
 # ADC
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index bac36fa..7207348 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -186,6 +186,11 @@
 #define S3C64XX_UINTSP		0x34
 #define S3C64XX_UINTM		0x38
 
+#define S3C64XX_UINTM_RXD	(0)
+#define S3C64XX_UINTM_TXD	(2)
+#define S3C64XX_UINTM_RXD_MSK	(1 << S3C64XX_UINTM_RXD)
+#define S3C64XX_UINTM_TXD_MSK	(1 << S3C64XX_UINTM_TXD)
+
 /* Following are specific to S5PV210 */
 #define S5PV210_UCON_CLKMASK	(1<<10)
 #define S5PV210_UCON_PCLK	(0<<10)
diff --git a/arch/arm/plat-samsung/irq-uart.c b/arch/arm/plat-samsung/irq-uart.c
deleted file mode 100644
index 3014c72..0000000
--- a/arch/arm/plat-samsung/irq-uart.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/* arch/arm/plat-samsung/irq-uart.c
- *	originally part of arch/arm/plat-s3c64xx/irq.c
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * Samsung- UART Interrupt handling
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/serial_core.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-
-#include <asm/mach/irq.h>
-
-#include <mach/map.h>
-#include <plat/irq-uart.h>
-#include <plat/regs-serial.h>
-#include <plat/cpu.h>
-
-/* Note, we make use of the fact that the parent IRQs, IRQ_UART[0..3]
- * are consecutive when looking up the interrupt in the demux routines.
- */
-static void s3c_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
-{
-	struct s3c_uart_irq *uirq = desc->irq_data.handler_data;
-	struct irq_chip *chip = irq_get_chip(irq);
-	u32 pend = __raw_readl(uirq->regs + S3C64XX_UINTP);
-	int base = uirq->base_irq;
-
-	chained_irq_enter(chip, desc);
-
-	if (pend & (1 << 0))
-		generic_handle_irq(base);
-	if (pend & (1 << 1))
-		generic_handle_irq(base + 1);
-	if (pend & (1 << 2))
-		generic_handle_irq(base + 2);
-	if (pend & (1 << 3))
-		generic_handle_irq(base + 3);
-
-	chained_irq_exit(chip, desc);
-}
-
-static void __init s3c_init_uart_irq(struct s3c_uart_irq *uirq)
-{
-	void __iomem *reg_base = uirq->regs;
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
-
-	/* mask all interrupts at the start. */
-	__raw_writel(0xf, reg_base + S3C64XX_UINTM);
-
-	gc = irq_alloc_generic_chip("s3c-uart", 1, uirq->base_irq, reg_base,
-				    handle_level_irq);
-
-	if (!gc) {
-		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
-		       __func__, uirq->base_irq);
-		return;
-	}
-
-	ct = gc->chip_types;
-	ct->chip.irq_ack = irq_gc_ack_set_bit;
-	ct->chip.irq_mask = irq_gc_mask_set_bit;
-	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
-	ct->regs.ack = S3C64XX_UINTP;
-	ct->regs.mask = S3C64XX_UINTM;
-	irq_setup_generic_chip(gc, IRQ_MSK(4), IRQ_GC_INIT_MASK_CACHE,
-			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
-
-	irq_set_handler_data(uirq->parent_irq, uirq);
-	irq_set_chained_handler(uirq->parent_irq, s3c_irq_demux_uart);
-}
-
-/**
- * s3c_init_uart_irqs() - initialise UART IRQs and the necessary demuxing
- * @irq: The interrupt data for registering
- * @nr_irqs: The number of interrupt descriptions in @irq.
- *
- * Register the UART interrupts specified by @irq including the demuxing
- * routines. This supports the S3C6400 and newer style of devices.
- */
-void __init s3c_init_uart_irqs(struct s3c_uart_irq *irq, unsigned int nr_irqs)
-{
-	for (; nr_irqs > 0; nr_irqs--, irq++)
-		s3c_init_uart_irq(irq);
-}
-- 
1.6.6.rc2
