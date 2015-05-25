From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: of_serial: use devm_clk_get() instead of clk_get()
Date: Mon, 25 May 2015 14:57:43 +0900
Message-ID: <1432533463-30810-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Joachim Eastwood <manabian@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The probe method of this driver calls clk_get(), but clk_put() is
missing from the remove callback.

Using the managed clk function is easier than fixing other parts.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/of_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 28b9b47..d353fdf 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -67,7 +67,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (of_property_read_u32(np, "clock-frequency", &clk)) {
 
 		/* Get clk rate through clk driver if present */
-		info->clk = clk_get(&ofdev->dev, NULL);
+		info->clk = devm_clk_get(&ofdev->dev, NULL);
 		if (IS_ERR(info->clk)) {
 			dev_warn(&ofdev->dev,
 				"clk or clock-frequency not defined\n");
-- 
1.9.1
