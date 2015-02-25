From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/8] clk: add helper function clk_is_match()
Date: Wed, 25 Feb 2015 09:27:57 -0800
Message-ID: <20150225172757.421.43718@quantum>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Quoting Shawn Guo (2015-02-25 06:53:31)
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> simply comparing two pointers.  That's because with the per-user clk
> change, a brand new struct clk is created whenever clients try to look
> up the clock by calling clk_get() or sister functions like clk_get_sys()
> and of_clk_get().  This changes the original behavior where the struct
> clk is only created for once when clock driver registers the clock to
> CCF in the first place.  The net change here is before commit
> 035a61c314eb the struct clk pointer is unique for given hardware
> clock, while after the commit the pointers returned by clk lookup calls
> become different for the same hardware clock.
> 
> A number of client drivers detecting if two struct clk pointers point to
> the same one hardware clock by comparing the pointers are broken now.
> As a stop-gap solution, this patch adds a helper function clk_is_match()
> to test if two struct clk pointers point to the same hardware clock, so
> that these client drivers can use to fix the regression.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Hi Shawn,

Thanks for the patch. I wrote a similar one last night but did not
finish fixing up the drivers (and thus did not post it). I prefer my
implementation below, and I'm happy to merge your driver fixes with it.

Regards,
Mike



From: Michael Turquette <mturquette@linaro.org>
Date: Wed, 25 Feb 2015 09:11:01 -0800
Subject: [PATCH] clk: introduce clk_is_match

Some drivers compare struct clk pointers as a means of knowing
if the two pointers reference the same clock hardware. This behavior is
dubious (drivers must not dereference struct clk), but did not cause any
regressions until the per-user struct clk patch was merged. Now the test
for matching clk's will always fail with per-user struct clk's.

clk_is_match is introduced to fix the regression and prevent drivers
from comparing the pointers manually.

Fixes: 035a61c314eb ("clk: Make clk API return per-user struct clk instances")
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Michael Turquette <mturquette@linaro.org>
---
 drivers/clk/clk.c   | 26 ++++++++++++++++++++++++++
 include/linux/clk.h | 18 ++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index eb01529..09670de 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2171,6 +2171,32 @@ int clk_get_phase(struct clk *clk)
 }
 
 /**
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
+bool clk_is_match(struct clk *p, struct clk *q)
+{
+	/* trivial case: identical struct clk's or both NULL */
+	if (p == q)
+		return true;
+
+	/* true if clk->core pointers match. Avoid derefing garbage */
+	if (!IS_ERR_OR_NULL(p) && !IS_ERR_OR_NULL(q))
+		if (p->core == q->core)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(clk_is_match);
+
+/**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
  * @clk:	clk being initialized
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 8381bbf..5c076e4 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -376,6 +376,19 @@ struct clk *clk_get_parent(struct clk *clk);
  */
 struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
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
 #else /* !CONFIG_HAVE_CLK */
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
@@ -429,6 +442,11 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 	return NULL;
 }
 
+static inline bool clk_is_match(struct clk *p, struct clk *q)
+{
+	return p == q ? true : false;
+}
+
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
-- 
1.9.1
