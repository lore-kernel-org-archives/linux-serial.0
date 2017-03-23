From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
Date: Thu, 23 Mar 2017 20:10:20 +0100
Message-ID: <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de>
References: <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
 <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
 <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
 <20170323144325.GA952@dtor-ws>
 <20170323154441.GA9460@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323154441.GA9460@dtor-ws>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Janusz Uzycki <j.uzycki@elproma.com.pl>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 08:44:41AM -0700, Dmitry Torokhov wrote:
> On Thu, Mar 23, 2017 at 07:43:25AM -0700, Dmitry Torokhov wrote:
> > On Thu, Mar 23, 2017 at 02:41:53PM +0100, Linus Walleij wrote:
> > > On Thu, Mar 23, 2017 at 1:34 PM, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > 
> > > > Maybe we can make gpiod_get_optional look like this:
> > > >
> > > >         if (!dev->of_node && isnt_a_acpi_device(dev) && !IS_ENABLED(GPIOLIB))
> > > >                 return NULL;
> > > >         else
> > > >                 return -ENOSYS;
> > > >
> > > > I don't know how isnt_a_acpi_device looks like, probably it involves
> > > > CONFIG_ACPI and/or dev->acpi_node.
> > > >
> > > > This should be safe and still comfortable for legacy platforms, isn't it?
> > > 
> > > I like the looks of this.
> > > 
> > > Can we revert Dmitry's patch and apply something like this instead?
> > > 
> > > Dmitry, how do you feel about this?
> > 
> > I frankly do not see the point. It still makes driver code more complex

Note that this code is in the gpio header, and not in driver code. So
the driver just does

	gpiod = gpiod_get_optional(...)
	if (IS_ERR(gpiod))
		return PTR_ERR(gpiod);

(as it is supposed to do now). I think that's nice.

> > for no good reason. I also think that not having optional GPIO is not an
> > error, so returning value from error space is not correct. NULL is value
> > from another space altogether.

It seems you didn't understand my concern.

> > Uwe seems to be concerned about case that I find extremely unlikely. We
> > are talking about a system that does not have GPIO support and behaves
> > just fine, with the exception that it actually has (physically) a
> > *single* GPIO, and that GPIO happens to be optional in a single driver,
> > but in this particular system is actually needed (but that need
> > manifests in a non-obvious way). And we have system integrator that has
> > no idea what they are doing (no schematic, etc).

IMHO this is not an excuse to have lax error checking.

> > I think that if there is one optional GPIO there will be mandatiry GPIOs
> > in such system as well and selection of GPIOLIB will be forced early on
> > in board bringup.
> 
> One more thing: if we keep reporting -ENOSYS in case of !CONFIG_GPIOLIB,
> then most of the non platform-sepcific drivers will eventually gain code
> silently coping with this -ENOSYS:
> 
> 	data->gpiod = gpiod_getptional(...);
> 	if (IS_ERR(data->gpiod)) {
> 		error = PTR_ERR(data->gpiod);
> 		if (error != -ENOSYS)
> 			return error;
> 
> 		data->gpiod = NULL; /* This GPIO _is_ optional */

Do you agree that this is wrong? Yes, it behaves right for most cases.
But there are cases where it behaves wrong and so it needs fixing.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
