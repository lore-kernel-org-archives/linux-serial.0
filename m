From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 02/12] irqchip: armada-370-xp: do not enable it by default when ARCH_MVEBU is selected
Date: Wed,  3 Feb 2016 19:41:19 +0100
Message-ID: <1454524889-9207-3-git-send-email-gregory.clement@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

The irq-armada-370-xp driver can only be built for ARM 32 bits. The mvebu
family had grown with a new ARM64 SoC which will also select the
ARCH_MEVBU configuration. Since "ARM: mvebu: use the ARMADA_370_XP_IRQ
option", the ARM32 mvebu SoC directly select this new option. Selecting
it by default when ARCH_MEVBU is selected is no more needed.

This patch removes this dependency, thanks to this, a kernel for ARM64
mvebu SoC can be built without error due this driver.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e2cab879d641..b6e7e86a57e1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -62,7 +62,6 @@ config ARM_VIC_NR
 
 config ARMADA_370_XP_IRQ
 	bool
-	default y if ARCH_MVEBU
 	select GENERIC_IRQ_CHIP
 
 config ATMEL_AIC_IRQ
-- 
2.5.0
