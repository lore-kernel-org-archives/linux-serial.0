From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Fri, 3 Mar 2017 20:44:14 +0100
Message-ID: <20170303194414.n76tr3oa2mlrzjre@pengutronix.de>
References: <20170303142201.16452-1-richard.genoud@gmail.com>
 <CAMuHMdX-K9B20Tu5NtHJRHmGGuT60OFu8TokZxsF8aSaS7HuHQ@mail.gmail.com>
 <20170303191248.wlwjri55ip2x5pgg@pengutronix.de>
 <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXFrwa2jCVDb+8ecqgARLG0oGrPp9pLs0b6vEiWeKJ+uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>
List-Id: linux-serial@vger.kernel.org

Hello Geert,

On Fri, Mar 03, 2017 at 08:21:05PM +0100, Geert Uytterhoeven wrote:
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 91e7dddbf72c..2f4cdd4e7b4f 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -3022,7 +3022,7 @@ static int sci_probe_single(struct platform_device *dev,
> >                 return ret;
> >
> >         sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
> > -       if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
> > +       if (IS_ERR(sciport->gpios))
> >                 return PTR_ERR(sciport->gpios);
> 
> Now the sh-sci driver fails to probe on legacy platforms where GPIOLIB=n.
> The check for -ENOSYS made it succeed before.

That's right, intended and the only option that's save (for some
definition of save; the obvious downside is that there is no
/dev/tty$whatever for you).

Ignoring -ENOSYS is only ok if your device doesn't have a cts-gpio. If
it has, ignoring -ENOSYS hides bugs because the driver sends data while
it shouldn't or cannot signal the other side that it should stop (or
start) a transmission.

So the options are:
 - enable GPIOLIB (maybe enforce that by letting the driver select it)
 - introduce a CONFIG_HALFGPIOLIB that makes gpiod_get_optional and
   mctrl_gpio_init return only then -ENOSYS if there is a gpio specified
   and NULL otherwise.

> > Then mctrl_gpio_to_gpiod isn't called. I don't have a machine to test
> > this, but I think currently this makes the machine barf to continue
> > here because with sciport->gpios = ERR_PTR(-ENOSYS) calling
> >
> >         mctrl_gpio_to_gpiod(sciport->gpios, ...)
> >
> > is a bad idea.
> 
> If sciport->gpios == ERR_PTR(-ENOSYS), CONFIG_GPIOLIB is not enabled, the
> feature is not available, and mctrl_gpio_to_gpiod() will not
> dereference the error
> pointer.

Ah, makes sense.

> >> Perhaps mctrl_gpio_to_gpiod() should always return NULL if !CONFIG_GPIOLIB?
> >
> > No, mctrl_gpio_to_gpiod is right. You are only supposed to call it if
> > mctrl_gpio_init succeeded.
> 
> Then I have to add checks for sciport->gpios == ERR_PTR(-ENOSYS)...

No, ignoring -ENOSYS is wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
