From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH 1/5] serial: arc: Remove __init marking from early write
Date: Tue, 18 Jul 2017 12:29:59 +0800
Message-ID: <1500352203-21513-2-git-send-email-jeffy.chen@rock-chips.com>
References: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, briannorris@chromium.org, dianders@chromium.org, peter@hurleysoftware.com, Jeffy Chen <jeffy.chen@rock-chips.com>, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The earlycon would be alive outside the init code in these cases:
1/ we have keep_bootcon in cmdline.
2/ we don't have a real console to switch to.

So remove the __init marking to avoid invalid memory access.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/tty/serial/arc_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 5ac06fc..77fe306 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -549,8 +549,8 @@ static struct console arc_console = {
 	.data	= &arc_uart_driver
 };
 
-static __init void arc_early_serial_write(struct console *con, const char *s,
-					  unsigned int n)
+static void arc_early_serial_write(struct console *con, const char *s,
+				   unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
-- 
2.1.4
