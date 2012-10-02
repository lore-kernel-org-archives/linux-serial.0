From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] serial: samsung: use clk_prepare_enable and clk_disable_unprepare
Date: Wed,  3 Oct 2012 07:40:04 +0900
Message-ID: <1349217604-2837-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44661 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2JBWm4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Oct 2012 18:42:56 -0400
Received: by padhz1 with SMTP id hz1so5684056pad.19
        for <linux-serial@vger.kernel.org>; Tue, 02 Oct 2012 15:42:56 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ben-linux@fluff.org, kgene.kim@samsung.com

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/tty/serial/samsung.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 7f04717..740458c 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -530,16 +530,16 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 	switch (level) {
 	case 3:
 		if (!IS_ERR(ourport->baudclk))
-			clk_disable(ourport->baudclk);
+			clk_disable_unprepare(ourport->baudclk);
 
-		clk_disable(ourport->clk);
+		clk_disable_unprepare(ourport->clk);
 		break;
 
 	case 0:
-		clk_enable(ourport->clk);
+		clk_prepare_enable(ourport->clk);
 
 		if (!IS_ERR(ourport->baudclk))
-			clk_enable(ourport->baudclk);
+			clk_prepare_enable(ourport->baudclk);
 
 		break;
 	default:
@@ -713,11 +713,11 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 		s3c24xx_serial_setsource(port, clk_sel);
 
 		if (!IS_ERR(ourport->baudclk)) {
-			clk_disable(ourport->baudclk);
+			clk_disable_unprepare(ourport->baudclk);
 			ourport->baudclk = ERR_PTR(-EINVAL);
 		}
 
-		clk_enable(clk);
+		clk_prepare_enable(clk);
 
 		ourport->baudclk = clk;
 		ourport->baudclk_rate = clk ? clk_get_rate(clk) : 0;
@@ -1287,9 +1287,9 @@ static int s3c24xx_serial_resume(struct device *dev)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (port) {
-		clk_enable(ourport->clk);
+		clk_prepare_enable(ourport->clk);
 		s3c24xx_serial_resetport(port, s3c24xx_port_to_cfg(port));
-		clk_disable(ourport->clk);
+		clk_disable_unprepare(ourport->clk);
 
 		uart_resume_port(&s3c24xx_uart_drv, port);
 	}
-- 
1.7.4.1

