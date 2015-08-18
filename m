From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] Revert "serial: imx: remove unbalanced clk_prepare"
Date: Tue, 18 Aug 2015 12:43:12 -0300
Message-ID: <1439912592-14779-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: edubezval@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

This reverts commit 9e7b399d6528eac33a6fbfceb2b92af209c3454d.

Commit ("9e7b399d6528ea") causes the following warning and sometimes
also hangs the system:

------------[ cut here ]------------
 WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:868 mutex_trylock+0x20c/0x22c()
 DEBUG_LOCKS_WARN_ON(in_interrupt())
 Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc7-next-20150818-00001-g14418a6 #4
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace: 
[<80012f08>] (dump_backtrace) from [<800130a4>] (show_stack+0x18/0x1c)
r6:00000364 r5:00000000 r4:00000000 r3:00000000
[<8001308c>] (show_stack) from [<807902b8>] (dump_stack+0x88/0xa4)
[<80790230>] (dump_stack) from [<8002a604>] (warn_slowpath_common+0x80/0xbc)
r5:807945c4 r4:80ab3b50
[<8002a584>] (warn_slowpath_common) from [<8002a6e4>] (warn_slowpath_fmt+0x38/0x40)
r8:00000000 r7:8131100c r6:8054c3cc r5:8131300c r4:80b0a570
[<8002a6b0>] (warn_slowpath_fmt) from [<807945c4>] (mutex_trylock+0x20c/0x22c)
r3:8095d0d8 r2:8095ab28
[<807943b8>] (mutex_trylock) from [<8054c3cc>] (clk_prepare_lock+0x14/0xf4)
r7:8131100c r6:be3f0c80 r5:00000037 r4:be3f0c80
[<8054c3b8>] (clk_prepare_lock) from [<8054dbfc>] (clk_prepare+0x18/0x30)
r5:00000037 r4:be3f0c80
[<8054dbe4>] (clk_prepare) from [<8036a600>] (imx_console_write+0x30/0x244)
r4:812d0bc8 r3:8132b9a4

To reproduce the problem we only need to let the board idle for something
like 30 seconds.

Tested on a imx6q-sabresd.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fe3d41c..d0388a0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1631,12 +1631,12 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	int locked = 1;
 	int retval;
 
-	retval = clk_prepare_enable(sport->clk_per);
+	retval = clk_enable(sport->clk_per);
 	if (retval)
 		return;
-	retval = clk_prepare_enable(sport->clk_ipg);
+	retval = clk_enable(sport->clk_ipg);
 	if (retval) {
-		clk_disable_unprepare(sport->clk_per);
+		clk_disable(sport->clk_per);
 		return;
 	}
 
@@ -1675,8 +1675,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_ipg);
-	clk_disable_unprepare(sport->clk_per);
+	clk_disable(sport->clk_ipg);
+	clk_disable(sport->clk_per);
 }
 
 /*
@@ -1777,7 +1777,15 @@ imx_console_setup(struct console *co, char *options)
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-	clk_disable_unprepare(sport->clk_ipg);
+	clk_disable(sport->clk_ipg);
+	if (retval) {
+		clk_unprepare(sport->clk_ipg);
+		goto error_console;
+	}
+
+	retval = clk_prepare(sport->clk_per);
+	if (retval)
+		clk_disable_unprepare(sport->clk_ipg);
 
 error_console:
 	return retval;
-- 
1.9.1
