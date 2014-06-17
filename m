From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 05/20] clk: sunxi: Support factor clocks with
 N multiplier factor starting from 1
Date: Tue, 17 Jun 2014 22:52:42 +0800
Message-ID: <1403016777-15121-6-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBDNNQGOQKGQERWTHOGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1403016777-15121-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The PLLs on newer Allwinner SoC's, such as the A31 and A23, have a
N multiplier factor that starts from 1, not 0.

This patch adds an option to the clock driver's config data structures
to define the difference.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/clk/sunxi/clk-factors.c | 5 ++++-
 drivers/clk/sunxi/clk-factors.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 3806d97..399cf4d 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -62,7 +62,10 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
 		p = FACTOR_GET(config->pshift, config->pwidth, reg);
 
 	/* Calculate the rate */
-	rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
+	if (config->n_from_one)
+		rate = (parent_rate * (n + 1) * (k + 1) >> p) / (m + 1);
+	else
+		rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
 
 	return rate;
 }
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 02e1a43..0484a48 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -15,6 +15,7 @@ struct clk_factors_config {
 	u8 mwidth;
 	u8 pshift;
 	u8 pwidth;
+	u8 n_from_one;
 };
 
 struct clk_factors {
-- 
2.0.0
