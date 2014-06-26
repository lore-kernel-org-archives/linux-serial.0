From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 3/3] ARM: dts: SAMSUNG: Add aliases of UART nodes
Date: Thu, 26 Jun 2014 13:24:35 +0200
Message-ID: <1403781875-5425-4-git-send-email-t.figa@samsung.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <t.figa@samsung.com>, linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-serial@vger.kernel.org

This patch adds alias entries for UART nodes of all SoCs using
samsung-uart compatible UART controllers, so that the dependency on
probe order is removed and deterministic device naming is assured.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi |  2 ++
 arch/arm/boot/dts/exynos4.dtsi    | 12 ++++++++----
 arch/arm/boot/dts/exynos5.dtsi    | 15 +++++++++++----
 arch/arm/boot/dts/exynos5260.dtsi |  4 ++++
 arch/arm/boot/dts/exynos5410.dtsi |  6 ++++++
 arch/arm/boot/dts/exynos5440.dtsi |  6 ++++--
 arch/arm/boot/dts/s3c2416.dtsi    |  6 +++++-
 arch/arm/boot/dts/s3c24xx.dtsi    |  9 ++++++---
 arch/arm/boot/dts/s3c64xx.dtsi    |  4 ++++
 9 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 3e678fa..f4b5411 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -39,6 +39,8 @@
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
 		i2c7 = &i2c_7;
+		serial0 = &serial_0;
+		serial1 = &serial_1;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index fbaf426..536d3c3 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -44,6 +44,10 @@
 		fimc1 = &fimc_1;
 		fimc2 = &fimc_2;
 		fimc3 = &fimc_3;
+		serial0 = &serial_0;
+		serial1 = &serial_1;
+		serial2 = &serial_2;
+		serial3 = &serial_3;
 	};
 
 	clock_audss: clock-controller@03810000 {
@@ -363,7 +367,7 @@
 		status = "disabled";
 	};
 
-	serial@13800000 {
+	serial_0: serial@13800000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
 		interrupts = <0 52 0>;
@@ -372,7 +376,7 @@
 		status = "disabled";
 	};
 
-	serial@13810000 {
+	serial_1: serial@13810000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13810000 0x100>;
 		interrupts = <0 53 0>;
@@ -381,7 +385,7 @@
 		status = "disabled";
 	};
 
-	serial@13820000 {
+	serial_2: serial@13820000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13820000 0x100>;
 		interrupts = <0 54 0>;
@@ -390,7 +394,7 @@
 		status = "disabled";
 	};
 
-	serial@13830000 {
+	serial_3: serial@13830000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13830000 0x100>;
 		interrupts = <0 55 0>;
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 79d0608..ff2d2cb 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -18,6 +18,13 @@
 / {
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &serial_0;
+		serial1 = &serial_1;
+		serial2 = &serial_2;
+		serial3 = &serial_3;
+	};
+
 	chipid@10000000 {
 		compatible = "samsung,exynos4210-chipid";
 		reg = <0x10000000 0x100>;
@@ -50,25 +57,25 @@
 		interrupts = <1 9 0xf04>;
 	};
 
-	serial@12C00000 {
+	serial_0: serial@12C00000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C00000 0x100>;
 		interrupts = <0 51 0>;
 	};
 
-	serial@12C10000 {
+	serial_1: serial@12C10000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C10000 0x100>;
 		interrupts = <0 52 0>;
 	};
 
-	serial@12C20000 {
+	serial_2: serial@12C20000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C20000 0x100>;
 		interrupts = <0 53 0>;
 	};
 
-	serial@12C30000 {
+	serial_3: serial@12C30000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x12C30000 0x100>;
 		interrupts = <0 54 0>;
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 5398a60..4539a0a 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -21,6 +21,10 @@
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 3839c26..52070e5 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -20,6 +20,12 @@
 	compatible = "samsung,exynos5410", "samsung,exynos5";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index ae3a17c..8f3373c 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -18,6 +18,8 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		serial0 = &serial_0;
+		serial1 = &serial_1;
 		spi0 = &spi_0;
 		tmuctrl0 = &tmuctrl_0;
 		tmuctrl1 = &tmuctrl_1;
@@ -102,7 +104,7 @@
 		>;
 	};
 
-	serial@B0000 {
+	serial_0: serial@B0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xB0000 0x1000>;
 		interrupts = <0 2 0>;
@@ -110,7 +112,7 @@
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
-	serial@C0000 {
+	serial_1: serial@C0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xC0000 0x1000>;
 		interrupts = <0 3 0>;
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 955e4a4..30b8f7e 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -16,6 +16,10 @@
 	model = "Samsung S3C2416 SoC";
 	compatible = "samsung,s3c2416";
 
+	aliases {
+		serial3 = &uart3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -68,7 +72,7 @@
 				<&clocks SCLK_UART>;
 	};
 
-	serial@5000C000 {
+	uart3: serial@5000C000 {
 		compatible = "samsung,s3c2440-uart";
 		reg = <0x5000C000 0x4000>;
 		interrupts = <1 18 24 4>, <1 18 25 4>;
diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
index 2d1d7dc..5ed43b8 100644
--- a/arch/arm/boot/dts/s3c24xx.dtsi
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -16,6 +16,9 @@
 
 	aliases {
 		pinctrl0 = &pinctrl_0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
 	};
 
 	intc:interrupt-controller@4a000000 {
@@ -46,21 +49,21 @@
 		#pwm-cells = <4>;
 	};
 
-	serial@50000000 {
+	uart0: serial@50000000 {
 		compatible = "samsung,s3c2410-uart";
 		reg = <0x50000000 0x4000>;
 		interrupts = <1 28 0 4>, <1 28 1 4>;
 		status = "disabled";
 	};
 
-	serial@50004000 {
+	uart1: serial@50004000 {
 		compatible = "samsung,s3c2410-uart";
 		reg = <0x50004000 0x4000>;
 		interrupts = <1 23 3 4>, <1 23 4 4>;
 		status = "disabled";
 	};
 
-	serial@50008000 {
+	uart2: serial@50008000 {
 		compatible = "samsung,s3c2410-uart";
 		reg = <0x50008000 0x4000>;
 		interrupts = <1 15 6 4>, <1 15 7 4>;
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 4e3be4d..ff5bdaa 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -23,6 +23,10 @@
 	aliases {
 		i2c0 = &i2c0;
 		pinctrl0 = &pinctrl0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	cpus {
-- 
1.9.3
