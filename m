From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 01/12] irqchip: armada-370-xp: add Kconfig option for the driver
Date: Tue, 16 Feb 2016 19:14:51 +0100
Message-ID: <1455646502-23834-2-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Instead of building the irq-armada-370-xp driver directly when
CONFIG_ARCH_MVEBU is enabled, this commit introduces an intermediate
CONFIG_ARMADA_370_XP_IRQ hidden Kconfig option.

This allows this option to select other interrupt-related Kconfig
options (which will be needed in follow-up commits) rather than having
such selects done from arch/arm/mach-<foo>/.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/Kconfig  | 5 +++++
 drivers/irqchip/Makefile | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 715923d5236c..e2cab879d641 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -60,6 +60,11 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
+config ARMADA_370_XP_IRQ
+	bool
+	default y if ARCH_MVEBU
+	select GENERIC_IRQ_CHIP
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 18caacb60d58..30dba044d0b8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
-obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
 obj-$(CONFIG_IRQ_MXS)			+= irq-mxs.o
 obj-$(CONFIG_ARCH_TEGRA)		+= irq-tegra.o
 obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
@@ -28,6 +27,7 @@ obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-g
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
+obj-$(CONFIG_ARMADA_370_XP_IRQ)		+= irq-armada-370-xp.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
 obj-$(CONFIG_ATMEL_AIC5_IRQ)	+= irq-atmel-aic-common.o irq-atmel-aic5.o
 obj-$(CONFIG_I8259)			+= irq-i8259.o
-- 
2.5.0

