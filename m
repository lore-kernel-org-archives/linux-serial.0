From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"
Date: Sun, 16 Dec 2018 19:28:22 -0300
Message-ID: <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com> <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop> <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com> <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Marek Vasut <marex@denx.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>
List-Id: linux-serial@vger.kernel.org

On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Ezequiel,
>
> On Sun, Dec 16, 2018 at 06:52:53PM -0300, Ezequiel Garcia wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c
> > b/drivers/tty/serial/8250/8250_port.c
> > index c39482b96111..fac19cbc51d1 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2209,10 +2209,11 @@ int serial8250_do_startup(struct uart_port *por=
t)
> >         /*
> >          * Clear the FIFO buffers and disable them.
> >          * (they will be reenabled in set_termios())
> >          */
> >         serial8250_clear_fifos(up);
> > +       serial_out(up, UART_FCR, 0);
> >
> >         /*
> >          * Clear the interrupt registers.
> >          */
> >         serial_port_in(port, UART_LSR);
> >
>
> This helps, but it only addresses one part of one of the 4 reasons I
> listed as motivation for my revert. For example serial8250_do_shutdown()
> also clearly intends to disable the FIFOs.
>

OK. So, let's fix that :-)

By all means, it would be really nice to push forward and fix the garbage
issue on JZ4780, as well as the transmission issue on AM335x.

AM335x is a wildly popular platform, and it's not funny to break it.
So, let's please stop discussing which board we'll break and just fix both.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
