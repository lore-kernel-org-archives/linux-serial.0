From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/2] tty: serial: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:36:20 +0900
Message-ID: <1436510180-5567-3-git-send-email-k.kozlowski@samsung.com>
References: <1436510180-5567-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1436510180-5567-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Paul Burton <paul.burton@imgtec.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/tty/serial/sc16is7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9e6576004a42..bbeb33561737 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1369,7 +1369,6 @@ MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
 static struct i2c_driver sc16is7xx_i2c_uart_driver = {
 	.driver = {
 		.name		= SC16IS7XX_NAME,
-		.owner		= THIS_MODULE,
 		.of_match_table	= of_match_ptr(sc16is7xx_dt_ids),
 	},
 	.probe		= sc16is7xx_i2c_probe,
-- 
1.9.1
