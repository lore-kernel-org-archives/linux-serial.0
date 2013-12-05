From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Thu, 5 Dec 2013 21:28:25 +0100
Message-ID: <20131205202825.GB4707@pengutronix.de>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
 <5283A8C7.30904@atmel.com>
 <529C4936.5060304@atmel.com>
 <20131204102353.GI29721@pengutronix.de>
 <20131204170911.GC14859@kroah.com>
 <20131204191606.GL29721@pengutronix.de>
 <52A0B060.4040203@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52A0B060.4040203@atmel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, linux-serial@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, "arm@kernel.org" <arm@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello Nicolas,

On Thu, Dec 05, 2013 at 05:57:04PM +0100, Nicolas Ferre wrote:
> On 04/12/2013 20:16, Uwe Kleine-K=F6nig :
> >On Wed, Dec 04, 2013 at 09:09:11AM -0800, Greg Kroah-Hartman wrote:
> >>On Wed, Dec 04, 2013 at 11:23:53AM +0100, Uwe Kleine-K=F6nig wrote:
> >>>Hello Greg, hi Nicolas,
> >>>
> >>>On Mon, Dec 02, 2013 at 09:47:50AM +0100, Nicolas Ferre wrote:
> >>>>On 13/11/2013 17:28, Nicolas Ferre :
> >>>>>On 07/11/2013 10:25, Linus Walleij :
> >>>>>>This passes the errata fix using a GPIO to control the RTS pin
> >>>>>>on one of the AT91 chips to use gpiolib instead of the
> >>>>>>AT91-specific interfaces. Also remove the reliance on
> >>>>>>compile-time #defines and the cpu_* check and rely on the
> >>>>>>platform passing down the proper GPIO pin through platform
> >>>>>>data.
> >>>>>>
> >>>>>>This is a prerequisite for getting rid of the local GPIO
> >>>>>>implementation in the AT91 platform and move toward
> >>>>>>multiplatform.
> >>>>>>
> >>>>>>The patch also adds device tree support for getting the
> >>>>>>RTS GPIO pin from the device tree on DT boot paths.
> >>>>>>
> >>>>>>Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>>>>>Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.c=
om>
> >>>>>>Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> [...]
> >nferre: What is your plan with this patch? Do you have patches
> >depending on it, too, or is it ok if I take it?
>=20
> Well, the problem is that your branch generates conflicts with the
> at91/cleanup one that Olof have just pulled. They are not big
> conflicts, only additions of header files at the same location.
> Maybe you can rebase your branch on top of this cleanup branch
> (arm-soc/next/cleanup: 94c5216ee93b3b4).
Olof said on irc: "that's easy to fix, i'm ok with resolving that when =
i
merge". That is what I prefer because I don't want to retest everything
after rebasing.
>=20
> But, anyway I feel that it is better if you take the whole series in =
a raw.
So I can interpret this as your blessing to keep the patch in my series
based on 3.13-rc1?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
