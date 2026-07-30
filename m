Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8640B10D;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409595; cv=none; b=UWa1rmCzC0DXn4bpGotTqwQ0t97fRDAGOK4dBfQ3JhL5EVaXQUTYo1JqNMLo4yc6zj/AUqoeDmkCbzUJsbYfoofx0s3enhNdLolY2crJ8GwjYTjOiZU64Npdf+Y8jlQy6PCBTqumbVv2A98HXRgLjs79EEC9gOImNubIvAk7IjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409595; c=relaxed/simple;
	bh=mD7Q9GyLWEIiCCbGv6VrHoC/qEQcaerwFsni6QGmyn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYoJh907ECAP6k7WiS+ajq/O4RANiKCUX5HiUCgl8wodvFYFmHLsIIQxEfzNWZ6KyJkn73RZSWf4L9mc3Ohf3r2pJ+MtFiOIXhCRsyfyvKwdKwlXvgno1Y4RpOlCnrLaS2S6pfiOBZGFYxmOuuC0R6ZFdzE6y/rI4/tXDeZD0d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=EypS0vj4; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="EypS0vj4"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA6Ego3332841;
	Thu, 30 Jul 2026 10:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=+gzTZcYKKcGbuW+pqjc5AqixIOglEGXpJkXzsWq8nRI=; b=
	EypS0vj4j0orNzGF/KzovOIwR7Tvehve/EYmaa8Zt98ZzsLyGndDTWRF9l9TUgS7
	CmwO6syw8R3XPQiraJoMnSp0F4vxT8Kyue9pnihKPmeQfdLwdGOQXHYWhPzHQXZ1
	xEYZWbcysvOtqFzhEeQevzRr/QKuOc4B2+fJZj6/3nwwUckdxXwGaUJrewgPOPrY
	MYMcDj7eyQizQ5O9PZ/8Wsu5nymB//T7/yZWF99464gq2TXMbQB3kQTRQKoA5Drr
	dhQqtxv5r15W/WCrq+SY6Ib+HA/G5RXfYA+GjbPrMkGPyDrSpMyi1yw/FPi2hTuA
	NqTugsQMWYKc2w2JHrgqfA==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnbe-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:53 +0000 (GMT)
Received: from ambtw-mbx5.ambarella.net (10.2.4.226) by
 ambus-ex-se1.ambarella.net (10.1.4.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:51 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-mbx5.ambarella.net (10.2.4.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 30 Jul 2026 18:43:51 +0800
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:49 +0800
From: Long Zhao <longzhao@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <soc@lists.linux.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>, <linux-gpio@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        Long Zhao
	<longzhao@ambarella.com>
Subject: [PATCH 09/10] arm64: ambarella: add ARCH_AMBARELLA and CV75 EVK DT
Date: Thu, 30 Jul 2026 18:43:29 +0800
Message-ID: <20260730104330.81367-10-longzhao@ambarella.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104330.81367-1-longzhao@ambarella.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: 7iVuJU1wFZ8xt2K9BjmpOC4VqnQ_cME0
X-Proofpoint-ORIG-GUID: 7iVuJU1wFZ8xt2K9BjmpOC4VqnQ_cME0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX1kZdpEh1brac
 Ag8RVpxQRKhAu1Nx4soZkbE0nRZlYm4G/OgSG6Vh9DlXiSQdpQnd01Oz6ugUvexXhGgfotcco9Z
 XiDGiBTfl5DZRS3vKiV0jTbOA4ARwr9sjHi4YkgPnO3oC7QMDKdiWbXdP4zdn/w75NcGBtzijst
 SprQSAIx1EvmJyqKuIZUpsJtMgATYQYCmDOHpFxVCQI1/zvD+VRcjVbDTTkEBNW057UhGyIMIBE
 /x9HI7h2YQkpWfq7w/U3Pzh/qmGeVArKbv+JDyF1/98t/ksLqXdAmXzqYAvlgEAUcEzZmSyDtaZ
 d3naM50As3uXuNBsLH1KkD9ONoSXiuIVHu2y0MYTnpss02+HT9WODhYDRqO2Z5JiTDrNPNM76Jb
 mWUhClTW/OqULUsGgvpG85d9sliZqqsHgrIDH0Lenhh2wG443+ynKQFW6xS0fncq0JvV21w6NH5
 hoA7f2VjEbd4qgeMKcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfXwvJdxdH7d1NR
 09X9kNmYAkSstZD1MMdOtbvIoc4sLWAgInJ90aWHnnPJIRzHis3rHJ6Bug2suB+qZ9ti92XpyYu
 9MWalWfxna6AqrrmfE1Baisa4hOiyZUUHQDUgQWP2fXrpRqNomNM
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2ae9 cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=ppJngBeKAAAA:8 a=NuV0J3eQuBn1ZHJjGOEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

Enable the Ambarella ARMv8 platform Kconfig, add the CV75 SoC and
EVK device trees, and select the Ambarella UART in the arm64
defconfig for console bring-up.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 arch/arm64/Kconfig.platforms               |   9 ++
 arch/arm64/boot/dts/Makefile               |   1 +
 arch/arm64/boot/dts/ambarella/Makefile     |   3 +
 arch/arm64/boot/dts/ambarella/cv75-evk.dts |  30 ++++
 arch/arm64/boot/dts/ambarella/cv75.dtsi    | 151 +++++++++++++++++++++
 arch/arm64/configs/defconfig               |   3 +
 6 files changed, 197 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ambarella/Makefile
 create mode 100644 arch/arm64/boot/dts/ambarella/cv75-evk.dts
 create mode 100644 arch/arm64/boot/dts/ambarella/cv75.dtsi

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d2acfac73003..166430ddb3c9 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -26,6 +26,15 @@ config ARCH_SUNXI
        help
          This enables support for Allwinner sunxi based SoCs like the A64.

+config ARCH_AMBARELLA
+       bool "Ambarella SoC family"
+       select ARM_PSCI
+       select HAVE_ARM_ARCH_TIMER
+       select PINCTRL
+       select PINCTRL_AMB
+       help
+         This enables support for the ARM64 based Ambarella SoCs like CV75=
.
+
 config ARCH_ALPINE
        bool "Annapurna Labs Alpine platform"
        select ALPINE_MSI if PCI
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index fc726b215f12..f1709eb5d915 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -4,6 +4,7 @@ subdir-y +=3D airoha
 subdir-y +=3D allwinner
 subdir-y +=3D altera
 subdir-y +=3D amazon
+subdir-y +=3D ambarella
 subdir-y +=3D amd
 subdir-y +=3D amlogic
 subdir-y +=3D apm
diff --git a/arch/arm64/boot/dts/ambarella/Makefile b/arch/arm64/boot/dts/a=
mbarella/Makefile
new file mode 100644
index 000000000000..ddca3d7b18cc
--- /dev/null
+++ b/arch/arm64/boot/dts/ambarella/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_AMBARELLA) +=3D cv75-evk.dtb
diff --git a/arch/arm64/boot/dts/ambarella/cv75-evk.dts b/arch/arm64/boot/d=
ts/ambarella/cv75-evk.dts
new file mode 100644
index 000000000000..42a0fe24b83b
--- /dev/null
+++ b/arch/arm64/boot/dts/ambarella/cv75-evk.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Ambarella CV75 EVK board
+ */
+
+/dts-v1/;
+
+#include "cv75.dtsi"
+
+/ {
+       model =3D "Ambarella CV75 EVK Board";
+       compatible =3D "ambarella,cv75-evk", "ambarella,cv75";
+
+       aliases {
+               serial0 =3D &uart0;
+       };
+
+       chosen {
+               stdout-path =3D &uart0;
+       };
+
+       memory@200000 {
+               device_type =3D "memory";
+               reg =3D <0x0 0x00200000 0x0 0x07e00000>;
+       };
+};
+
+&uart0 {
+       status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/ambarella/cv75.dtsi b/arch/arm64/boot/dts/=
ambarella/cv75.dtsi
new file mode 100644
index 000000000000..7c6a61f473ef
--- /dev/null
+++ b/arch/arm64/boot/dts/ambarella/cv75.dtsi
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Ambarella CV75 SoC
+ *
+ * Boot peripheral: UART0 console.
+ * Clocks: a single ambarella,cv75-rct provider.
+ */
+
+#include <dt-bindings/clock/ambarella,cv75-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/ambarella,pinctrl.h>
+
+/ {
+       compatible =3D "ambarella,cv75";
+       interrupt-parent =3D <&gic>;
+       #address-cells =3D <2>;
+       #size-cells =3D <2>;
+
+       osc: oscillator {
+               compatible =3D "fixed-clock";
+               #clock-cells =3D <0>;
+               clock-output-names =3D "osc";
+               clock-frequency =3D <24000000>;
+       };
+
+       psci {
+               compatible =3D "arm,psci-0.2";
+               method =3D "smc";
+       };
+
+       cpus {
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+
+               cpu@0 {
+                       compatible =3D "arm,cortex-a76";
+                       device_type =3D "cpu";
+                       reg =3D <0x000>;
+                       enable-method =3D "psci";
+               };
+
+               cpu@1 {
+                       compatible =3D "arm,cortex-a76";
+                       device_type =3D "cpu";
+                       reg =3D <0x100>;
+                       enable-method =3D "psci";
+               };
+       };
+
+       gic: interrupt-controller@fff0100000 {
+               compatible =3D "arm,gic-400";
+               #interrupt-cells =3D <3>;
+               #address-cells =3D <0>;
+               #size-cells =3D <1>;
+               interrupt-controller;
+               reg =3D <0xff 0xf0101000 0x0 0x1000>,
+                     <0xff 0xf0102000 0x0 0x2000>,
+                     <0xff 0xf0104000 0x0 0x2000>,
+                     <0xff 0xf0106000 0x0 0x2000>;
+               interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYP=
E_LEVEL_HIGH)>;
+       };
+
+       timer {
+               compatible =3D "arm,armv8-timer";
+               interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TY=
PE_LEVEL_LOW)>,
+                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE=
_LEVEL_LOW)>,
+                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE=
_LEVEL_LOW)>,
+                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE=
_LEVEL_LOW)>;
+       };
+
+       soc {
+               compatible =3D "simple-bus";
+               #address-cells =3D <2>;
+               #size-cells =3D <2>;
+               ranges;
+
+               /* Clock provider and shared system registers. */
+               rct: clock-controller@ffed080000 {
+                       compatible =3D "ambarella,cv75-rct", "syscon";
+                       reg =3D <0xff 0xed080000 0x0 0x1000>;
+                       clocks =3D <&osc>;
+                       clock-names =3D "osc";
+                       #clock-cells =3D <1>;
+
+                       assigned-clocks =3D <&rct CV75_GCLK_UART0>;
+                       assigned-clock-parents =3D <&osc>;
+                       assigned-clock-rates =3D <24000000>;
+               };
+
+               apb@ffe4000000 {
+                       compatible =3D "simple-bus";
+                       #address-cells =3D <1>;
+                       #size-cells =3D <1>;
+                       reg =3D <0xff 0xe4000000 0x0 0x01000000>;
+                       ranges =3D <0xe4000000 0xff 0xe4000000 0x01000000>;
+
+                       uart0: serial@e4000000 {
+                               compatible =3D "ambarella,cv75-uart", "amba=
rella,uart";
+                               reg =3D <0xe4000000 0x1000>;
+                               interrupts =3D <GIC_SPI 170 IRQ_TYPE_LEVEL_=
HIGH>;
+                               clocks =3D <&rct CV75_GCLK_UART0>;
+                               pinctrl-names =3D "default";
+                               pinctrl-0 =3D <&uart0_pins>;
+                               status =3D "disabled";
+                       };
+
+                       pinctrl: pinctrl@e4013000 {
+                               compatible =3D "ambarella,cv75-pinctrl";
+                               #address-cells =3D <1>;
+                               #size-cells =3D <0>;
+                               reg =3D <0xe4013000 0x1000>, <0xe4014000 0x=
1000>,
+                                     <0xe4015000 0x1000>, <0xe4010000 0x10=
00>;
+                               reg-names =3D "gpio0", "gpio1", "gpio2", "i=
omux";
+                               interrupts =3D <GIC_SPI 163 IRQ_TYPE_LEVEL_=
HIGH>,
+                                            <GIC_SPI 164 IRQ_TYPE_LEVEL_HI=
GH>,
+                                            <GIC_SPI 165 IRQ_TYPE_LEVEL_HI=
GH>;
+                               ambarella,drive-strength-syscon =3D <&rct>;
+                               ambarella,pull-syscon =3D <&s_scratchpad_sy=
scon>;
+
+                               gpio: gpio@0 {
+                                       reg =3D <0>;
+                                       gpio-controller;
+                                       #gpio-cells =3D <2>;
+                                       gpio-ranges =3D <&pinctrl 0 0 95>;
+                                       interrupt-controller;
+                                       #interrupt-cells =3D <2>;
+                               };
+
+                               uart0_pins: uart0-pins {
+                                       function =3D "uart0";
+                                       pinmux =3D <AMBA_PINMUX(44, 1)>,
+                                                <AMBA_PINMUX(45, 1)>;
+                               };
+                       };
+               };
+
+               ahb@ffe0000000 {
+                       compatible =3D "simple-bus";
+                       #address-cells =3D <1>;
+                       #size-cells =3D <1>;
+                       reg =3D <0xff 0xe0000000 0x0 0x01000000>;
+                       ranges =3D <0xe0000000 0xff 0xe0000000 0x01000000>;
+
+                       s_scratchpad_syscon: scratchpad@e002e000 {
+                               compatible =3D "ambarella,cv75-sec-scratchp=
ad",
+                                            "ambarella,sec-scratchpad", "s=
yscon";
+                               reg =3D <0xe002e000 0x1000>;
+                       };
+               };
+       };
+};
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ad3bd3d9507b..64e8fbe43d27 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -36,6 +36,7 @@ CONFIG_CRASH_DUMP=3Dy
 CONFIG_ARCH_ACTIONS=3Dy
 CONFIG_ARCH_AIROHA=3Dy
 CONFIG_ARCH_SUNXI=3Dy
+CONFIG_ARCH_AMBARELLA=3Dy
 CONFIG_ARCH_ALPINE=3Dy
 CONFIG_ARCH_APPLE=3Dy
 CONFIG_ARCH_ARTPEC=3Dy
@@ -567,6 +568,8 @@ CONFIG_SERIAL_8250_OMAP=3Dy
 CONFIG_SERIAL_8250_MT6577=3Dy
 CONFIG_SERIAL_8250_UNIPHIER=3Dy
 CONFIG_SERIAL_OF_PLATFORM=3Dy
+CONFIG_SERIAL_AMBARELLA=3Dy
+CONFIG_SERIAL_AMBARELLA_CONSOLE=3Dy
 CONFIG_SERIAL_AMBA_PL011=3Dy
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
 CONFIG_SERIAL_MESON=3Dy
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
