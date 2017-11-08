From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 5/5] serial: imx: Support common rs485 binding for RTS
 polarity
Date: Wed, 8 Nov 2017 11:32:34 +0100
Message-ID: <09cf8d413f79810dbd5e5b255774a5c2c2b5ffde.1510134353.git.lukas@wunner.de>
References: <cover.1510134353.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510134353.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Invoke the ->rs485_config callback on probe to adjust the initial RTS
polarity based on the UART's device properties.

This implicitly fixes a bug:  If RTS control is not available, rs485
should be disabled even if it was enabled through a device property.
Log an error when that occurs.

Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
 drivers/tty/serial/imx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 52456fb2bff9..50d4fdcd1aec 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2087,7 +2087,6 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.fifosize = 32;
 	sport->port.ops = &imx_pops;
 	sport->port.rs485_config = imx_rs485_config;
-	sport->port.rs485.flags |= SER_RS485_RTS_ON_SEND;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	setup_timer(&sport->timer, imx_timeout, (unsigned long)sport);
 
@@ -2120,6 +2119,12 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	uart_get_rs485_mode(&pdev->dev, &sport->port.rs485);
 
+	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
+	    (!sport->have_rtscts || !sport->have_rtsgpio))
+		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
+
+	imx_rs485_config(&sport->port, &sport->port.rs485);
+
 	/* Disable interrupts before requesting them */
 	reg = readl_relaxed(sport->port.membase + UCR1);
 	reg &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN |
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
