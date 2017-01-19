From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 1/3] gpio: exar: add gpio for exar cards
Date: Thu, 19 Jan 2017 14:22:01 +0100
Message-ID: <20170119132201.GA29998@kroah.com>
References: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VfcUr-1sjh+xySHMaeNEi7QxHANvqbHGwt9=uWeOvMCJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfcUr-1sjh+xySHMaeNEi7QxHANvqbHGwt9=uWeOvMCJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 15, 2017 at 04:57:32PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 15, 2017 at 12:50 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> >
> > Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> > can be controlled using gpio interface.
> >
> > Add the gpio specific code.
> 
> Thanks for an updated code.
> Briefly looking into first two patches v10 would be needed.
> 
> Here one important line is missed, nevertheless I'll go to comment
> some minor stuff as well.
> Overall looks good!
> 
> > name[16] should be enough. Maximum of 12 char will be used.
> 
> Better to use enough space, otherwise there is a room for a bug.
> So, you need to understand that kernel might crash in such cases,
> though it's minor for now.
> 
> > +++ b/drivers/gpio/gpio-exar.c
> > @@ -0,0 +1,199 @@
> 
> > +static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
> > +                       unsigned int offset)
> > +{
> > +       struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
> > +       int temp;
> > +
> > +       mutex_lock(&exar_gpio->lock);
> > +       temp = readb(exar_gpio->regs + reg);
> > +       temp &= ~BIT(offset);
> 
> > +       if (val)
> > +               temp |= BIT(offset);
> 
> You would do this in one line, but I dunno which style Linus prefers more
> 
> temp |= val ? BIT(...) : 0;

Use the if () format, it's easier to read and understand, which is more
important overall.

thanks,

greg k-h
