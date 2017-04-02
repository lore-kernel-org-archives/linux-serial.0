From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 3/5] serial: small Makefile reordering
Date: Sun, 2 Apr 2017 11:49:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704021146340.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <20170401222119.25106-4-nicolas.pitre@linaro.org> <CAHp75VdFBSWmEk9e3bFKu3Kx7EjigrrFrL82+iRsxrW7dC1FoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdFBSWmEk9e3bFKu3Kx7EjigrrFrL82+iRsxrW7dC1FoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sun, 2 Apr 2017, Andy Shevchenko wrote:

> On Sun, Apr 2, 2017 at 1:21 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > Move 21285 entry down alongside other UART drivers to be more consistent
> > with the rest of the file. It is kept before 8250 though, to preserve the
> > existing link ordering between those two.
> 
> I did once for entire Makefile (some logical reordering), but Greg
> objected it. Perhaps you can sell it better.
> http://www.spinics.net/lists/linux-serial/msg23616.html

The 21285 entry is the only one that clearly is out of place.
I suppose that the rest is debatable.

> 
> >
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  drivers/tty/serial/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > index 2d6288bc45..53c03e0051 100644
> > --- a/drivers/tty/serial/Makefile
> > +++ b/drivers/tty/serial/Makefile
> > @@ -3,7 +3,6 @@
> >  #
> >
> >  obj-$(CONFIG_SERIAL_CORE) += serial_core.o
> > -obj-$(CONFIG_SERIAL_21285) += 21285.o
> >
> >  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
> >  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
> > @@ -17,6 +16,8 @@ obj-$(CONFIG_SERIAL_SUNZILOG) += sunzilog.o
> >  obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
> >  obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
> >
> > +obj-$(CONFIG_SERIAL_21285) += 21285.o
> > +
> >  # Now bring in any enabled 8250/16450/16550 type drivers.
> >  obj-$(CONFIG_SERIAL_8250) += 8250/
> >
> > --
> > 2.9.3
> >
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
