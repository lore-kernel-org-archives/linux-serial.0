From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/4] arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards
Date: Fri, 14 Dec 2018 12:34:10 +0100
Message-ID: <20181214113410.22848-5-m.szyprowski@samsung.com>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113419eucas1p2473172a49bf798ddd95265fa31125d96@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20181214113410.22848-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

TM2(e) boards have a Broadcom Bluetooth chip connected to 3rd UART port.
Add a device tree node describing it and its resources (control GPIO lines
and clock).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index f3ed4c078ba5..d88e2f0e179a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1202,6 +1202,20 @@
 	status = "okay";
 };
 
+&serial_3 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+		shutdown-gpios = <&gpd4 0 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpr3 7 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpa2 2 GPIO_ACTIVE_HIGH>;
+		clocks = <&s2mps13_osc S2MPS11_CLK_BT>;
+		clock-names = "extclk";
+	};
+};
+
 &spi_1 {
 	cs-gpios = <&gpd6 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-- 
2.17.1
