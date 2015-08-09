From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/8] serial: imx: remove unbalanced clk_prepare
Date: Sun,  9 Aug 2015 11:19:02 -0700
Message-ID: <1439144349-10494-2-git-send-email-edubezval@gmail.com>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The current code attempts to prepare clk_per and clk_ipg
before using the device. However, the result is an extra
prepare call on each clock. Here is the output of uart
clocks (only uart enabled and used as console):

$  grep uart /sys/kernel/debug/clk/clk_summary
 uart_serial           1            2    80000000          0 0
       uart           1            2    66000000          0 0

This patch balances the calls of prepares. The result is:

$  grep uart /sys/kernel/debug/clk/clk_summary
 uart_serial           1            1    80000000          0 0
       uart           1            1    66000000          0 0

Cc: Fabio Stevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 54fdc78..b53455d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1624,12 +1624,12 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	int locked = 1;
 	int retval;
 
-	retval = clk_enable(sport->clk_per);
+	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
 		return;
-	retval = clk_enable(sport->clk_ipg);
+	retval = clk_prepare_enable(sport->clk_ipg);
 	if (retval) {
-		clk_disable(sport->clk_per);
+		clk_disable_unprepare(sport->clk_per);
 		return;
 	}
 
@@ -1668,8 +1668,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable(sport->clk_ipg);
-	clk_disable(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
+	clk_disable_unprepare(sport->clk_per);
 }
 
 /*
@@ -1770,15 +1770,7 @@ imx_console_setup(struct console *co, char *options)
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-	clk_disable(sport->clk_ipg);
-	if (retval) {
-		clk_unprepare(sport->clk_ipg);
-		goto error_console;
-	}
-
-	retval = clk_prepare(sport->clk_per);
-	if (retval)
-		clk_disable_unprepare(sport->clk_ipg);
+	clk_disable_unprepare(sport->clk_ipg);
 
 error_console:
 	return retval;
-- 
2.5.0

