From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 6/9] serial: 8250_dw: Add support for
 deferred probing
Date: Thu,  3 Jul 2014 22:55:46 +0800
Message-ID: <1404399349-20237-7-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBA662WOQKGQEYELLW6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1404399349-20237-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The 8250_dw driver fails to probe if the specified clock isn't
registered at probe time. Even if a clock frequency is given,
the required clock might be gated because it wasn't properly
enabled.

This happened to me when the device is registered through DT,
and the clock was part of an MFD, the PRCM found on A31 and A23
SoCs. Unlike core clocks that are registered with OF_CLK_DECLARE,
which happen almost immediately after the kernel starts, the
clocks are registered as sub-devices of the PRCM MFD platform
device. Even though devices are registered in the order they are
found in the DT, the drivers are registered in a different,
arbitrary order. It is possible that the 8250_dw driver is
registered, and thus associated with the device and probed, before
the clock driver is registered and probed.

8250_dw then reports unable to get the clock, and fails. Without
a working console, the kernel panics.

This patch adds support for deferred probe handling for the clock
and reset controller.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index cb1b3dc..d9eeed7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -405,12 +405,16 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	data->usr_reg = DW_UART_USR;
 	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 	if (!IS_ERR(data->clk)) {
 		clk_prepare_enable(data->clk);
 		uart.port.uartclk = clk_get_rate(data->clk);
 	}
 
 	data->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(data->rst) && PTR_ERR(data->rst) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 	if (!IS_ERR(data->rst))
 		reset_control_deassert(data->rst);
 
-- 
2.0.1
