From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 12/22] ARM: sun6i: DT: Add PLL6 pre-divider clock for AHB1 mux
 input
Date: Fri, 23 May 2014 15:51:15 +0800
Message-ID: <1400831485-28576-13-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On the A31, the PLL6 input to the AHB1 clock has a 2 bit wide
pre-divider. This was verified from the A23 user manual and
A31/A23 SDK sources.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index d9643fa..d8808fe 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -125,11 +125,19 @@
 			clock-output-names = "axi";
 		};
 
+		ahb1_pll6: ahb1_pll6_clk@01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun6i-a31-ahb1-pll6-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&pll6 0>;
+			clock-output-names = "ahb1_pll6";
+		};
+
 		ahb1_mux: ahb1_mux@01c20054 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun6i-a31-ahb1-mux-clk";
 			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
+			clocks = <&osc32k>, <&osc24M>, <&axi>, <&ahb1_pll6>;
 			clock-output-names = "ahb1_mux";
 		};
 
-- 
2.0.0.rc2
