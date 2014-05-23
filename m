From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 10/22] clk: sunxi: Add support for PLL6 pre-divider on AHB1
 clock
Date: Fri, 23 May 2014 15:51:13 +0800
Message-ID: <1400831485-28576-11-git-send-email-wens@csie.org>
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

On the A31 and A23, the PLL6 input to the AHB1 clock has a 2 bit wide
pre-divider. This was verified from the A23 user manual and A31/A23 SDK
sources.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 2 ++
 drivers/clk/sunxi/clk-sunxi.c                     | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index b9ec668..ae18ec1 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -21,6 +21,8 @@ Required properties:
 	"allwinner,sun5i-a10s-ahb-gates-clk" - for the AHB gates on A10s
 	"allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
 	"allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
+	"allwinner,sun6i-a31-ahb1-pll6-clk" - for the PLL6 pre-divider to
+					      AHB1 on A31
 	"allwinner,sun6i-a31-ahb1-mux-clk" - for the AHB1 multiplexer on A31
 	"allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
 	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 339cabc..89eadbc 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -686,6 +686,12 @@ static const struct div_data sun4i_apb0_data __initconst = {
 	.width	= 2,
 };
 
+static const struct div_data sun6i_a31_ahb1_pll6_data __initconst = {
+	.shift	= 6,
+	.pow	= 0,
+	.width	= 2,
+};
+
 static const struct div_data sun6i_a31_apb2_div_data __initconst = {
 	.shift	= 0,
 	.pow	= 0,
@@ -1128,6 +1134,7 @@ static const struct of_device_id clk_div_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-a10-axi-clk", .data = &sun4i_axi_data,},
 	{.compatible = "allwinner,sun4i-a10-ahb-clk", .data = &sun4i_ahb_data,},
 	{.compatible = "allwinner,sun4i-a10-apb0-clk", .data = &sun4i_apb0_data,},
+	{.compatible = "allwinner,sun6i-a31-ahb1-pll6-clk", .data = &sun6i_a31_ahb1_pll6_data,},
 	{.compatible = "allwinner,sun6i-a31-apb2-div-clk", .data = &sun6i_a31_apb2_div_data,},
 	{}
 };
-- 
2.0.0.rc2
