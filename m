From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/6] serial: export fsl8250_handle_irq
Date: Mon, 16 Nov 2015 16:48:09 +0100
Message-ID: <1447688894-2936779-2-git-send-email-arnd@arndb.de>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Scott Wood <scottwood@freescale.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

fsl8250_handle_irq is now used by the of_serial driver, and that fails
if it is a loadable module:

ERROR: "fsl8250_handle_irq" [drivers/tty/serial/of_serial.ko] undefined!

This exports the symbol to avoid randconfig errors.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d43b54d269d2 ("serial: Enable Freescale 16550 workaround on arm")
Cc: Scott Wood <scottwood@freescale.com>
---
 drivers/tty/serial/8250/8250_fsl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index c0533a57ec53..910bfee5a88b 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -60,3 +60,4 @@ int fsl8250_handle_irq(struct uart_port *port)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	return 1;
 }
+EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
-- 
2.1.0.rc2
