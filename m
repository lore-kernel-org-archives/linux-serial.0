From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Mon, 24 Dec 2018 15:43:00 +0000
Message-ID: <20181224154255.rjrickousqbfvdjs@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <93a3c76b-f4ba-57ae-9d80-6e945b4f3181@denx.de>
 <20181216213901.hpll7wqzhqvfgkfy@pburton-laptop>
 <28a1d4ae-493d-8bbc-46f7-ad41ca04d782@denx.de>
 <20181216222815.4t4xhaiy6rvfaogq@pburton-laptop>
 <78839e8c-0278-6060-0dd2-a84a19258a8a@denx.de>
 <20181221210818.g3kbv7bnr577dane@pburton-laptop>
 <0266be47-75c8-6a1b-dfec-129c5b7bbf8f@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <0266be47-75c8-6a1b-dfec-129c5b7bbf8f@denx.de>
Content-Language: en-US
Content-ID: <9FEFA0B66E4750498F17B727F327F74D@namprd22.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Fri, Dec 21, 2018 at 11:02:03PM +0100, Marek Vasut wrote:
> >> I shared the entire testcase, which now fails on AM335x due to this
> >> revert. Is there any progress on a proper fix from your side which doe=
s
> >> not break the AM335x ?
> >=20
> > No.
> >=20
> > Let's be clear - I didn't break your AM335x system, your broken patch
> > says that Daniel did with a commit applied back in v4.10. As such I
> > don't consider it my responsibility to fix your problem at all, I don't
> > have any access to the hardware anyway & I won't be buying hardware to
> > fix a bug for you.
> >=20
> > Despite all that I did write a patch which I expect would have solved
> > the problem for both of us, which is linked *twice* in the quoted email=
s
> > above & which as far as I can tell you *still* have not tested. I can
> > only surmise that you're trying deliberately to be annoying at this
> > point.
> >=20
> > If you want to try the patch I already wrote, and confirm whether it
> > actually works for you, then let's talk. Otherwise we're done here.
>=20
> Understood. However I did test your patch, but it was generating
> spurious IRQs and overruns (ttyS ttyS2: 91 input overrun(s)) on the
> AM335x, so that's not a proper solution.

OK, thanks for testing, and let's figure out what's going on. Since the
revert is in now I'd suggest starting from there - ie. approximately
from the code we've had since v4.10.

> I even brought the CI20 V2 I have back to life (yes, I bought one). The
> patch Ezequiel posted did fix the problem on the CI20, and did not break
> the AM335x, so I'd prefer if it was revisited instead of a heavy-handed
> revert.

As I described in an earlier email & on IRC, Ezequiel's one-liner does
not address all of the problems listed in my revert's commit message.
But again, since the revert is now in I suggest starting from there.

As neither a maintainer or significant contributor to
drivers/tty/serial, nor the author of the patch applied in v4.10 which
you say broke AM335x, nor someone with access to the affected hardware,
I'm probably not the best placed person to help you here - all I can do
is offer general debug suggestions. With that in mind, here are some
questions & ideas I have:

 1) Your message for commit f6aa5beb45be ("serial: 8250: Fix clearing
    FIFOs in RS485 mode again") suggests that the problem you're seeing
    is specific to the __do_stop_tx_rs485() path. Does changing only
    __do_stop_tx_rs485() to clear the FIFOs without disabling them,
    without modifying other users of serial8250_clear_fifos(), fix your
    problem? ie. does the following work?

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index f776b3eafb96..18d2a1a93f03 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1458,17 +1458,21 @@ static void serial8250_stop_rx(struct uart_port *po=
rt)
 }
=20
 static void __do_stop_tx_rs485(struct uart_8250_port *p)
 {
+	unsigned char fcr;
+
 	serial8250_em485_rts_after_send(p);
=20
 	/*
 	 * Empty the RX FIFO, we are not interested in anything
 	 * received during the half-duplex transmission.
 	 * Enable previously disabled RX interrupts.
 	 */
 	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-		serial8250_clear_fifos(p);
+		fcr =3D serial_port_in(&p->port, UART_FCR);
+		serial_port_out(&p->port, UART_FCR,
+				fcr | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
=20
 		p->ier |=3D UART_IER_RLSI | UART_IER_RDI;
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}

    Based on the comment above maybe leaving UART_FCR_CLEAR_XMIT out of
    that might make sense too..?

    Having __do_stop_tx_rs485() not share the FIFO clearing code with
    other callers may make sense given that so far as I can see
    __do_stop_tx_rs485() runs whilst the port is in use & other callers
    of serial8250_clear_fifos() do not.

 2) In an earlier email you said "The problem the original patch fixed
    was that too many bits were cleared in the FCR on OMAP3/AM335x".
    Could you clarify which bits we're talking about? From the AM335x
    reference manual I can only see the DMA_MODE bit & the
    [RT]X_FIFO_TRIG fields. Do you know which are problematic & why? In
    your commit message you mention the AM335x UART swallowing &
    retransmitting bytes - which field changing causes that?

> And I'd prefer to keep this thread alive, since I am still convinced
> that the FIFO handling code is wrong. Moreover, considering the UME bit
> on JZ4780 in FCR, the original code should confuse the UART on the
> JZ4780 too, although this might be hidden by some other surrounding code
> specific to the 8250 core on the JZ4780.

For completeness, as I said in an earlier email in the thread and as
we've since discussed on IRC, this is incorrect because
ingenic_uart_serial_out() unconditionally sets the UME bit. As such the
UME bit is not a problem, and JZ4780 works fine both before your patch &
after the revert.

Thanks,
    Paul
