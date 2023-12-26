Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92544D59D
	for <linux-serial@vger.kernel.org>; Tue, 26 Dec 2023 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="srbnVsuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1703590697;
	bh=cTYZnolMy6/vuQX8IJdP7c6GwOYsDzvjJU1D80G9LCM=;
	h=From:To:CC:Subject:Date:From;
	b=srbnVsukY8k5t9RmiNa/qzBdNXzZsbrxG2fmNq8DmI/3NlqF1q7ATOuWNOHmUUUIu
	 ilSaGOjX5m/XyPIDAunx/KGLcBPmjQFOtLV4EuLQ+SX87ZgHwQ3OwkGNIcx0lGlwcC
	 bPxlNlQQOJiXfvGGOMIHc4Q4oapibmi/71fxUeN738iOq80nVgwjA/gplHyI+Xliv8
	 RyynAokAzwQ9n93Dmv0aQRYgZegH0gyJ+hIRwD6JFbvjXfbC2wfhZE0TnE7AkhG1a2
	 NlmM0LESC4sDdMDuLUJMfXZ/EuFBBy24Thq9BE3NQJClaIdjlCIeQp72VIoYOemGUc
	 cLln+FeX+V2AQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Marek Vasut
	<marex@denx.de>, Fabio Estevam <festevam@denx.de>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, Sergey Organov <sorganov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Rob
 Herring" <robh@kernel.org>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Tom Rix <trix@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH V2] serial: imx: Ensure that imx_uart_rs485_config() is called with enabled clock
Date: Tue, 26 Dec 2023 12:36:47 +0100
Message-ID: <20231226113647.39376-1-cniedermaier@dh-electronics.com>
X-klartext: yes
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

There are register accesses in the function imx_uart_rs485_config(). The
clock must be enabled for these accesses. This was ensured by calling it
via the function uart_rs485_config() in the probe() function within the
range where the clock is enabled. With the commit 7c7f9bc986e6 ("serial:
Deassert Transmit Enable on probe in driver-specific way") it was removed
from the probe() function and is now only called through the function
uart_add_one_port() which is located at the end of the probe() function.
But the clock is already switched off in this area. To ensure that the
clock is enabled during register access, move the disabling of the clock
to the very end of the probe() function. To avoid leaking enabled clocks
on error also add an error path for exiting with disabling the clock.

Fixes: 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in driver-specific way")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Sergey Organov <sorganov@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Avoid leaking enabled clocks on error path
    - Adapt commit message
---
 drivers/tty/serial/imx.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e7e952bb7bb8..c2fec44c28e8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2332,10 +2332,8 @@ static int imx_uart_probe(struct platform_device *pdev)
 	}
 
 	ret = uart_get_rs485_mode(&sport->port);
-	if (ret) {
-		clk_disable_unprepare(sport->clk_ipg);
-		return ret;
-	}
+	if (ret)
+		goto err_clk;
 
 	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
 	    (!sport->have_rtscts && !sport->have_rtsgpio))
@@ -2419,8 +2417,6 @@ static int imx_uart_probe(struct platform_device *pdev)
 		imx_uart_writel(sport, ucr3, UCR3);
 	}
 
-	clk_disable_unprepare(sport->clk_ipg);
-
 	hrtimer_init(&sport->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hrtimer_init(&sport->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sport->trigger_start_tx.function = imx_trigger_start_tx;
@@ -2436,7 +2432,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request rx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, txirq, imx_uart_txint, 0,
@@ -2444,7 +2440,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request tx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
@@ -2452,14 +2448,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request rts irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 	} else {
 		ret = devm_request_irq(&pdev->dev, rxirq, imx_uart_int, 0,
 				       dev_name(&pdev->dev), sport);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request irq: %d\n", ret);
-			return ret;
+			goto err_clk;
 		}
 	}
 
@@ -2467,7 +2463,12 @@ static int imx_uart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sport);
 
-	return uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+
+err_clk:
+	clk_disable_unprepare(sport->clk_ipg);
+
+	return ret;
 }
 
 static void imx_uart_remove(struct platform_device *pdev)
-- 
2.11.0

