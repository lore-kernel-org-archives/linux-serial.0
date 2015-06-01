From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH][RFC] gpiolib: rename gpiod_set_array to gpiod_set_array_value
Date: Mon, 1 Jun 2015 14:55:34 +0200
Message-ID: <CACRpkdYtLDO5SHENE3RX6vYXUAAB6=b4gfwtuGBJ-xRYDM2R4g@mail.gmail.com>
References: <5305088.q3JD5pGOgN@pcimr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5305088.q3JD5pGOgN@pcimr>
Sender: linux-gpio-owner@vger.kernel.org
To: Rojhalat Ibrahim <imr@rtschenk.de>, linux-netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, May 13, 2015 at 11:04 AM, Rojhalat Ibrahim <imr@rtschenk.de> wrote:

> There have been concerns that the function names gpiod_set_array() and
> gpiod_get_array() might be confusing to users. One might expect
> gpiod_get_array() to return array values, while it is actually the array
> counterpart of gpiod_get(). To be consistent with the single descriptor API
> we could rename gpiod_set_array() to gpiod_set_array_value(). This makes
> some function names a bit lengthy: gpiod_set_raw_array_value_cansleep().
>
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>

OK patch applied...

>  drivers/gpio/gpiolib.c                 |   54 +++++++++++++++++----------------
>  drivers/net/phy/mdio-mux-gpio.c        |    3 +

You should ideally have David's ACK for this.

>  drivers/tty/serial/serial_mctrl_gpio.c |    2 -

And Greg's ACK for this.

I hope this doesn't wreak havoc or I will have to revert it.

Yours,
Linus Walleij
