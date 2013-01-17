From: Haojun Bao <hjbao@marvell.com>
Subject: [PATCH] Do not tweak clock in pxa serial write() function
Date: Thu, 17 Jan 2013 00:01:51 -0800
Message-ID: <87k3rc44sq.fsf@bj-lt7.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org


The write() function could be used by printk(), which is atomic and
tweaking clock there can cause "BUG: sleeping function called from
invalid context".

Signed-off-by: Bao Haojun <hjbao@marvell.com>
---
 drivers/tty/serial/pxa.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 2764828..fa1d5ae 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -673,7 +673,6 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-	clk_prepare_enable(up->clk);
 
 	local_irq_save(flags);
 	if (up->port.sysrq)
@@ -702,7 +701,6 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
 
-	clk_disable_unprepare(up->clk);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-- 
1.7.10.4
