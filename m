From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Date: Thu, 13 Dec 2018 17:48:35 +0000
Message-ID: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
 <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
 <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
 <b8525991-f539-a180-2e88-a70b29319413@denx.de>
 <20181213051154.57h2ddfcbrgh65gy@pburton-laptop>
 <372cccd7-a175-2737-5af8-3072606c6b1c@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <372cccd7-a175-2737-5af8-3072606c6b1c@denx.de>
Content-Language: en-US
Content-ID: <D4DF80A75FF67744BCC104FA99B52294@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2018 at 03:51:02PM +0100, Marek Vasut wrote:
> >>>>> I wonder whether the issue may be the JZ4780 UART not automatically
> >>>>> resetting the FIFOs when FCR[0] changes. This is a guess, but the m=
anual
> >>>>> doesn't explicitly say it'll happen & the programming example it gi=
ves
> >>>>> says to explicitly clear the FIFOs using FCR[2:1]. Since this is wh=
at
> >>>>> the kernel has been doing for at least the whole git era I wouldn't=
 be
> >>>>> surprised if other devices are bitten by the change as people start
> >>>>> trying 4.20 on them.
> >>>>
> >>>> The patch you're complaining about is doing exactly that -- it sets
> >>>> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears i=
t.
> >>>> Those two bits are exactly FCR[2:1]. It also explicitly does not tou=
ch
> >>>> any other bits in FCR.
> >>>
> >>> No - your patch does that *only* if the FIFO enable bit is set, and
> >>> presumes that clearing FIFOs is a no-op when they're disabled. I don'=
t
> >>> believe that's true on my system. I also believe that not touching th=
e
> >>> FIFO enable bit is problematic, since some callers clearly expect tha=
t
> >>> to be cleared.
> >>
> >> Why would you disable FIFO to clear it ? This doesn't make sense to me=
,
> >> the FIFO must be operational for it to be cleared. Moreover, it
> >> contradicts your previous statement, "the programming example it gives
> >> says to explicitly clear the FIFOs using FCR[2:1]" .
> >=20
> > No, no, not at all... I'm saying that my theory is:
> >=20
> >   - The JZ4780 requires that the FIFO be reset using FCR[2:1] in order
> >     to not read garbage.
>=20
> Which we do

No - we don't... We used to, but your patch stops that from happening if
the FIFO enable bit is clear.... And the FIFO enable bit is clear during
serial8250_do_startup() if the UART was used with earlycon, otherwise it
depends on state left behind by the bootloader. I don't know how many
ways I can say this.

> >   - Prior to your patch serial8250_clear_fifos() did this,
> >     unconditionally.
>=20
> btw originally, this also cleared the UME bit. Could this be what made
> the difference on the JZ4780 ?

It did not, you are wrong. serial_out() calls ingenic_uart_serial_out()
which unconditionally or's in the UME bit for writes to FCR.

> >   - After your patch serial8250_clear_fifos() only clears the FIFOs if
> >     the FIFO is already enabled.
>=20
> I'd suppose this is OK, since clearing a disabled FIFO makes no sense ?

This is where the brokenness seems to come from. As I said, this would
be fine according to the PC16550D documentation but I can say based on
experimentation that it is *not* fine on the JZ4780.

Resetting a disabled FIFO makes perfect sense if it's going to be
enabled later. That used to happen, and after your patch it doesn't.

> >   - When called from serial8250_do_startup() during boot, the FIFO may
> >     not be enabled - for example if the bootloader didn't use the FIFO,
> >     or if the UART is used with 8250_early which zeroes FCR.
>=20
> If it's not enabled, do you need to clear it ?
>=20
> >   - Therefore after your patch the FIFO reset bits are never set if the
> >     UART was used with 8250_early, or if it wasn't but the bootloader
> >     didn't enable the FIFO.
>=20
> Hence my question above, do you need to clear the FIFO even if it was
> not enabled ?

Yes.

What you asked before though was whether we need to disable the FIFO in
order to clear it, which is a different question.

> > I suspect that you get away with that because according to the PC16550D
> > documentation the FIFOs should reset when the FIFO enable bit changes,
> > so when the FIFO is later enabled it gets reset. I suspect that in the
> > JZ4780 this does not happen, and the FIFO contains garbage. Our previou=
s
> > behaviour (always set FCR[2:1] to reset the FIFO) has been around for a
> > long time, so I would not be surprised to find other devices relying
> > upon it.
>=20
> It is well possible, but I'd like to understand what really happens
> here, not just guess.

I can only tell you what little the JZ4780 manual says & what actually
works when I run it on my system. I used the word supect to explain my
theory, but that's the best we can do with the documentation available.

> > I'm also saying that if the FIFOs are enabled during boot then your
> > patch will leave them enabled after serial8250_do_startup() calls
> > serial8250_clear_fifos(), which a comment in serial8250_do_startup()
> > clearly states is not the expected behaviour:
>=20
> In that case, that needs to be fixed. But serial8250_clear_fifos()
> should only do what the name says -- clear FIFOs -- not disable them.

...which is why I effectively renamed it
serial8250_clear_and_disable_fifos() in my suggested patch. Did you test
it? I have no OMAP3 system to check that I didn't break your setup, and
at this point if I can't be sure it works I'll be submitting a revert of
your broken patch.

> >> Clear the FIFO buffers and disable them.
> >> (they will be reenabled in set_termios())
> >=20
> > (From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/tty/serial/8250/8250_port.c?h=3Dv4.20-rc6#n2209)
> >=20
> > And further, with your patch serial8250_do_shutdown() will leave the
> > FIFO enabled which again does not match what comments suggest it expect=
s
> > ("Disable break condition and FIFOs").
> >=20
> >> What exactly does your programming example for the JZ4780 say about th=
e
> >> FIFO clearing ? And does it work in that example ?
> >=20
> > It says to set FCR[2:1] to reset the FIFO after enabling it, which as
> > far as I can tell from the PC16550D documentation would not be necessar=
y
> > there because when you enable the FIFO it would automatically be reset.
> > Linux did this until your patch.
>=20
> Linux sets the FCR[2:1] if the FIFO is enabled even now.

Correct, but not when the FIFO is disabled in serial8250_do_startup(),
nor when the FIFO is later enabled in serial8250_do_set_termios().

> >> I just remembered U-Boot has this patch for JZ4780 UART [1], which
> >> touches the FCR UME bit, so the FCR behavior on JZ4780 does differ fro=
m
> >> the generic 8250 core. Could it be that this is what you're hitting ?
> >=20
> > No - we already set the UME bit & this has all worked fine until your
> > patch changed the FIFO reset behaviour.
>=20
> The UME bit is in the FCR, serial8250_clear_fifos() originally cleared
> it, cfr:
> -               serial_out(p, UART_FCR, 0);
> in f6aa5beb45be27968a4df90176ca36dfc4363d37 . So the code was originally
> completely disabling the UART on JZ4780 .

Again, wrong. Look at what serial_out() actually does & see
ingenic_uart_serial_out(). Again, the Ingenic UARTs have worked fine
until your patch, and work with mainline after reverting it - the
problem is *entirely* with the change you made & the UME bit has nothing
to do with it.

Thanks,
    Paul
