From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/8] ARM: imx: fix struct clk pointer comparing
Date: Wed, 25 Feb 2015 22:53:32 +0800
Message-ID: <1424876018-17852-3-git-send-email-shawn.guo@linaro.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-serial@vger.kernel.org

Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
instances"), clk API users can no longer check if two struct clk
pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
simply comparing two pointers.  That's because with the per-user clk
change, a brand new struct clk is created whenever clients try to look
up the clock by calling clk_get() or sister functions like clk_get_sys()
and of_clk_get().  This changes the original behavior where the struct
clk is only created for once when clock driver registers the clock to
CCF in the first place.  The net change here is before commit
035a61c314eb the struct clk pointer is unique for given hardware
clock, while after the commit the pointers returned by clk lookup calls
become different for the same hardware clock.

That said, the struct clk pointer comparing in the code doesn't work any
more.  Call helper function clk_is_match() instead to fix the problem.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4ad6e473cf83..9de3412af406 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -211,8 +211,9 @@ static void __init imx6q_1588_init(void)
 	 * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
 	 * (external OSC), and we need to clear the bit.
 	 */
-	clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
-				       IMX6Q_GPR1_ENET_CLK_SEL_PAD;
+	clksel = clk_is_match(ptp_clk, enet_ref) ?
+				IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
+				IMX6Q_GPR1_ENET_CLK_SEL_PAD;
 	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (!IS_ERR(gpr))
 		regmap_update_bits(gpr, IOMUXC_GPR1,
-- 
1.9.1

