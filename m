From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH] drivers/tty/serial/mpc52xx_uart.c: fix typo in C comment
Date: Sun, 12 Apr 2015 17:14:45 +0200
Message-ID: <1428851685-5176-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

Fix reference on PPC_MPC52xx in C comment after #endif.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
 drivers/tty/serial/mpc52xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 1589f17c1fca..6fc07eb9d74e 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -405,7 +405,7 @@ static struct psc_ops mpc5200b_psc_ops = {
 	.get_mr1 = mpc52xx_psc_get_mr1,
 };
 
-#endif /* CONFIG_MPC52xx */
+#endif /* CONFIG_PPC_MPC52xx */
 
 #ifdef CONFIG_PPC_MPC512x
 #define FIFO_512x(port) ((struct mpc512x_psc_fifo __iomem *)(PSC(port)+1))
-- 
2.1.0
