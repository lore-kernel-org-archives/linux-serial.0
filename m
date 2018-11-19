From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 14/14] MAINTAINERS: Add entry to MAINTAINERS for Milbeaut
Date: Mon, 19 Nov 2018 10:02:16 +0900
Message-ID: <1542589336-13925-5-git-send-email-sugaya.taichi@socionext.com>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sugaya Taichi <sugaya.taichi@socionext.com>
List-Id: linux-serial@vger.kernel.org

Add entry to MAINTAINERS for Milbeaut that supported minimal drivers.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc5..31dd29f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1782,6 +1782,15 @@ F:	drivers/watchdog/sama5d4_wdt.c
 X:	drivers/input/touchscreen/atmel_mxt_ts.c
 X:	drivers/net/wireless/atmel/
 
+ARM/MILBEAUT ARCHITECTURE
+M:	Taichi Sugaya <sugaya.taichi@socionext.com>
+M:	Takao Orito <orito.takao@socionext.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/milbeaut*
+F:	arch/arm/mach-milbeaut/
+N:	milbeaut
+
 ARM/MIOA701 MACHINE SUPPORT
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
1.9.1
