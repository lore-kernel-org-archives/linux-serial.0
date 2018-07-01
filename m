From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 015/101] clk: renesas: cpg-mssr: Stop using printk format %pCr
Date: Sun,  1 Jul 2018 18:21:01 +0200
Message-ID: <20180701160757.744559346@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ef4b0be62641d296cf4c0ad8f75ab83ab066ed51 upstream.

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by open-coding the operation.  This is safe here, as the code
runs in task context.

Link: http://lkml.kernel.org/r/1527845302-12159-2-git-send-email-geert+renesas@glider.be
To: Jia-Ju Bai <baijiaju1990@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>
To: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org # 4.5+
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/renesas/renesas-cpg-mssr.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -243,8 +243,9 @@ struct clk *cpg_mssr_clk_src_twocell_get
 		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
 		       PTR_ERR(clk));
 	else
-		dev_dbg(dev, "clock (%u, %u) is %pC at %pCr Hz\n",
-			clkspec->args[0], clkspec->args[1], clk, clk);
+		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
+			clkspec->args[0], clkspec->args[1], clk,
+			clk_get_rate(clk));
 	return clk;
 }
 
@@ -304,7 +305,7 @@ static void __init cpg_mssr_register_cor
 	if (IS_ERR_OR_NULL(clk))
 		goto fail;
 
-	dev_dbg(dev, "Core clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	return;
 
@@ -372,7 +373,7 @@ static void __init cpg_mssr_register_mod
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	return;
 
