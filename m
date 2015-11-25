From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] drivers/tty/serial: make tegra_serial_handle_break() static
Date: Wed, 25 Nov 2015 23:50:03 +0600
Message-ID: <1448473803-9691-1-git-send-email-kuleshovmail@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-serial@vger.kernel.org

There are no callers of the tegra_serial_handle_break() function
outside of drivers/tty/serial/of_serial.c. So let's make it static.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
Forgot Signed-off-by line

 drivers/tty/serial/of_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index de50296..a35f694 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -34,7 +34,7 @@ struct of_serial_info {
 };

 #ifdef CONFIG_ARCH_TEGRA
-void tegra_serial_handle_break(struct uart_port *p)
+static void tegra_serial_handle_break(struct uart_port *p)
 {
 	unsigned int status, tmout = 10000;

--
2.5.0
