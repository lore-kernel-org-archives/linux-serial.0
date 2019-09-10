From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tty: serial: rda: Fix the link time qualifier of 'rda_uart_exit()'
Date: Tue, 10 Sep 2019 06:17:02 +0200
Message-ID: <20190910041702.7357-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: manivannan.sadhasivam@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-serial@vger.kernel.org

'exit' functions should be marked as __exit, not __init.

Fixes: c10b13325ced ("tty: serial: Add RDA8810PL UART driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/rda-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index c1b0d7662ef9..ff9a27d48bca 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -815,7 +815,7 @@ static int __init rda_uart_init(void)
 	return ret;
 }
 
-static void __init rda_uart_exit(void)
+static void __exit rda_uart_exit(void)
 {
 	platform_driver_unregister(&rda_uart_platform_driver);
 	uart_unregister_driver(&rda_uart_driver);
-- 
2.20.1
