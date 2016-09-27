From: =?UTF-8?B?64Ko7JiB66+8?= <youngmin.nam@samsung.com>
Subject: [PATCH] serial: samsung: add clock controls in
 s3c24xx_serial_resume_noirq()
Date: Tue, 27 Sep 2016 22:43:54 +0900
Message-ID: <000d01d218c5$3069cdf0$913d69d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch adds clock controls in s3c24xx_serial_resume_noirq()
to set S3C64XX_UINTM register.

Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 drivers/tty/serial/samsung.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ae2095a..97f7b3b 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1921,6 +1921,7 @@ static int s3c24xx_serial_resume(struct device *dev)
 static int s3c24xx_serial_resume_noirq(struct device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (port) {
 		/* restore IRQ mask */
@@ -1930,7 +1931,9 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 				uintm &= ~S3C64XX_UINTM_TXD_MSK;
 			if (rx_enabled(port))
 				uintm &= ~S3C64XX_UINTM_RXD_MSK;
+			clk_prepare_enable(ourport->clk);
 			wr_regl(port, S3C64XX_UINTM, uintm);
+			clk_disable_unprepare(ourport->clk);
 		}
 	}
 
-- 
2.8.1
