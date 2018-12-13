From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Date: Thu, 13 Dec 2018 05:11:57 +0000
Message-ID: <20181213051154.57h2ddfcbrgh65gy@pburton-laptop>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
 <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
 <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
 <b8525991-f539-a180-2e88-a70b29319413@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8525991-f539-a180-2e88-a70b29319413@denx.de>
Content-Language: en-US
Content-ID: <EC999F2FC142B1459760CB868F247F06@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2018 at 05:18:19AM +0100, Marek Vasut wrote:
> >>> I wonder whether the issue may be the JZ4780 UART not automatically
> >>> resetting the FIFOs when FCR[0] changes. This is a guess, but the man=
ual
> >>> doesn't explicitly say it'll happen & the programming example it give=
s
> >>> says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
> >>> the kernel has been doing for at least the whole git era I wouldn't b=
e
> >>> surprised if other devices are bitten by the change as people start
> >>> trying 4.20 on them.
> >>
> >> The patch you're complaining about is doing exactly that -- it sets
> >> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears it.
> >> Those two bits are exactly FCR[2:1]. It also explicitly does not touch
> >> any other bits in FCR.
> >=20
> > No - your patch does that *only* if the FIFO enable bit is set, and
> > presumes that clearing FIFOs is a no-op when they're disabled. I don't
> > believe that's true on my system. I also believe that not touching the
> > FIFO enable bit is problematic, since some callers clearly expect that
> > to be cleared.
>=20
> Why would you disable FIFO to clear it ? This doesn't make sense to me,
> the FIFO must be operational for it to be cleared. Moreover, it
> contradicts your previous statement, "the programming example it gives
> says to explicitly clear the FIFOs using FCR[2:1]" .

No, no, not at all... I'm saying that my theory is:

  - The JZ4780 requires that the FIFO be reset using FCR[2:1] in order
    to not read garbage.

  - Prior to your patch serial8250_clear_fifos() did this,
    unconditionally.

  - After your patch serial8250_clear_fifos() only clears the FIFOs if
    the FIFO is already enabled.

  - When called from serial8250_do_startup() during boot, the FIFO may
    not be enabled - for example if the bootloader didn't use the FIFO,
    or if the UART is used with 8250_early which zeroes FCR.

  - Therefore after your patch the FIFO reset bits are never set if the
    UART was used with 8250_early, or if it wasn't but the bootloader
    didn't enable the FIFO.

I suspect that you get away with that because according to the PC16550D
documentation the FIFOs should reset when the FIFO enable bit changes,
so when the FIFO is later enabled it gets reset. I suspect that in the
JZ4780 this does not happen, and the FIFO contains garbage. Our previous
behaviour (always set FCR[2:1] to reset the FIFO) has been around for a
long time, so I would not be surprised to find other devices relying
upon it.

I'm also saying that if the FIFOs are enabled during boot then your
patch will leave them enabled after serial8250_do_startup() calls
serial8250_clear_fifos(), which a comment in serial8250_do_startup()
clearly states is not the expected behaviour:

> Clear the FIFO buffers and disable them.
> (they will be reenabled in set_termios())

(From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/tty/serial/8250/8250_port.c?h=3Dv4.20-rc6#n2209)

And further, with your patch serial8250_do_shutdown() will leave the
FIFO enabled which again does not match what comments suggest it expects
("Disable break condition and FIFOs").

> What exactly does your programming example for the JZ4780 say about the
> FIFO clearing ? And does it work in that example ?

It says to set FCR[2:1] to reset the FIFO after enabling it, which as
far as I can tell from the PC16550D documentation would not be necessary
there because when you enable the FIFO it would automatically be reset.
Linux did this until your patch.

> >>> @@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_=
8250_port *p)
> >>>  	if (p->capabilities & UART_CAP_FIFO) {
> >>>  		/*
> >>>  		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
> >>> -		 * In case ENABLE_FIFO is not set, there is nothing to flush
> >>> -		 * so just return. Furthermore, on certain implementations of
> >>> -		 * the 8250 core, the FCR[7:3] bits may only be changed under
> >>> -		 * specific conditions and changing them if those conditions
> >>> -		 * are not met can have nasty side effects. One such core is
> >>> -		 * the 8250-omap present in TI AM335x.
> >>> +		 * On certain implementations of the 8250 core, the FCR[7:3]
> >>> +		 * bits may only be changed under specific conditions and
> >>> +		 * changing them if those conditions are not met can have nasty
> >>> +		 * side effects. One such core is the 8250-omap present in TI
> >>> +		 * AM335x.
> >>>  		 */
> >>>  		fcr =3D serial_in(p, UART_FCR);
> >>> +		serial_out(p, UART_FCR, fcr | clr_mask);
> >>> +		serial_out(p, UART_FCR, fcr & ~clr);
> >>
> >> Note that, if I understand the patch correctly, this will _not_ restor=
e
> >> the original (broken) behavior. The original behavior cleared the enti=
re
> >> FCR at the end, which cleared even bits that were not supposed to be
> >> cleared .
> >=20
> > It will restore the original behaviour with regards to disabling the
> > FIFOs, so long as callers that expect that use
> > serial8250_clear_and_disable_fifos().
>=20
> Does your platform need the FIFO to be explicitly disabled for it to be
> cleared, can you confirm that ? And if so, does this apply to other
> platforms with 8250 UART or is this specific to JZ4780 implementation of
> the UART block ?
>=20
> I just remembered U-Boot has this patch for JZ4780 UART [1], which
> touches the FCR UME bit, so the FCR behavior on JZ4780 does differ from
> the generic 8250 core. Could it be that this is what you're hitting ?

No - we already set the UME bit & this has all worked fine until your
patch changed the FIFO reset behaviour.

Thanks,
    Paul
