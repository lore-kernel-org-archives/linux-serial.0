From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 2/2] serial: 8250_early: squash wait_for_xmitr() into serial_putc()
Date: Sat, 24 Oct 2015 13:17:45 +0900
Message-ID: <1445660265-13668-3-git-send-email-yamada.masahiro@socionext.com>
References: <1445660265-13668-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445660265-13668-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, Wang Long <long.wanglong@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Now, wait_for_xmitr() is only called from serial_putc(), and both
are short enough.  They can be merged into a single function.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_early.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 559b681..19aca19 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -76,21 +76,17 @@ static void __init serial8250_early_out(struct uart_port *port, int offset, int
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static void __init wait_for_xmitr(struct uart_port *port)
+static void __init serial_putc(struct uart_port *port, int c)
 {
 	unsigned int status;
 
 	for (;;) {
 		status = serial8250_early_in(port, UART_LSR);
 		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
-			return;
+			break;
 		cpu_relax();
 	}
-}
 
-static void __init serial_putc(struct uart_port *port, int c)
-{
-	wait_for_xmitr(port);
 	serial8250_early_out(port, UART_TX, c);
 }
 
-- 
1.9.1
