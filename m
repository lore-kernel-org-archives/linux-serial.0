From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] serial: sccnxp: Fix error handling in sccnxp_probe()
Date: Sat,  2 Sep 2017 23:13:55 +0300
Message-ID: <1504383235-23002-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

sccnxp_probe() returns result of regulator_disable() that may lead
to returning zero, while device is not properly initialized.
Also the driver enables clocks, but it does not disable it.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/tty/serial/sccnxp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index cdd2f942317c..b9c7a904c1ea 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -889,7 +889,16 @@ static int sccnxp_probe(struct platform_device *pdev)
 			goto err_out;
 		uartclk = 0;
 	} else {
-		clk_prepare_enable(clk);
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			goto err_out;
+
+		ret = devm_add_action_or_reset(&pdev->dev,
+				(void(*)(void *))clk_disable_unprepare,
+				clk);
+		if (ret)
+			goto err_out;
+
 		uartclk = clk_get_rate(clk);
 	}
 
@@ -988,7 +997,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 	uart_unregister_driver(&s->uart);
 err_out:
 	if (!IS_ERR(s->regulator))
-		return regulator_disable(s->regulator);
+		regulator_disable(s->regulator);
 
 	return ret;
 }
-- 
2.7.4
