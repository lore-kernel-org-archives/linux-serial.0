From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/4] serial: 8250_uniphier: fix clearing divisor latch access bit
Date: Mon, 24 Oct 2016 17:00:28 +0900
Message-ID: <1477296030-7517-3-git-send-email-yamada.masahiro@socionext.com>
References: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

At this point, 'value' is always a byte, then this code is clearing
bit 15, which is already clear.  I meant to clear bit 7.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index a8babb0..417d9e7 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -99,7 +99,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 	case UART_LCR:
 		valshift = UNIPHIER_UART_LCR_SHIFT;
 		/* Divisor latch access bit does not exist. */
-		value &= ~(UART_LCR_DLAB << valshift);
+		value &= ~UART_LCR_DLAB;
 		/* fall through */
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
-- 
1.9.1
