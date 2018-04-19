From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Subject: [PATCH] Check for an error when the clock is enabled.
Date: Thu, 19 Apr 2018 15:02:28 +0200
Message-ID: <20180419130228.rdee6hwsjcui5py7@agrajag.zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ldv-project@linuxtesting.org, sil2review@lists.osadl.org
List-Id: linux-serial@vger.kernel.org

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 0814e8d5da2b sc16is7xx: enable the clock
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/tty/serial/sc16is7xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 65792a3539d0..243c96025053 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1168,7 +1168,10 @@ static int sc16is7xx_probe(struct device *dev,
 		else
 			return PTR_ERR(s->clk);
 	} else {
-		clk_prepare_enable(s->clk);
+		ret = clk_prepare_enable(s->clk);
+		if (ret)
+			return ret;
+
 		freq = clk_get_rate(s->clk);
 	}
 
-- 
2.17.0
