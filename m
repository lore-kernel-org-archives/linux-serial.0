From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 15/15] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date: Mon, 10 Dec 2018 23:05:50 +0530
Message-ID: <20181210173550.29643-16-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-serial@vger.kernel.org

Add MAINTAINERS entry for RDA Micro SoC architecture with myself
and Andreas Färber as the maintainers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3fbbb361f8..6411fb222590 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,6 +1945,21 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RDA MICRO ARCHITECTURE
+M:	Andreas Färber <afaerber@suse.de>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/rda8810pl-*
+F:	drivers/clocksource/timer-rda.c
+F:	drivers/irqchip/irq-rda-intc.c
+F:	drivers/tty/serial/rda-uart.c
+F:	Documentation/devicetree/bindings/arm/rda.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
+F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+
 ARM/REALTEK ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1
