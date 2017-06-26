From: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 13/20] serial: stm32: fix error handling in probe
Date: Mon, 26 Jun 2017 12:49:14 +0000
Message-ID: <1498481318-1894-14-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>

Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
---
 drivers/tty/serial/stm32-usart.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index c54b89d..a62fc95 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -779,8 +779,10 @@ static int stm32_init_port(struct stm32_port *stm32port,
 		return ret;
 
 	stm32port->port.uartclk = clk_get_rate(stm32port->clk);
-	if (!stm32port->port.uartclk)
+	if (!stm32port->port.uartclk) {
+		clk_disable_unprepare(stm32port->clk);
 		ret = -EINVAL;
+	}
 
 	return ret;
 }
@@ -964,7 +966,7 @@ static int stm32_serial_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
 	if (ret)
-		return ret;
+		goto err_uninit;
 
 	ret = stm32_of_dma_rx_probe(stm32port, pdev);
 	if (ret)
@@ -977,6 +979,11 @@ static int stm32_serial_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, &stm32port->port);
 
 	return 0;
+
+err_uninit:
+	clk_disable_unprepare(stm32port->clk);
+
+	return ret;
 }
 
 static int stm32_serial_remove(struct platform_device *pdev)
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
