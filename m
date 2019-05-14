From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 7/7] tty: max310x: Split uart characters insertion loop
Date: Tue, 14 May 2019 13:14:15 +0300
Message-ID: <20190514101415.26754-8-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Batch read mode doesn't check any conditions or flags except the Rx
overflow one. But it may only happen after the last character is pushed
into the RHR register. In this case we shouldn't push all the read
characters with overrun flag set, but only the last one caused the
FIFO overflow. This commit splits the characters retrieval loop into
two parts. First one is ordinary intsert-chars procedure without taking
the overrun status into account. Second part inserts the last character
checking whether the overrun happened and pushing a '\0' character with
TTY_OVERRUN flag to a flip-buffer.

If we left the loop the way it was the '\0' character would be inserted
after each character retrieved at the overrun occasion.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 36943f6c198c..81b2413c3da4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -680,10 +680,16 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 			port->icount.overrun++;
 		}
 
-		for (i = 0; i < rxlen; ++i) {
-			uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
-					 one->rx_buf[i], flag);
-		}
+		for (i = 0; i < (rxlen - 1); ++i)
+			uart_insert_char(port, sts, 0, one->rx_buf[i], flag);
+
+		/*
+		 * Handle the overrun case for the last character only, since
+		 * the RxFIFO overflow happens after it is pushed to the FIFO
+		 * tail.
+		 */
+		uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
+				 one->rx_buf[rxlen], flag);
 
 	} else {
 		if (unlikely(rxlen >= port->fifosize)) {
-- 
2.21.0
