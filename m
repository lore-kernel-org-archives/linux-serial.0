From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 06/10] drivers: PL011: replace UART_MIS reading with _RIS &
 _IMSC
Date: Wed,  4 Mar 2015 17:59:50 +0000
Message-ID: <1425491994-23913-7-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave.Martin@arm.com
List-Id: linux-serial@vger.kernel.org

The PL011 register UART_MIS is actually a bitwise AND of the
UART_RIS and the UART_MISC register.
Since the SBSA UART does not include the _MIS register, use the
two separate registers to get the same behaviour. Since we are
inside the spinlock and we read the _IMSC register only once, there
should be no race issue.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4fe0a0a..b8f46f3 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1418,11 +1418,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	struct uart_amba_port *uap = dev_id;
 	unsigned long flags;
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
+	u16 imsc;
 	int handled = 0;
 	unsigned int dummy_read;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	status = readw(uap->port.membase + UART011_MIS);
+	imsc = readw(uap->port.membase + UART011_IMSC);
+	status = readw(uap->port.membase + UART011_RIS) & imsc;
 	if (status) {
 		do {
 			if (uap->vendor->cts_event_workaround) {
@@ -1459,7 +1461,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (pass_counter-- == 0)
 				break;
 
-			status = readw(uap->port.membase + UART011_MIS);
+			status = readw(uap->port.membase + UART011_RIS) & imsc;
 		} while (status != 0);
 		handled = 1;
 	}
-- 
1.7.9.5
