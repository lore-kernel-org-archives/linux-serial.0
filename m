From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 09/34] MIPS: jz4740: probe interrupt controller via DT
Date: Wed, 4 Feb 2015 15:21:38 +0000
Message-ID: <1423063323-19419-10-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

Add the appropriate DT node to probe the interrupt controller driver
using the devicetree, and remove the call to jz4740_intc_init.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/boot/dts/jz4740.dtsi | 11 +++++++++++
 arch/mips/jz4740/setup.c       |  2 --
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
index 2d64765c..3841024 100644
--- a/arch/mips/boot/dts/jz4740.dtsi
+++ b/arch/mips/boot/dts/jz4740.dtsi
@@ -9,4 +9,15 @@
 		interrupt-controller;
 		compatible = "mti,cpu-interrupt-controller";
 	};
+
+	intc: intc@10001000 {
+		compatible = "ingenic,jz4740-intc";
+		reg = <0x10001000 0x14>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <2>;
+	};
 };
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 4808730..8c08d7d 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -25,7 +25,6 @@
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/irq.h>
 
 #include "reset.h"
 
@@ -84,5 +83,4 @@ const char *get_system_type(void)
 void __init arch_init_irq(void)
 {
 	irqchip_init();
-	jz4740_intc_init();
 }
-- 
1.9.1
