From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/8] clk: add helper function clk_is_match()
Date: Wed, 25 Feb 2015 22:53:31 +0800
Message-ID: <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
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

A number of client drivers detecting if two struct clk pointers point to
the same one hardware clock by comparing the pointers are broken now.
As a stop-gap solution, this patch adds a helper function clk_is_match()
to test if two struct clk pointers point to the same hardware clock, so
that these client drivers can use to fix the regression.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk.c   |  6 ++++++
 include/linux/clk.h | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index eb0152961d3c..7df4826d9c7b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -597,6 +597,12 @@ struct clk *__clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_parent);
 
+bool clk_is_match(struct clk *clk1, struct clk *clk2)
+{
+	return __clk_get_hw(clk1) == __clk_get_hw(clk2) ? true : false;
+}
+EXPORT_SYMBOL_GPL(clk_is_match);
+
 static struct clk_core *clk_core_get_parent_by_index(struct clk_core *clk,
 							 u8 index)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 8381bbfbc308..f8a8a6dd6a98 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -376,6 +376,17 @@ struct clk *clk_get_parent(struct clk *clk);
  */
 struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
+/**
+ * clk_is_match - test if two given struct clk pointers point to the same
+ * 		  hardware clock, i.e. struct clk_hw.
+ * @clk1: the first clk
+ * @clk2: the second clk
+ *
+ * Returns true if two clk pointers point to the same hardware clock,
+ * or false otherwise.
+ */
+bool clk_is_match(struct clk *clk1, struct clk *clk2);
+
 #else /* !CONFIG_HAVE_CLK */
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
@@ -429,6 +440,11 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 	return NULL;
 }
 
+static inline bool clk_is_match(struct clk *clk1, struct clk *clk2)
+{
+	return clk1 == clk2 ? true : false;
+}
+
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
-- 
1.9.1

