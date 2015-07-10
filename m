From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] tty: serial: Drop owner assignment from platform_driver
Date: Fri, 10 Jul 2015 15:36:19 +0900
Message-ID: <1436510180-5567-2-git-send-email-k.kozlowski@samsung.com>
References: <1436510180-5567-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1436510180-5567-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Paul Burton <paul.burton@imgtec.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/tty/serial/8250/8250_ingenic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 21bf81fe794f..7c1e4be48e7b 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -252,7 +252,6 @@ MODULE_DEVICE_TABLE(of, of_match);
 static struct platform_driver ingenic_uart_platform_driver = {
 	.driver = {
 		.name		= "ingenic-uart",
-		.owner		= THIS_MODULE,
 		.of_match_table	= of_match,
 	},
 	.probe			= ingenic_uart_probe,
-- 
1.9.1
