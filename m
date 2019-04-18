From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH] serial: Fix using plain integer instead of Null pointer
Date: Thu, 18 Apr 2019 15:21:25 +0900
Message-ID: <1555568485-6421-1-git-send-email-sugaya.taichi@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sugaya Taichi <sugaya.taichi@socionext.com>
List-Id: linux-serial@vger.kernel.org

Fix build warning that using plain integer as Null pointer.
This is reported by kbuild test robot.

Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 drivers/tty/serial/milbeaut_usio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index d303b7d..4a10604 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -500,7 +500,7 @@ static int __init mlb_usio_early_console_setup(struct earlycon_device *device,
 
 static int mlb_usio_probe(struct platform_device *pdev)
 {
-	struct clk *clk = devm_clk_get(&pdev->dev, 0);
+	struct clk *clk = devm_clk_get(&pdev->dev, NULL);
 	struct uart_port *port;
 	struct resource *res;
 	int index = 0;
-- 
1.9.1
