From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] serial: sh-sci: Stop using printk format %pCr
Date: Fri,  1 Jun 2018 11:28:21 +0200
Message-ID: <1527845302-12159-4-git-send-email-geert+renesas@glider.be>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by open-coding the operation.  This is safe here, as the code
runs in task context.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b46b146524ce7495..c181eb37f98509e6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2724,8 +2724,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			dev_dbg(dev, "failed to get %s (%ld)\n", clk_names[i],
 				PTR_ERR(clk));
 		else
-			dev_dbg(dev, "clk %s is %pC rate %pCr\n", clk_names[i],
-				clk, clk);
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", clk_names[i],
+				clk, clk_get_rate(clk));
 		sci_port->clks[i] = IS_ERR(clk) ? NULL : clk;
 	}
 	return 0;
-- 
2.7.4
