From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] serial: 8250_uniphier: use CHAR register for canary to
 detect power-off
Date: Tue,  8 Aug 2017 22:48:42 +0900
Message-ID: <1502200123-2558-3-git-send-email-yamada.masahiro@socionext.com>
References: <1502200123-2558-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1502200123-2558-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The 8250 core uses the SCR as a canary to discover if the console has
been powered-off.

This hardware does not have SCR at offset 7, but an unused register
CHAR at a different offset.  As long as the character interrupt is
disabled, the register access has no impact, so it is useful as an
alternative scratch register.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 633ac378b7f2..97a45b798fcd 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -29,12 +29,13 @@
  *   - MMIO32 (regshift = 2)
  *   - FCR is not at 2, but 3
  *   - LCR and MCR are not at 3 and 4, they share 4
+ *   - No SCR (Instead, CHAR can be used as a scratch register)
  *   - Divisor latch at 9, no divisor latch access bit
  */
 
 #define UNIPHIER_UART_REGSHIFT		2
 
-/* bit[15:8] = CHAR (not used), bit[7:0] = FCR */
+/* bit[15:8] = CHAR, bit[7:0] = FCR */
 #define UNIPHIER_UART_CHAR_FCR		(3 << (UNIPHIER_UART_REGSHIFT))
 /* bit[15:8] = LCR, bit[7:0] = MCR */
 #define UNIPHIER_UART_LCR_MCR		(4 << (UNIPHIER_UART_REGSHIFT))
@@ -72,13 +73,18 @@ OF_EARLYCON_DECLARE(uniphier, "socionext,uniphier-uart",
 
 /*
  * The register map is slightly different from that of 8250.
- * IO callbacks must be overridden for correct access to FCR, LCR, and MCR.
+ * IO callbacks must be overridden for correct access to FCR, LCR, MCR and SCR.
  */
 static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
 {
 	unsigned int valshift = 0;
 
 	switch (offset) {
+	case UART_SCR:
+		/* No SCR for this hardware.  Use CHAR as a scratch register */
+		valshift = 8;
+		offset = UNIPHIER_UART_CHAR_FCR;
+		break;
 	case UART_LCR:
 		valshift = 8;
 		/* fall through */
@@ -91,8 +97,8 @@ static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
 	}
 
 	/*
-	 * The return value must be masked with 0xff because LCR and MCR reside
-	 * in the same register that must be accessed by 32-bit write/read.
+	 * The return value must be masked with 0xff because some registers
+	 * share the same offset that must be accessed by 32-bit write/read.
 	 * 8 or 16 bit access to this hardware result in unexpected behavior.
 	 */
 	return (readl(p->membase + offset) >> valshift) & 0xff;
@@ -101,9 +107,13 @@ static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
 static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 {
 	unsigned int valshift = 0;
-	bool normal = true;
+	bool normal = false;
 
 	switch (offset) {
+	case UART_SCR:
+		/* No SCR for this hardware.  Use CHAR as a scratch register */
+		valshift = 8;
+		/* fall through */
 	case UART_FCR:
 		offset = UNIPHIER_UART_CHAR_FCR;
 		break;
@@ -114,10 +124,10 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 		/* fall through */
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
-		normal = false;
 		break;
 	default:
 		offset <<= UNIPHIER_UART_REGSHIFT;
+		normal = true;
 		break;
 	}
 
-- 
2.7.4
