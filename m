From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 11/14] serial: 8250_dw: simplify optional reset handling
Date: Wed, 15 Mar 2017 12:31:50 +0100
Message-ID: <20170315113150.1299-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 6ee55a2d47bb4..e0215db44e6ee 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -525,12 +525,11 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	data->rst = devm_reset_control_get_optional(dev, NULL);
-	if (IS_ERR(data->rst) && PTR_ERR(data->rst) == -EPROBE_DEFER) {
-		err = -EPROBE_DEFER;
+	if (IS_ERR(data->rst)) {
+		err = PTR_ERR(data->rst);
 		goto err_pclk;
 	}
-	if (!IS_ERR(data->rst))
-		reset_control_deassert(data->rst);
+	reset_control_deassert(data->rst);
 
 	dw8250_quirks(p, data);
 
@@ -562,8 +561,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	return 0;
 
 err_reset:
-	if (!IS_ERR(data->rst))
-		reset_control_assert(data->rst);
+	reset_control_assert(data->rst);
 
 err_pclk:
 	if (!IS_ERR(data->pclk))
@@ -584,8 +582,7 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->line);
 
-	if (!IS_ERR(data->rst))
-		reset_control_assert(data->rst);
+	reset_control_assert(data->rst);
 
 	if (!IS_ERR(data->pclk))
 		clk_disable_unprepare(data->pclk);
-- 
2.11.0
