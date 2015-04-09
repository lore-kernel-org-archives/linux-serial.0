From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v3 07/10] drivers: PL011: move cts_event workaround into
 separate function
Date: Thu,  9 Apr 2015 12:29:18 +0100
Message-ID: <1428578961-6896-8-git-send-email-andre.przywara@arm.com>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rmk+kernel@arm.linux.org.uk, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, Dave.Martin@arm.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

To avoid lines with more than 80 characters and to make the
pl011_int() function more readable, move the workaround out into a
separate function.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3829879..34dfccd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1317,6 +1317,25 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 	wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
 }
 
+static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
+{
+	unsigned int dummy_read;
+
+	if (!uap->vendor->cts_event_workaround)
+		return;
+
+	/* workaround to make sure that all bits are unlocked.. */
+	writew(0x00, uap->port.membase + UART011_ICR);
+
+	/*
+	 * WA: introduce 26ns(1 uart clk) delay before W1C;
+	 * single apb access will incur 2 pclk(133.12Mhz) delay,
+	 * so add 2 dummy reads
+	 */
+	dummy_read = readw(uap->port.membase + UART011_ICR);
+	dummy_read = readw(uap->port.membase + UART011_ICR);
+}
+
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap = dev_id;
@@ -1324,25 +1343,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	u16 imsc;
 	int handled = 0;
-	unsigned int dummy_read;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 	imsc = readw(uap->port.membase + UART011_IMSC);
 	status = readw(uap->port.membase + UART011_RIS) & imsc;
 	if (status) {
 		do {
-			if (uap->vendor->cts_event_workaround) {
-				/* workaround to make sure that all bits are unlocked.. */
-				writew(0x00, uap->port.membase + UART011_ICR);
-
-				/*
-				 * WA: introduce 26ns(1 uart clk) delay before W1C;
-				 * single apb access will incur 2 pclk(133.12Mhz) delay,
-				 * so add 2 dummy reads
-				 */
-				dummy_read = readw(uap->port.membase + UART011_ICR);
-				dummy_read = readw(uap->port.membase + UART011_ICR);
-			}
+			check_apply_cts_event_workaround(uap);
 
 			writew(status & ~(UART011_TXIS|UART011_RTIS|
 					  UART011_RXIS),
-- 
1.7.9.5
