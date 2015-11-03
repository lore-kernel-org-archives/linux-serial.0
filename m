From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 03/11] tty: amba-pl011: add helper to detect split LCRH
 register
Date: Tue, 03 Nov 2015 14:51:08 +0000
Message-ID: <E1ZtcvU-0007CC-LY@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

Add a helper to detect the split LCRH register found on ST variants.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 61512afb10da..63a916bb76f1 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1576,10 +1576,15 @@ static int pl011_hwinit(struct uart_port *port)
 	return 0;
 }
 
+static bool pl011_split_lcrh(const struct uart_amba_port *uap)
+{
+	return uap->lcrh_rx != uap->lcrh_tx;
+}
+
 static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 {
 	pl011_write(lcr_h, uap, uap->lcrh_rx);
-	if (uap->lcrh_rx != uap->lcrh_tx) {
+	if (pl011_split_lcrh(uap)) {
 		int i;
 		/*
 		 * Wait 10 PCLKs before writing LCRH_TX register,
@@ -1713,7 +1718,7 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 	 * disable break condition and fifos
 	 */
 	pl011_shutdown_channel(uap, uap->lcrh_rx);
-	if (uap->lcrh_rx != uap->lcrh_tx)
+	if (pl011_split_lcrh(uap))
 		pl011_shutdown_channel(uap, uap->lcrh_tx);
 }
 
-- 
2.1.0
