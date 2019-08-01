From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Date: Thu, 1 Aug 2019 11:55:29 +0200
Message-ID: <20190801095529.dm3pvgts6cy6mbiq@pengutronix.de>
References: <20190801081524.22577-1-frieder.schrempf@kontron.de>
 <20190801084827.m42ci3amo37hmesi@pengutronix.de>
 <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0674d68b-99fa-3408-1dd1-22dc84144b43@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 01, 2019 at 09:28:33AM +0000, Schrempf Frieder wrote:
> Hi Uwe,
> 
> On 01.08.19 10:48, Uwe Kleine-König wrote:
> > On Thu, Aug 01, 2019 at 08:18:05AM +0000, Schrempf Frieder wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() will return
> >> -ENOSYS and cause the probing of the imx UART to fail. As the
> >> GPIOs are optional, we should continue probing in this case.
> > 
> > Is this really still the case? On which version did you hit this
> > problem?
> 
> Yes, I think it is. I used v5.2.5, that already has d99482673f95.
> 
> > 
> > I would expect that is gone with
> > d99482673f950817b30caf3fcdfb31179b050ce1 if not earlier.
> 
> I think this is a different problem. If CONFIG_GPIOLIB is disabled, 
> mctrl_gpio_init() returns -ENOSYS unconditionally here: [1]. The 
> existing patch (d99482673f95) seems to handle the case when 
> CONFIG_GPIOLIB is enabled, but no or not all GPIOs are given in the dtb.

Ah, I see.

I don't think we should handle this on a per-driver basis. So my
suggestion is to drop the dummy implementation for mctrl_gpio if GPIOLIB
is disabled. Then the behaviour should be consistant with the gpio stuff
returning NULL in this case. (Or alternatively adapt the dummy
implementation to shortcut and behave identically.)

(Having said that I don't like gpiolib's behaviour of returning NULL for
the optional calls if it's disabled, but having mctrl_gpio behave
differently is worse.)

> The sh-sci.c driver has a similar check to skip this case: [2].

This should than be dropped, too.

Best regards
Uwe

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/serial_mctrl_gpio.h#n121
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/sh-sci.c#n3290

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
