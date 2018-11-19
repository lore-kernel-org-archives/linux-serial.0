From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline description
Date: Mon, 19 Nov 2018 10:01:07 +0900
Message-ID: <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sugaya Taichi <sugaya.taichi@socionext.com>
List-Id: linux-serial@vger.kernel.org

Add DT bindings document for Milbeaut trampoline.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/soc/socionext/socionext,m10v.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt

diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
new file mode 100644
index 0000000..f5d906c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
@@ -0,0 +1,12 @@
+Socionext M10V SMP trampoline driver binding
+
+This is a driver to wait for sub-cores while boot process.
+
+- compatible: should be "socionext,smp-trampoline"
+- reg: should be <0x4C000100 0x100>
+
+EXAMPLE
+	trampoline: trampoline@0x4C000100 {
+		compatible = "socionext,smp-trampoline";
+		reg = <0x4C000100 0x100>;
+	};
-- 
1.9.1
