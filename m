From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 3/4] serial: samsung: Staticize local symbol
Date: Sat,  2 May 2015 00:40:04 +0900
Message-ID: <1430494805-30906-3-git-send-email-k.kozlowski.k@gmail.com>
References: <1430494805-30906-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430494805-30906-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-serial@vger.kernel.org

Staticize symbols not exported and not used outside of file.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/tty/serial/samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index a0ae942d9562..19ce68e421a7 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -348,7 +348,7 @@ static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
 		s3c24xx_serial_start_tx_dma(ourport, count);
 }
 
-void s3c24xx_serial_start_tx(struct uart_port *port)
+static void s3c24xx_serial_start_tx(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	struct circ_buf *xmit = &port->state->xmit;
-- 
2.1.4
