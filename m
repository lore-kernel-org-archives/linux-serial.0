From: Chen Hu <hu1.chen@intel.com>
Subject: [PATCH] serial: 8250_dw: always set baud rate in dw8250_set_termios
Date: Fri, 27 Jul 2018 18:32:41 +0800
Message-ID: <20180727103242.29675-1-hu1.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.shevchenko@gmail.com
Cc: Chen Hu <hu1.chen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Subramony Sesha <subramony.sesha@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Archana Patni <archana.patni@intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

dw8250_set_termios() doesn't set baud rate if the arg "old ktermios" is
NULL. This happens during resume.
Call Trace:
...
[   54.928108] dw8250_set_termios+0x162/0x170
[   54.928114] serial8250_set_termios+0x17/0x20
[   54.928117] uart_change_speed+0x64/0x160
[   54.928119] uart_resume_port
...

So the baud rate is not restored after S3 and breaks the apps who use
UART, for example, console and bluetooth etc.

We address this issue by setting the baud rate irrespective of arg
"old", just like the drivers for other 8250 IPs. This is tested with
Intel Broxton platform.

Signed-off-by: Chen Hu <hu1.chen@intel.com>
---
We found UART based apps such as console and bluetooth etc. are broken after S3
on Intel Broxton platform. The further debug shows that the baud rate of all
UARTs are different with our settings after S3. During S3, the 8250 related IPs
may lose power and thus lose the OS's baud rate setting. The driver should
restore it during resume. However, Desinware 8250's driver doesn't restore the
baud if the arg "old ktermios" is NULL. Unfortunely, it get a NULL arg from
serial_core and skips this step in resume path.

Andy guide me that he doesn't see other 8250 IPs judge old==NULL to set baud.

With the modification in this email, the baud rate is OK after S3. A local
quick test doesn't show any error. Report the issue here and hope some serial
experts can present formal patch to fix.
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 02a9b995e8f9..82bf46507f6d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -250,7 +250,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
-	if (IS_ERR(d->clk) || !old)
+	if (IS_ERR(d->clk))
 		goto out;
 
 	clk_disable_unprepare(d->clk);
-- 
2.13.0
