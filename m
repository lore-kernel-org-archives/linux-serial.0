From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: 8250: remove return statements from void function
Date: Mon, 11 May 2015 12:30:22 +0900
Message-ID: <1431315022-10526-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
List-Id: linux-serial@vger.kernel.org

serial8250_set_mctrl() is a void type function.  Returning something
does not look nice.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 4882027..146f56c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2019,8 +2019,9 @@ EXPORT_SYMBOL_GPL(serial8250_do_set_mctrl);
 static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	if (port->set_mctrl)
-		return port->set_mctrl(port, mctrl);
-	return serial8250_do_set_mctrl(port, mctrl);
+		port->set_mctrl(port, mctrl);
+	else
+		serial8250_do_set_mctrl(port, mctrl);
 }
 
 static void serial8250_break_ctl(struct uart_port *port, int break_state)
-- 
1.9.1
