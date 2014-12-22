From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH] tty: serial: msm_serial: Remove duplicate call to msm_set_baud_rate
Date: Mon, 22 Dec 2014 20:14:20 +0530
Message-ID: <1419259460-24142-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@smartplayin.com>
List-Id: linux-serial@vger.kernel.org

The function 'msm_set_baud_rate' is called twice while setting up
msm console. Once in msm_console_setup and next when uart_set_options
calls port->ops->set_termios ie. msm_set_termios().

Remove the duplicate call in msm_console_setup. Tested on IFC6410
console.

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/tty/serial/msm_serial.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index dbc278d..4c4a250 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -945,7 +945,6 @@ static int __init msm_console_setup(struct console *co, char *options)
 
 	if (baud < 300 || baud > 115200)
 		baud = 115200;
-	msm_set_baud_rate(port, baud);
 
 	msm_reset(port);
 
-- 
1.7.9.5
