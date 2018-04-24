From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Subject: [PATCH v2] sc16is7xx: Check for an error when the clock is enabled.
Date: Tue, 24 Apr 2018 18:03:47 +0200
Message-ID: <20180424160346.GB16979@er01809n.ebgroup.elektrobit.com>
References: <20180419130228.rdee6hwsjcui5py7@agrajag.zerfleddert.de>
 <20180423075519.GA13262@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180423075519.GA13262@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, sil2review@lists.osadl.org
List-Id: linux-serial@vger.kernel.org

When the clock is enabled, check if there is an error. Otherwise
clk_get_rate() can be called without enabled clock.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 0814e8d5da2b ("sc16is7xx: enable the clock")
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
