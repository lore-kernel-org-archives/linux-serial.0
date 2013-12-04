From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] serial: samsung: move clock deactivation below uart registration
Date: Thu, 5 Dec 2013 00:54:38 +0100
Message-ID: <201312050054.39327.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-serial@vger.kernel.org

Commit 60e93575476f (serial: samsung: enable clock before clearing pending
interrupts during init) added handling of the controller clock during init.

On most systems this clock is also one of the baud_clock sources and
possibly used by the earlycon and thus already enabled by the bootloader.

Therefore a gap exists between s3c24xx_serial_init_port disabling the
clock and an attached console reenabling it, making the transition from
earlycon to regular console possibly hang the system - as seen on my
S3C2442 based Freerunner today.

Therefore move the disabling of the clock from s3c24xx_serial_init_port
below the uart port registration, effectively creating an overlap and
keeping the clock running non-stop if the console wants to grab this port.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/tty/serial/samsung.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c1af04d..9cd706d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1209,7 +1209,6 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	/* reset the fifos (and setup the uart) */
 	s3c24xx_serial_resetport(port, cfg);
-	clk_disable_unprepare(ourport->clk);
 	return 0;
 }
 
@@ -1287,6 +1286,13 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
 	platform_set_drvdata(pdev, &ourport->port);
 
+	/*
+	 * Deactivate the clock enabled in s3c24xx_serial_init_port here,
+	 * so that a potential re-enablement through the pm-callback overlaps
+	 * and keeps the clock enabled in this case.
+	 */
+	clk_disable_unprepare(ourport->clk);
+
 #ifdef CONFIG_SAMSUNG_CLOCK
 	ret = device_create_file(&pdev->dev, &dev_attr_clock_source);
 	if (ret < 0)
-- 
1.7.10.4
