From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] clk: provide clk_is_match() dummy for non-common clk
Date: Sun, 08 Mar 2015 22:05:29 +0100
Message-ID: <8682755.oK0Ae34OOP@wuerfel>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org> <1424876018-17852-2-git-send-email-shawn.guo@linaro.org> <20150225172757.421.43718@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20150225172757.421.43718@quantum>
Sender: linux-pwm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mike Turquette <mturquette@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

ARM randconfig build tests found a new error for configurations
with COMMON_CLK disabled but HAS_CLK selected by the platform:

ERROR: "clk_is_match" [sound/soc/fsl/snd-soc-fsl-spdif.ko] undefined!

This moves the declaration around, so this case is covered
by the existing static inline helper function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c69e182e51d89 ("clk: introduce clk_is_match")
----
BTW, we have a preexisting problem in clk_get_parent,
clk_round_rate and clk_set_parent, which I've worked around in
my randconfig builds so far. Should we do that the same way?

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 5c076e4d90f9..a9b91595d106 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -125,6 +125,19 @@ int clk_set_phase(struct clk *clk, int degrees);
  */
 int clk_get_phase(struct clk *clk);
 
+/**
+ * clk_is_match - check if two clk's point to the same hardware clock
+ * @p: clk compared against q
+ * @q: clk compared against p
+ *
+ * Returns true if the two struct clk pointers both point to the same hardware
+ * clock node. Put differently, returns true if struct clk *p and struct clk *q
+ * share the same struct clk_core object.
+ *
+ * Returns false otherwise. Note that two NULL clks are treated as matching.
+ */
+bool clk_is_match(struct clk *p, struct clk *q);
+
 #else
 
 static inline long clk_get_accuracy(struct clk *clk)
@@ -142,6 +155,11 @@ static inline long clk_get_phase(struct clk *clk)
 	return -ENOTSUPP;
 }
 
+static inline bool clk_is_match(struct clk *p, struct clk *q)
+{
+	return p == q ? true : false;
+}
+
 #endif
 
 /**
@@ -376,19 +394,6 @@ struct clk *clk_get_parent(struct clk *clk);
  */
 struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
-/**
- * clk_is_match - check if two clk's point to the same hardware clock
- * @p: clk compared against q
- * @q: clk compared against p
- *
- * Returns true if the two struct clk pointers both point to the same hardware
- * clock node. Put differently, returns true if struct clk *p and struct clk *q
- * share the same struct clk_core object.
- *
- * Returns false otherwise. Note that two NULL clks are treated as matching.
- */
-bool clk_is_match(struct clk *p, struct clk *q);
-
 #else /* !CONFIG_HAVE_CLK */
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
@@ -442,11 +447,6 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 	return NULL;
 }
 
-static inline bool clk_is_match(struct clk *p, struct clk *q)
-{
-	return p == q ? true : false;
-}
-
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */

