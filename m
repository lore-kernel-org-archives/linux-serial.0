From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 11/24] tty: serial: fsl_lpuart: Drop unnecessary extra parenthesis
Date: Mon, 29 Jul 2019 12:52:13 -0700
Message-ID: <20190729195226.8862-12-andrew.smirnov@gmail.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729195226.8862-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Drop unnecessary extra parenthesis in the driver.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5181ba5d8f71..5a1e19733353 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1443,7 +1443,7 @@ static int lpuart_startup(struct uart_port *port)
 	lpuart_setup_watermark(sport);
 
 	temp = readb(sport->port.membase + UARTCR2);
-	temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+	temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 	writeb(temp, sport->port.membase + UARTCR2);
 
 	if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
@@ -1652,7 +1652,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
-		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem |= UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
 	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
 
@@ -1663,7 +1663,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CSIZE) == CS7)
 		termios->c_cflag |= PARENB;
 
-	if ((termios->c_cflag & PARENB)) {
+	if (termios->c_cflag & PARENB) {
 		if (termios->c_cflag & CMSPAR) {
 			cr1 &= ~UARTCR1_PE;
 			if (termios->c_cflag & PARODD)
@@ -1702,7 +1702,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |=	(UARTSR1_FE | UARTSR1_PE);
+		sport->port.read_status_mask |= UARTSR1_FE | UARTSR1_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
 		sport->port.read_status_mask |= UARTSR1_FE;
 
@@ -1816,7 +1816,7 @@ lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
 		tmp |= UARTBAUD_BOTHEDGE;
 
 	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
-	tmp |= (((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT);
+	tmp |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
 
 	tmp &= ~UARTBAUD_SBR_MASK;
 	tmp |= sbr & UARTBAUD_SBR_MASK;
@@ -1869,7 +1869,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	if (termios->c_cflag & CRTSCTS) {
-		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
+		modem |= UARTMODEM_RXRTSE | UARTMODEM_TXCTSE;
 	} else {
 		termios->c_cflag &= ~CRTSCTS;
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
@@ -1918,7 +1918,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |=	(UARTSTAT_FE | UARTSTAT_PE);
+		sport->port.read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
 		sport->port.read_status_mask |= UARTSTAT_FE;
 
@@ -2085,7 +2085,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 
 	/* first save CR2 and then disable interrupts */
 	cr2 = old_cr2 = readb(sport->port.membase + UARTCR2);
-	cr2 |= (UARTCR2_TE |  UARTCR2_RE);
+	cr2 |= UARTCR2_TE | UARTCR2_RE;
 	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
 	writeb(cr2, sport->port.membase + UARTCR2);
 
@@ -2116,7 +2116,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 
 	/* first save CR2 and then disable interrupts */
 	cr = old_cr = lpuart32_read(&sport->port, UARTCTRL);
-	cr |= (UARTCTRL_TE |  UARTCTRL_RE);
+	cr |= UARTCTRL_TE | UARTCTRL_RE;
 	cr &= ~(UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE);
 	lpuart32_write(&sport->port, cr, UARTCTRL);
 
@@ -2574,7 +2574,7 @@ static int lpuart_resume(struct device *dev)
 	} else {
 		lpuart_setup_watermark(sport);
 		temp = readb(sport->port.membase + UARTCR2);
-		temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+		temp |= UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE;
 		writeb(temp, sport->port.membase + UARTCR2);
 	}
 
-- 
2.21.0
