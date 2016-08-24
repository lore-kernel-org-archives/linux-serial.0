From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] serial: 8250_dw: Check the data->pclk when get apb_pclk
Date: Wed, 24 Aug 2016 16:33:33 +0800
Message-ID: <1472027613-6337-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, guohanjun@huawei.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

It should check the data->pclk, not data->clk when get apb_pclk.

Fixes: c8ed99d4f6a8("serial: 8250_dw: Add support for deferred probing")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index e199696..b022f5a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -462,7 +462,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	data->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
-	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER) {
+	if (IS_ERR(data->pclk) && PTR_ERR(data->pclk) == -EPROBE_DEFER) {
 		err = -EPROBE_DEFER;
 		goto err_clk;
 	}
-- 
2.6.0.GIT
