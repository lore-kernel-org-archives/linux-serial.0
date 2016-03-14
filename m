From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] serial: samsung: Reorder the sequence of clock control when
 call s3c24xx_serial_set_termios()
Date: Mon, 14 Mar 2016 09:41:05 +0900
Message-ID: <1457916065-27418-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: k.kozlowski@samsung.com, kgene@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-serial@vger.kernel.org

This patch fixes the broken serial log when changing the clock source
of uart device. Before disabling the original clock source, this patch
enables the new clock source to protect the clock off state for a split second.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/tty/serial/samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index d72cd736bdc6..80d59dbfebba 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1265,13 +1265,13 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	if (ourport->baudclk != clk) {
 		s3c24xx_serial_setsource(port, clk_sel);
 
+		clk_prepare_enable(clk);
+
 		if (!IS_ERR(ourport->baudclk)) {
 			clk_disable_unprepare(ourport->baudclk);
 			ourport->baudclk = ERR_PTR(-EINVAL);
 		}
 
-		clk_prepare_enable(clk);
-
 		ourport->baudclk = clk;
 		ourport->baudclk_rate = clk ? clk_get_rate(clk) : 0;
 	}
-- 
1.9.1
