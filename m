From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2] serial: samsung: Reorder the sequence of clock control when
 call s3c24xx_serial_set_termios()
Date: Mon, 28 Mar 2016 08:48:23 +0900
Message-ID: <1459122503-5202-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: k.kozlowski@samsung.com, kgene@kernel.org, m.szyprowski@samsung.com, cw00.choi@samsung.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch fixes the broken serial log when changing the clock source
of uart device. Before disabling the original clock source, this patch
enables the new clock source to protect the clock off state for a split second.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
(https://lkml.org/lkml/2016/3/13/183)
- Enable the clock before changing the source by s3c24xx_serial_setsource()
- Rebase it on Linux v4.6-rc1

 drivers/tty/serial/samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ac7f8df54406..99bb23161dd6 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1271,6 +1271,8 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	/* check to see if we need  to change clock source */
 
 	if (ourport->baudclk != clk) {
+		clk_prepare_enable(clk);
+
 		s3c24xx_serial_setsource(port, clk_sel);
 
 		if (!IS_ERR(ourport->baudclk)) {
@@ -1278,8 +1280,6 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 			ourport->baudclk = ERR_PTR(-EINVAL);
 		}
 
-		clk_prepare_enable(clk);
-
 		ourport->baudclk = clk;
 		ourport->baudclk_rate = clk ? clk_get_rate(clk) : 0;
 	}
-- 
1.9.1
