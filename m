From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
Date: Tue, 12 Jun 2018 13:40:28 +0800
Message-ID: <20180612054034.4969-2-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@intel.com
Cc: linux-mips@linux-mips.org, qi-ming.wu@intel.com, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Songjun Wu <songjun.wu@linux.intel.com>, James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

Previous implementation uses a hard-coded register value to check if
the current serial entity is the console entity.
Now the lantiq serial driver uses the aliases for the index of the
serial port.
The lantiq danube serial dts are updated with aliases to support this.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
index 2dd950181f8a..7a9e15da6bd0 100644
--- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -4,6 +4,10 @@
 	#size-cells = <1>;
 	compatible = "lantiq,xway", "lantiq,danube";
 
+	aliases {
+		serial0 = &asc1;
+	};
+
 	cpus {
 		cpu@0 {
 			compatible = "mips,mips24Kc";
@@ -74,7 +78,7 @@
 			reg = <0xE100A00 0x100>;
 		};
 
-		serial@E100C00 {
+		asc1: serial@E100C00 {
 			compatible = "lantiq,asc";
 			reg = <0xE100C00 0x400>;
 			interrupt-parent = <&icu0>;
-- 
2.11.0
