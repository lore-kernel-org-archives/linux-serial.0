From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 15/34] dt: clk: Add ingenic,jz4740-cgu binding documentation
Date: Wed, 4 Feb 2015 15:21:44 +0000
Message-ID: <1423063323-19419-16-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

Document the devicetree binding for the Ingenic jz4740 CGU driver.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: devicetree@vger.kernel.org
---
 .../bindings/clock/ingenic,jz4740-cgu.txt          | 52 ++++++++++++++++++++++
 include/dt-bindings/clock/jz4740-cgu.h             | 37 +++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,jz4740-cgu.txt
 create mode 100644 include/dt-bindings/clock/jz4740-cgu.h

diff --git a/Documentation/devicetree/bindings/clock/ingenic,jz4740-cgu.txt b/Documentation/devicetree/bindings/clock/ingenic,jz4740-cgu.txt
new file mode 100644
index 0000000..b02e168
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ingenic,jz4740-cgu.txt
@@ -0,0 +1,52 @@
+Ingenic jz4740 SoC CGU binding
+
+The CGU in a jz4740 SoC provides all the clocks generated on-chip. It includes
+PLLs, multiplexers, dividers & gates in order to provide a variety of different
+clock signals derived from only 2 external source clocks.
+
+Required properties:
+- compatible: Should be "ingenic,jz4740-cgu"
+- reg: Should be the address & length of the CGU registers
+- clocks: Should contain the phandle & clock specifier for two clocks external
+          to the TCU. First the external crystal "ext" and second the RTC
+          clock source "rtc".
+- clock-names: Should be set to strings naming the clocks specified in the
+               "clocks" property.
+- #clock-cells: Should be 1.
+                Clock consumers specify this argument to identify a clock. The
+                valid values may be found in <dt-bindings/clock/jz4740-cgu.h>.
+
+Example SoC include file:
+
+/ {
+	cgu: jz4740-cgu {
+		compatible = "ingenic,jz4740-cgu";
+		reg = <0x10000000 0x100>;
+		#clock-cells = <1>;
+	};
+
+	uart0: serial@10030000 {
+		clocks = <&cgu JZ4740_CLK_UART0>;
+	};
+};
+
+Example board file:
+
+/ {
+	ext: clock@0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+
+	rtc: clock@1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	&cgu {
+		clocks = <&ext> <&rtc>;
+		clock-names: "ext", "rtc";
+	};
+};
diff --git a/include/dt-bindings/clock/jz4740-cgu.h b/include/dt-bindings/clock/jz4740-cgu.h
new file mode 100644
index 0000000..43153d3
--- /dev/null
+++ b/include/dt-bindings/clock/jz4740-cgu.h
@@ -0,0 +1,37 @@
+/*
+ * This header provides clock numbers for the ingenic,jz4740-cgu DT binding.
+ *
+ * They are roughly ordered as:
+ *   - external clocks
+ *   - PLLs
+ *   - muxes/dividers in the order they appear in the jz4740 programmers manual
+ *   - gates in order of their bit in the CLKGR* registers
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
+#define __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
+
+#define JZ4740_CLK_EXT		0
+#define JZ4740_CLK_RTC		1
+#define JZ4740_CLK_PLL		2
+#define JZ4740_CLK_PLL_HALF	3
+#define JZ4740_CLK_CCLK		4
+#define JZ4740_CLK_HCLK		5
+#define JZ4740_CLK_PCLK		6
+#define JZ4740_CLK_MCLK		7
+#define JZ4740_CLK_LCD		8
+#define JZ4740_CLK_LCD_PCLK	9
+#define JZ4740_CLK_I2S		10
+#define JZ4740_CLK_SPI		11
+#define JZ4740_CLK_MMC		12
+#define JZ4740_CLK_UHC		13
+#define JZ4740_CLK_UDC		14
+#define JZ4740_CLK_UART0	15
+#define JZ4740_CLK_UART1	16
+#define JZ4740_CLK_DMA		17
+#define JZ4740_CLK_IPU		18
+#define JZ4740_CLK_ADC		19
+#define JZ4740_CLK_I2C		20
+#define JZ4740_CLK_AIC		21
+
+#endif /* __DT_BINDINGS_CLOCK_JZ4740_CGU_H__ */
-- 
1.9.1
