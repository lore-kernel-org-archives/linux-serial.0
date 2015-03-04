From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 08/10] drivers: PL011: allow avoiding UART
 enabling/disabling
Date: Wed,  4 Mar 2015 17:59:52 +0000
Message-ID: <1425491994-23913-9-git-send-email-andre.przywara@arm.com>
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

The SBSA UART should not be enabled or disabled (it is always on),
and consequently the spec lacks the UART_CR register.
Add a vendor specific property to skip disabling or enabling of the
UART. This will be used later by the SBSA UART support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index bca5a3f..fdb9fa5 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -79,6 +79,7 @@ struct vendor_data {
 	bool			oversampling;
 	bool			dma_threshold;
 	bool			cts_event_workaround;
+	bool			always_enabled;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -95,6 +96,7 @@ static struct vendor_data vendor_arm = {
 	.oversampling		= false,
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
+	.always_enabled		= false,
 	.get_fifosize		= get_fifosize_arm,
 };
 
@@ -110,6 +112,7 @@ static struct vendor_data vendor_st = {
 	.oversampling		= true,
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
+	.always_enabled		= false,
 	.get_fifosize		= get_fifosize_st,
 };
 
@@ -2059,7 +2062,7 @@ static void
 pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
-	unsigned int status, old_cr, new_cr;
+	unsigned int status, old_cr = 0, new_cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2076,10 +2079,12 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	/*
 	 *	First save the CR then disable the interrupts
 	 */
-	old_cr = readw(uap->port.membase + UART011_CR);
-	new_cr = old_cr & ~UART011_CR_CTSEN;
-	new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
-	writew(new_cr, uap->port.membase + UART011_CR);
+	if (!uap->vendor->always_enabled) {
+		old_cr = readw(uap->port.membase + UART011_CR);
+		new_cr = old_cr & ~UART011_CR_CTSEN;
+		new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
+		writew(new_cr, uap->port.membase + UART011_CR);
+	}
 
 	uart_console_write(&uap->port, s, count, pl011_console_putchar);
 
@@ -2090,7 +2095,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	do {
 		status = readw(uap->port.membase + UART01x_FR);
 	} while (status & UART01x_FR_BUSY);
-	writew(old_cr, uap->port.membase + UART011_CR);
+	if (!uap->vendor->always_enabled)
+		writew(old_cr, uap->port.membase + UART011_CR);
 
 	if (locked)
 		spin_unlock(&uap->port.lock);
-- 
1.7.9.5
