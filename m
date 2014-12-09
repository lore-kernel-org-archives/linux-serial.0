From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 14/15] serial: imx: Fix issue in software flow control
Date: Tue, 9 Dec 2014 18:11:35 +0900
Message-ID: <1418116296-12082-15-git-send-email-jiada_wang@mentor.com>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

After send out x_char in UART driver, x_char needs to be cleared
by UART driver itself, otherwise data in TXFIFO can no longer be
sent out.
Also tx counter needs to be increased to keep track of correct
number of transmitted data.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 94ee7c5..301cf8c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -471,6 +471,8 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 	if (sport->port.x_char) {
 		/* Send next char */
 		writel(sport->port.x_char, sport->port.membase + URTX0);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
 		return;
 	}
 
-- 
1.9.3
