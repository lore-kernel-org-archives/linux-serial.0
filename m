From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH][RESEND] serial_mctrl_gpio: use gpiod_set_array function
Date: Fri, 28 Nov 2014 14:52:06 +0100
Message-ID: <CACRpkdaZsOpxi7ZWS9DYnMeui5UgcQ57P65857SyS+wXJ=3XWA@mail.gmail.com>
References: <8534699.OPo8bzguux@pcimr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <8534699.OPo8bzguux@pcimr>
Sender: linux-gpio-owner@vger.kernel.org
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Greg Kroah-Hartman <greg@kroah.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Gerhard Sittig <gsi@denx.de>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 17, 2014 at 6:31 PM, Rojhalat Ibrahim <imr@rtschenk.de> wrote:

> Make the serial_mctrl_gpio driver the first user of the new gpiod_set_array
> function, which is now available in the linux-gpio devel tree.
> All modem control output signals are now set simultaneously.
>
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Patch applied with Greg's ACK.

Yours,
Linus Walleij
