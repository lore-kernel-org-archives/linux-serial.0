From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 7/7] tty: serial: lpuart: add a more accurate baud rate calculation method
Date: Tue, 13 Jun 2017 10:55:54 +0800
Message-ID: <1497322554-24463-8-git-send-email-aisheng.dong@nxp.com>
References: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, nikita.yoush@cogentembedded.com, andy.shevchenko@gmail.com, dongas86@gmail.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

On new LPUART versions, the oversampling ratio for the receiver can be
changed from 4x (00011) to 32x (11111) which could help us get a more
accurate baud rate divider.

The idea is to use the best OSR (over-sampling rate) possible.
Note, OSR is typically hard-set to 16 in other LPUART instantiations.
Loop to find the best OSR value possible, one that generates minimum
baud diff iterate through the rest of the supported values of OSR.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * No changes
v2->v3:
 * enable new baud rate calculation method by default to get Layerscape
   platforms run and test.
 * break out in case we already find the minum baud_diff
v1->v2:
 * No changes
---
 drivers/tty/serial/fsl_lpuart.c | 79 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a0f2666..343de8c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -140,6 +140,8 @@
 #define UARTBAUD_SBNS		0x00002000
 #define UARTBAUD_SBR		0x00000000
 #define UARTBAUD_SBR_MASK	0x1fff
+#define UARTBAUD_OSR_MASK       0x1f
+#define UARTBAUD_OSR_SHIFT      24
 
 #define UARTSTAT_LBKDIF		0x80000000
 #define UARTSTAT_RXEDGIF	0x40000000
@@ -1511,6 +1513,75 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 }
 
 static void
+lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
+{
+	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
+	u32 clk = sport->port.uartclk;
+
+	/*
+	 * The idea is to use the best OSR (over-sampling rate) possible.
+	 * Note, OSR is typically hard-set to 16 in other LPUART instantiations.
+	 * Loop to find the best OSR value possible, one that generates minimum
+	 * baud_diff iterate through the rest of the supported values of OSR.
+	 *
+	 * Calculation Formula:
+	 *  Baud Rate = baud clock / ((OSR+1) × SBR)
+	 */
+	baud_diff = baudrate;
+	osr = 0;
+	sbr = 0;
+
+	for (tmp_osr = 4; tmp_osr <= 32; tmp_osr++) {
+		/* calculate the temporary sbr value  */
+		tmp_sbr = (clk / (baudrate * tmp_osr));
+		if (tmp_sbr == 0)
+			tmp_sbr = 1;
+
+		/*
+		 * calculate the baud rate difference based on the temporary
+		 * osr and sbr values
+		 */
+		tmp_diff = clk / (tmp_osr * tmp_sbr) - baudrate;
+
+		/* select best values between sbr and sbr+1 */
+		tmp = clk / (tmp_osr * (tmp_sbr + 1));
+		if (tmp_diff > (baudrate - tmp)) {
+			tmp_diff = baudrate - tmp;
+			tmp_sbr++;
+		}
+
+		if (tmp_diff <= baud_diff) {
+			baud_diff = tmp_diff;
+			osr = tmp_osr;
+			sbr = tmp_sbr;
+
+			if (!baud_diff)
+				break;
+		}
+	}
+
+	/* handle buadrate outside acceptable rate */
+	if (baud_diff > ((baudrate / 100) * 3))
+		dev_warn(sport->port.dev,
+			 "unacceptable baud rate difference of more than 3%%\n");
+
+	tmp = lpuart32_read(&sport->port, UARTBAUD);
+
+	if ((osr > 3) && (osr < 8))
+		tmp |= UARTBAUD_BOTHEDGE;
+
+	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
+	tmp |= (((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT);
+
+	tmp &= ~UARTBAUD_SBR_MASK;
+	tmp |= sbr & UARTBAUD_SBR_MASK;
+
+	tmp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
+
+	lpuart32_write(&sport->port, tmp, UARTBAUD);
+}
+
+static void
 lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 		   struct ktermios *old)
 {
@@ -1519,7 +1590,6 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long ctrl, old_ctrl, bd, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
-	unsigned int sbr;
 
 	ctrl = old_ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	bd = lpuart32_read(&sport->port, UARTBAUD);
@@ -1616,12 +1686,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
 		       UARTCTRL);
 
-	sbr = sport->port.uartclk / (16 * baud);
-	bd &= ~UARTBAUD_SBR_MASK;
-	bd |= sbr & UARTBAUD_SBR_MASK;
-	bd |= UARTBAUD_BOTHEDGE;
-	bd &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
-	lpuart32_write(&sport->port, bd, UARTBAUD);
+	lpuart32_serial_setbrg(sport, baud);
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 	/* restore control register */
-- 
2.7.4
