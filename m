From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Subject: [PATCH] serial: 8250_dw: Disable clock on error
Date: Wed, 6 Dec 2017 16:46:12 +0100
Message-ID: <20171206154612.ix5rtsvj5k6ldwz3@agrajag.zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

If there is no clock rate for uartclk defined, disable the previously
enabled clock again.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 23f5b3fdd04e serial: 8250_dw: only get the clock rate in one place
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5bb0c42c88dd..bda75d317d24 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -515,7 +515,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_clk;
 	}
 
 	data->pclk = devm_clk_get(dev, "apb_pclk");
-- 
2.15.1
