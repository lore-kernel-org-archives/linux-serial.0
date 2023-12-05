Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="HvaqQjcg"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91797101
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 16:51:23 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 153B887239;
	Tue,  5 Dec 2023 01:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701737480;
	bh=5v8+9UPXzKTD4EbtZS10D+tczM83LXSeK3tSgL2cKbw=;
	h=From:To:Cc:Subject:Date:From;
	b=HvaqQjcgHH9ZVjG9FQJ/jmw615LGV4OrfCeSBlFfrQUcj+/Mjgc47/4KQTy3Od+l5
	 9KxLAzJxxddD0DVSxaM4xiNvNDjHRQhIS9nZXGnjRgeFUHPJxjGe6s820yAABTyZkA
	 OYsGIj6l2LSn9yLiR0TD49CvftaBtofbYAnpAt/Zkn7B8vuw+HWxizaoO5CoEs+m8i
	 IDAvMb0P3c86TRyI3JMHMOTvWPk2e47Ys7PMoNIpiSyZp0ZlY4jJY4XqFY3sVf+1Yb
	 8CFiW3wgprrNaQiKGS3C6C3uKPMHxhAEi6kPXLx3Ng9ur3luhqhCWqnvvHsx+2IEWR
	 C7OoBv3/MtIjA==
From: Marek Vasut <marex@denx.de>
To: linux-serial@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sergey Organov <sorganov@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Rix <trix@redhat.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: Fix clock imbalance
Date: Tue,  5 Dec 2023 01:50:57 +0100
Message-ID: <20231205005108.79782-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Disable and unprepare the clock on every exit from probe function
after the clock were prepared and enabled to avoid enable/disable
imbalance.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sergey Organov <sorganov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Rix <trix@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/imx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 52dd8a6b87603..1cce66e5d05d8 100644
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
@@ -2436,7 +2434,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request rx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, txirq, imx_uart_txint, 0,
@@ -2444,7 +2442,7 @@ static int imx_uart_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request tx irq: %d\n",
 				ret);
-			return ret;
+			goto err_clk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, rtsirq, imx_uart_rtsint, 0,
@@ -2452,14 +2450,14 @@ static int imx_uart_probe(struct platform_device *pdev)
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
 
@@ -2468,6 +2466,10 @@ static int imx_uart_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sport);
 
 	return uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+
+err_clk:
+	clk_disable_unprepare(sport->clk_ipg);
+	return ret;
 }
 
 static void imx_uart_remove(struct platform_device *pdev)
-- 
2.42.0

