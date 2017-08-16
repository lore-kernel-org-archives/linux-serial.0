From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 3/6] serial: core: support deferring serdev controller registration
Date: Wed, 16 Aug 2017 15:22:25 +0200
Message-ID: <1502889748-31499-4-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

serdev controllers may depend on other devices (such as multiplexers)
and thus require deferred probing support.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/serial_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f534a40..30a8997 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2785,6 +2785,10 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 			uport->line, uport->dev, port, uport->tty_groups);
 	if (likely(!IS_ERR(tty_dev))) {
 		device_set_wakeup_capable(tty_dev, 1);
+	} else if (PTR_ERR(tty_dev) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		state->uart_port = NULL;
+		goto out;
 	} else {
 		dev_err(uport->dev, "Cannot register tty device on line %d\n",
 		       uport->line);
-- 
2.7.4
