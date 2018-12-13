From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Date: Thu, 13 Dec 2018 00:41:22 +0000
Message-ID: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <211D3890AA0E0543B59BC94DFAD83100@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Marek / Greg / all,

On Mon, Sep 03, 2018 at 12:44:52AM +0000, Marek Vasut wrote:
> The 8250 FIFOs indeed need to be cleared after stopping transmission in
> RS485 mode without SER_RS485_RX_DURING_TX flag set. But there are two
> problems with the approach taken by the previous patch from Fixes tag.
>=20
> First, serial8250_clear_fifos() should clear fifos, but what it really
> does is it enables the FIFOs unconditionally if present, clears them
> and then sets the FCR register to zero, which effectively disables the
> FIFOs. In case the FIFO is disabled, enabling it and clearing it makes
> no sense and in fact can trigger misbehavior of the 8250 core. Moreover,
> the FCR register may contain other FIFO configuration bits which may not
> be writable unconditionally and writing them incorrectly can trigger
> misbehavior of the 8250 core too. (ie. AM335x UART swallows the first
> byte and retransmits the last byte twice because of this FCR write).
>=20
> Second, serial8250_clear_and_reinit_fifos() completely reloads the FCR,
> but what really has to happen at the end of the RS485 transmission is
> clearing of the FIFOs and nothing else.
>=20
> This patch repairs serial8250_clear_fifos() so that it really only
> clears the FIFOs by operating on FCR[2:1] bits and leaves all the
> other bits alone. It also undoes serial8250_clear_and_reinit_fifos()
> from __do_stop_tx_rs485() as serial8250_clear_fifos() is sufficient.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Fixes: 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subse=
quent transmits to break")
> Cc: Daniel Jedrychowski <avistel@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> NOTE: I am not entirely certain this won't break some other hardware,
>       esp. since there might be dependencies on the weird previous
>       behavior of the serial8250_clear_fifos() somewhere.

This patch has broken the UART on my Ingenic JZ4780 based MIPS Creator
Ci20 board. After this patch the system seems to detect garbage input
that is recognized as SysRq triggers which spam the console & eventually
reset the system.

One thing of note is that both serial8250_do_startup() &
serial8250_do_shutdown() contain comments that explicitly state their
expectation that the FIFOs will be disabled by serial8250_clear_fifos(),
which is no longer true after this patch.

I found that restoring the old behaviour for serial8250_do_startup() is
enough to make my system work again, but this is obviously a hack:

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index f776b3eafb96..8def02933d19 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2210,7 +2210,11 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
-	serial8250_clear_fifos(up);
+	if (up->capabilities & UART_CAP_FIFO) {
+		serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial8250_clear_fifos(up);
+		serial_port_out(port, UART_FCR, 0);
+	}
=20
 	/*
 	 * Clear the interrupt registers.

Any ideas? Given the mismatch between this patch & comments that clearly
expect the old behaviour I think the __do_stop_tx_rs485() case probably
needs something different to other callers.

Thanks,
    Paul
