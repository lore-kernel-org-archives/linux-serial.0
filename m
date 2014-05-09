From: dean_jenkins@mentor.com
Subject: [PATCH 2/5] serial: imx: remove uart_write_wakeup() from
 imx_transmit_buffer()
Date: Fri,  9 May 2014 16:19:45 +0100
Message-ID: <1399648788-26061-3-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: dirk.behme@de.bosch.com, s.hauer@pengutronix.de, dean_jenkins@mentor.com, b32955@freescale.com, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com
List-Id: linux-serial@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

At the moment we have

imx_transmit_buffer() {
    ...
    if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
        uart_write_wakeup();
    ...
}

imx_txint() {
    ...
    imx_transmit_buffer();

    if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
        uart_write_wakeup();
    ...
}

With this, we are calling uart_write_wakeup() at the end of
imx_transmit_buffer() and immediately again after returning
from imx_transmit_buffer() in imx_txint(). Instead of calling
uart_write_wakeup() two times this way, remove the first call
and call uart_write_wakeup() only once in imx_txint().

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Andy Lowe <andy_lowe@mentor.com>
---
 drivers/tty/serial/imx.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7b813b3..abe31ad 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -470,9 +470,6 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
 		sport->port.icount.tx++;
 	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
 	if (uart_circ_empty(xmit))
 		imx_stop_tx(&sport->port);
 }
-- 
1.7.9.5
