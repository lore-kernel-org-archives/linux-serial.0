From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 06/15] serial/men_z135_uart: Deinline men_z135_reg_clr, save 176 bytes
Date: Tue, 27 Oct 2015 18:46:38 +0100
Message-ID: <1445968007-12616-7-git-send-email-dvlasenk@redhat.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 98 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/men_z135_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index b90e7b3..2b5b66f 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -159,7 +159,7 @@ static inline void men_z135_reg_set(struct men_z135_port *uart,
  * @addr: Register address
  * @val: value to clear
  */
-static inline void men_z135_reg_clr(struct men_z135_port *uart,
+static void men_z135_reg_clr(struct men_z135_port *uart,
 				u32 addr, u32 val)
 {
 	struct uart_port *port = &uart->port;
-- 
1.8.1.4
