From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH v2 06/18] MIPS: dts: Change upper case to lower case
Date: Fri,  3 Aug 2018 11:02:25 +0800
Message-ID: <20180803030237.3366-7-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Songjun Wu <songjun.wu@linux.intel.com>, James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Paul Burton <paul.burton@mips.com>, Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

All the upper case in unit-address and hex constants are
changed to lower case according to the Linux conventions.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 arch/mips/boot/dts/lantiq/danube.dtsi   | 42 ++++++++++++++++-----------------
 arch/mips/boot/dts/lantiq/easy50712.dts | 14 +++++------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
index 2dd950181f8a..510be63c8bdf 100644
--- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -10,12 +10,12 @@
 		};
 	};
 
-	biu@1F800000 {
+	biu@1f800000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "lantiq,biu", "simple-bus";
-		reg = <0x1F800000 0x800000>;
-		ranges = <0x0 0x1F800000 0x7FFFFF>;
+		reg = <0x1f800000 0x800000>;
+		ranges = <0x0 0x1f800000 0x7fffff>;
 
 		icu0: icu@80200 {
 			#interrupt-cells = <1>;
@@ -24,18 +24,18 @@
 			reg = <0x80200 0x120>;
 		};
 
-		watchdog@803F0 {
+		watchdog@803f0 {
 			compatible = "lantiq,wdt";
-			reg = <0x803F0 0x10>;
+			reg = <0x803f0 0x10>;
 		};
 	};
 
-	sram@1F000000 {
+	sram@1f000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "lantiq,sram";
-		reg = <0x1F000000 0x800000>;
-		ranges = <0x0 0x1F000000 0x7FFFFF>;
+		reg = <0x1f000000 0x800000>;
+		ranges = <0x0 0x1f000000 0x7fffff>;
 
 		eiu0: eiu@101000 {
 			#interrupt-cells = <1>;
@@ -66,41 +66,41 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "lantiq,fpi", "simple-bus";
-		ranges = <0x0 0x10000000 0xEEFFFFF>;
-		reg = <0x10000000 0xEF00000>;
+		ranges = <0x0 0x10000000 0xeefffff>;
+		reg = <0x10000000 0xef00000>;
 
-		gptu@E100A00 {
+		gptu@e100a00 {
 			compatible = "lantiq,gptu-xway";
-			reg = <0xE100A00 0x100>;
+			reg = <0xe100a00 0x100>;
 		};
 
-		serial@E100C00 {
+		serial@e100c00 {
 			compatible = "lantiq,asc";
-			reg = <0xE100C00 0x400>;
+			reg = <0xe100c00 0x400>;
 			interrupt-parent = <&icu0>;
 			interrupts = <112 113 114>;
 		};
 
-		dma0: dma@E104100 {
+		dma0: dma@e104100 {
 			compatible = "lantiq,dma-xway";
-			reg = <0xE104100 0x800>;
+			reg = <0xe104100 0x800>;
 		};
 
-		ebu0: ebu@E105300 {
+		ebu0: ebu@e105300 {
 			compatible = "lantiq,ebu-xway";
-			reg = <0xE105300 0x100>;
+			reg = <0xe105300 0x100>;
 		};
 
-		pci0: pci@E105400 {
+		pci0: pci@e105400 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			compatible = "lantiq,pci-xway";
 			bus-range = <0x0 0x0>;
 			ranges = <0x2000000 0 0x8000000 0x8000000 0 0x2000000	/* pci memory */
-				  0x1000000 0 0x00000000 0xAE00000 0 0x200000>; /* io space */
+				  0x1000000 0 0x00000000 0xae00000 0 0x200000>; /* io space */
 			reg = <0x7000000 0x8000		/* config space */
-				0xE105400 0x400>;	/* pci bridge */
+				0xe105400 0x400>;	/* pci bridge */
 		};
 	};
 };
diff --git a/arch/mips/boot/dts/lantiq/easy50712.dts b/arch/mips/boot/dts/lantiq/easy50712.dts
index c37a33962f28..1ce20b7d05cb 100644
--- a/arch/mips/boot/dts/lantiq/easy50712.dts
+++ b/arch/mips/boot/dts/lantiq/easy50712.dts
@@ -52,14 +52,14 @@
 			};
 		};
 
-		gpio: pinmux@E100B10 {
+		gpio: pinmux@e100b10 {
 			compatible = "lantiq,danube-pinctrl";
 			pinctrl-names = "default";
 			pinctrl-0 = <&state_default>;
 
 			#gpio-cells = <2>;
 			gpio-controller;
-			reg = <0xE100B10 0xA0>;
+			reg = <0xe100b10 0xa0>;
 
 			state_default: pinmux {
 				stp {
@@ -82,26 +82,26 @@
 			};
 		};
 
-		etop@E180000 {
+		etop@e180000 {
 			compatible = "lantiq,etop-xway";
-			reg = <0xE180000 0x40000>;
+			reg = <0xe180000 0x40000>;
 			interrupt-parent = <&icu0>;
 			interrupts = <73 78>;
 			phy-mode = "rmii";
 			mac-address = [ 00 11 22 33 44 55 ];
 		};
 
-		stp0: stp@E100BB0 {
+		stp0: stp@e100bb0 {
 			#gpio-cells = <2>;
 			compatible = "lantiq,gpio-stp-xway";
 			gpio-controller;
-			reg = <0xE100BB0 0x40>;
+			reg = <0xe100bb0 0x40>;
 
 			lantiq,shadow = <0xfff>;
 			lantiq,groups = <0x3>;
 		};
 
-		pci@E105400 {
+		pci@e105400 {
 			lantiq,bus-clock = <33333333>;
 			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
-- 
2.11.0
