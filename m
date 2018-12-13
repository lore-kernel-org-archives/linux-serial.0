From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Date: Thu, 13 Dec 2018 03:33:02 +0000
Message-ID: <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
 <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
Content-Language: en-US
Content-ID: <1419985650AB9D43A74B10BCE9FE6B39@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2018 at 03:27:51AM +0100, Marek Vasut wrote:
> > I wonder whether the issue may be the JZ4780 UART not automatically
> > resetting the FIFOs when FCR[0] changes. This is a guess, but the manua=
l
> > doesn't explicitly say it'll happen & the programming example it gives
> > says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
> > the kernel has been doing for at least the whole git era I wouldn't be
> > surprised if other devices are bitten by the change as people start
> > trying 4.20 on them.
>=20
> The patch you're complaining about is doing exactly that -- it sets
> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears it.
> Those two bits are exactly FCR[2:1]. It also explicitly does not touch
> any other bits in FCR.

No - your patch does that *only* if the FIFO enable bit is set, and
presumes that clearing FIFOs is a no-op when they're disabled. I don't
believe that's true on my system. I also believe that not touching the
FIFO enable bit is problematic, since some callers clearly expect that
to be cleared.

> > @@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_82=
50_port *p)
> >  	if (p->capabilities & UART_CAP_FIFO) {
> >  		/*
> >  		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
> > -		 * In case ENABLE_FIFO is not set, there is nothing to flush
> > -		 * so just return. Furthermore, on certain implementations of
> > -		 * the 8250 core, the FCR[7:3] bits may only be changed under
> > -		 * specific conditions and changing them if those conditions
> > -		 * are not met can have nasty side effects. One such core is
> > -		 * the 8250-omap present in TI AM335x.
> > +		 * On certain implementations of the 8250 core, the FCR[7:3]
> > +		 * bits may only be changed under specific conditions and
> > +		 * changing them if those conditions are not met can have nasty
> > +		 * side effects. One such core is the 8250-omap present in TI
> > +		 * AM335x.
> >  		 */
> >  		fcr =3D serial_in(p, UART_FCR);
> > +		serial_out(p, UART_FCR, fcr | clr_mask);
> > +		serial_out(p, UART_FCR, fcr & ~clr);
>=20
> Note that, if I understand the patch correctly, this will _not_ restore
> the original (broken) behavior. The original behavior cleared the entire
> FCR at the end, which cleared even bits that were not supposed to be
> cleared .

It will restore the original behaviour with regards to disabling the
FIFOs, so long as callers that expect that use
serial8250_clear_and_disable_fifos().

> This patch will make things worse by retaining the clr_mask set in the
> FCR, thus the FCR[2:1] will be set when you return from this function.
> That cannot be right ?

You're mistaken - clr_mask (ie. the FIFO reset bits) get cleared again
by the second call to serial_out(), I just did it without modifying the
fcr variable - ie. we write the original fcr value again at the end, but
with UART_FCR_ENABLE_FIFO cleared in the
serial8250_clear_and_disable_fifos() case. It would probably be clearer
with the clr argument renamed disable or something like that.

Thanks,
    Paul
