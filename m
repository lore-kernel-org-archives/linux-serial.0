From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: of_serial: check the return value of clk_prepare_enable()
Date: Mon, 25 May 2015 15:03:32 +0900
Message-ID: <1432533812-31033-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The function clk_prepare_enable() may fail, and in that case it
does not make sense to proceed.  Let's check its return code and
error out if it is a negative value.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/of_serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index d353fdf..6823df9 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -74,7 +74,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			return PTR_ERR(info->clk);
 		}
 
-		clk_prepare_enable(info->clk);
+		ret = clk_prepare_enable(info->clk);
+		if (ret < 0)
+			return ret;
+
 		clk = clk_get_rate(info->clk);
 	}
 	/* If current-speed was set, then try not to change it. */
-- 
1.9.1
