From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 2/4] serial: pch_uart: fix tty-kref leak in rx-error path
Date: Tue, 10 Sep 2013 12:50:49 +0200
Message-ID: <1378810251-28499-3-git-send-email-jhovold@gmail.com>
References: <1378810251-28499-1-git-send-email-jhovold@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1378810251-28499-1-git-send-email-jhovold@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Warren <swarren@wwwdotorg.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, Johan Hovold <jhovold@gmail.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix tty-kref leak introduced by commit 384e301e ("pch_uart: fix a
deadlock when pch_uart as console") which never put its tty reference.

Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/tty/serial/pch_uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 52379e5..f0161d6 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1098,6 +1098,8 @@ static void pch_uart_err_ir(struct eg20t_port *priv, unsigned int lsr)
 	if (tty == NULL) {
 		for (i = 0; error_msg[i] != NULL; i++)
 			dev_err(&priv->pdev->dev, error_msg[i]);
+	} else {
+		tty_kref_put(tty);
 	}
 }
 
-- 
1.8.3.2
