From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v4 06/11] drivers: PL011: replace UART_MIS reading with _RIS &
 _IMSC
Date: Tue, 12 May 2015 15:14:50 +0100
Message-ID: <1431440095-5146-7-git-send-email-andre.przywara@arm.com>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, arnd@arndb.de, Jakub Kicinski <moorray3@wp.pl>, linux-serial@vger.kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The PL011 register UART_MIS is actually a bitwise AND of the
UART_RIS and the UART_MISC register.
Since the SBSA UART does not include the _MIS register, use the
two separate registers to get the same behaviour. Since we are
inside the spinlock and we read the _IMSC register only once, there
should be no race issue.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6709c6c..52cc2f5 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1322,11 +1322,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
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
@@ -1361,7 +1363,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (pass_counter-- == 0)
 				break;
 
-			status = readw(uap->port.membase + UART011_MIS);
+			status = readw(uap->port.membase + UART011_RIS) & imsc;
 		} while (status != 0);
 		handled = 1;
 	}
-- 
2.3.5
