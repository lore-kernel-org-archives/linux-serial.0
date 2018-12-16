From: Paul Burton <paul.burton@mips.com>
Subject: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"
Date: Sun, 16 Dec 2018 20:10:01 +0000
Message-ID: <20181216200833.27928-1-paul.burton@mips.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, Marek Vasut <marex@denx.de>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Commit f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode
again") makes a change to FIFO clearing code which its commit message
suggests was intended to be specific to use with RS485 mode, however:

 1) The change made does not just affect __do_stop_tx_rs485(), it also
    affects other uses of serial8250_clear_fifos() including paths for
    starting up, shutting down or auto-configuring a port regardless of
    whether it's an RS485 port or not.

 2) It makes the assumption that resetting the FIFOs is a no-op when
    FIFOs are disabled, and as such it checks for this case & explicitly
    avoids setting the FIFO reset bits when the FIFO enable bit is
    clear. A reading of the PC16550D manual would suggest that this is
    OK since the FIFO should automatically be reset if it is later
    enabled, but we support many 16550-compatible devices and have never
    required this auto-reset behaviour for at least the whole git era.
    Starting to rely on it now seems risky, offers no benefit, and
    indeed breaks at least the Ingenic JZ4780's UARTs which reads
    garbage when the RX FIFO is enabled if we don't explicitly reset it.

 3) By only resetting the FIFOs if they're enabled, the behaviour of
    serial8250_do_startup() during boot now depends on what the value of
    FCR is before the 8250 driver is probed. This in itself seems
    questionable and leaves us with FCR=3D0 & no FIFO reset if the UART
    was used by 8250_early, otherwise it depends upon what the
    bootloader left behind.

 4) Although the naming of serial8250_clear_fifos() may be unclear, it
    is clear that callers of it expect that it will disable FIFOs. Both
    serial8250_do_startup() & serial8250_do_shutdown() contain comments
    to that effect, and other callers explicitly re-enable the FIFOs
    after calling serial8250_clear_fifos(). The premise of that patch
    that disabling the FIFOs is incorrect therefore seems wrong.

For these reasons, this reverts commit f6aa5beb45be ("serial: 8250: Fix
clearing FIFOs in RS485 mode again").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode again"=
).
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Jedrychowski <avistel@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-mips@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: stable <stable@vger.kernel.org> # 4.10+
---
I did suggest an alternative approach which would rename
serial8250_clear_fifos() and split it into 2 variants - one that
disables FIFOs & one that does not, then use the latter in
__do_stop_tx_rs485():

https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-laptop=
/

However I have no access to the OMAP3 hardware that Marek's patch was
attempting to fix & have heard nothing back with regards to him testing
that approach, so here's a simple revert that fixes the Ingenic JZ4780.

I've marked for stable back to v4.10 presuming that this is how far the
broken patch may be backported, given that this is where commit
2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subsequent
transmits to break") that it tried to fix was introduced.
---
 drivers/tty/serial/8250/8250_port.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index f776b3eafb96..3f779d25ec0c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -552,30 +552,11 @@ static unsigned int serial_icr_read(struct uart_8250_=
port *up, int offset)
  */
 static void serial8250_clear_fifos(struct uart_8250_port *p)
 {
-	unsigned char fcr;
-	unsigned char clr_mask =3D UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
-
 	if (p->capabilities & UART_CAP_FIFO) {
-		/*
-		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
-		 * In case ENABLE_FIFO is not set, there is nothing to flush
-		 * so just return. Furthermore, on certain implementations of
-		 * the 8250 core, the FCR[7:3] bits may only be changed under
-		 * specific conditions and changing them if those conditions
-		 * are not met can have nasty side effects. One such core is
-		 * the 8250-omap present in TI AM335x.
-		 */
-		fcr =3D serial_in(p, UART_FCR);
-
-		/* FIFO is not enabled, there's nothing to clear. */
-		if (!(fcr & UART_FCR_ENABLE_FIFO))
-			return;
-
-		fcr |=3D clr_mask;
-		serial_out(p, UART_FCR, fcr);
-
-		fcr &=3D ~clr_mask;
-		serial_out(p, UART_FCR, fcr);
+		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
+			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+		serial_out(p, UART_FCR, 0);
 	}
 }
=20
@@ -1467,7 +1448,7 @@ static void __do_stop_tx_rs485(struct uart_8250_port =
*p)
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-		serial8250_clear_fifos(p);
+		serial8250_clear_and_reinit_fifos(p);
=20
 		p->ier |=3D UART_IER_RLSI | UART_IER_RDI;
 		serial_port_out(&p->port, UART_IER, p->ier);
--=20
2.20.0
