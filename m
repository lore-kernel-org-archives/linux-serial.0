From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Sat, 15 Nov 2014 00:26:01 +0100
Message-ID: <20141114232601.GW27002@pengutronix.de>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, Nov 14, 2014 at 11:27:06PM +0100, Janusz Uzycki wrote:
> Function gpiod_get_direction() of gpiolib calls get_direction()
> callback. If chip doesn't implement it EINVAL error is returned.
> The function doesn't use for returned value shadowed FLAG_IS_OUT
> bit of gpio_desc.flags field so the callback is required.
This sounds like a bugfix but "required" is wrong as AFAIR this call is
optional and hardly used. Or did that change? The only drawback is that
the debug output for (by Linux) uninitialized gpios is wrong.

Also the grammar of you sentence isn't German enough to sound correct.

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
