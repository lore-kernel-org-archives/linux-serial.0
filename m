From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 01/10] serial: st-asc: Ignore the parity error bit if 8-bit
 mode is enabled
Date: Wed,  1 Feb 2017 14:31:36 +0000
Message-ID: <20170201143145.31962-2-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170201143145.31962-1-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org
Cc: patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

The datasheet states:

"If the MODE field selects an 8-bit frame then this [parity error] bit
 is undefined. Software should ignore this bit when reading 8-bit frames."

Acked-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 379e5bd..69e6232 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -287,9 +287,19 @@ static void asc_transmit_chars(struct uart_port *port)
 static void asc_receive_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
-	unsigned long status;
+	unsigned long status, mode;
 	unsigned long c = 0;
 	char flag;
+	bool ignore_pe = false;
+
+	/*
+	 * Datasheet states: If the MODE field selects an 8-bit frame then
+	 * this [parity error] bit is undefined. Software should ignore this
+	 * bit when reading 8-bit frames.
+	 */
+	mode = asc_in(port, ASC_CTL) & ASC_CTL_MODE_MSK;
+	if (mode == ASC_CTL_MODE_8BIT || mode == ASC_CTL_MODE_8BIT_PAR)
+		ignore_pe = true;
 
 	if (port->irq_wake)
 		pm_wakeup_event(tport->tty->dev, 0);
@@ -299,8 +309,8 @@ static void asc_receive_chars(struct uart_port *port)
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
-		if ((c & (ASC_RXBUF_FE | ASC_RXBUF_PE)) ||
-			status & ASC_STA_OE) {
+		if (status & ASC_STA_OE || c & ASC_RXBUF_FE ||
+		    (c & ASC_RXBUF_PE && !ignore_pe)) {
 
 			if (c & ASC_RXBUF_FE) {
 				if (c == (ASC_RXBUF_FE | ASC_RXBUF_DUMMY_RX)) {
-- 
2.9.3
