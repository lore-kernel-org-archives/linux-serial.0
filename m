From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/4] serial: 8250_uniphier: avoid locking for FCR register write
Date: Mon, 24 Oct 2016 17:00:30 +0900
Message-ID: <1477296030-7517-5-git-send-email-yamada.masahiro@socionext.com>
References: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The hardware book says, the FCR is combined with a register called
CHAR (it will trigger interrupt when a specific character is
received).  At first, I used lock/read/modify/write/unlock dance for
the FCR to not affect the upper bits, but the CHAR is actually never
used.  It should not hurt to always clear the CHAR and to handle the
FCR as a normal case.  It can save the costly locking.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Denys Vlasenko <dvlasenk@redhat.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 92e7bb7..746680e 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -101,7 +101,7 @@ static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
 static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 {
 	unsigned int valshift = 0;
-	bool normal = false;
+	bool normal = true;
 
 	switch (offset) {
 	case UART_FCR:
@@ -114,9 +114,9 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 		/* fall through */
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
+		normal = false;
 		break;
 	default:
-		normal = true;
 		offset <<= UNIPHIER_UART_REGSHIFT;
 		break;
 	}
-- 
1.9.1
