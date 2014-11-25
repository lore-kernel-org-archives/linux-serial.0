From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 2/4] gpiolib: use const parameters when possible
Date: Tue, 25 Nov 2014 16:37:57 +0900
Message-ID: <CAAVeFuJ8=PdV8oiazVVcyrO3Kx4mV6GphxHCGEGX9ooMuoBWtA@mail.gmail.com>
References: <1360738983-22436-1-git-send-email-gnurou@gmail.com>
 <1360738983-22436-3-git-send-email-gnurou@gmail.com> <20141117090915.GE27002@pengutronix.de>
 <CAAVeFuKzP0ADix8TxC31ohb3ZmnEVmNcO5kgzhZ3DcwAhTq=-Q@mail.gmail.com>
 <20141119084432.GT27002@pengutronix.de> <CAAVeFuLtQoxt_D_TaRQc49Sh0FZTg=q4y5QorZ7OUK+qPE0CbQ@mail.gmail.com>
 <20141119090222.GU27002@pengutronix.de> <CAAVeFu+zc6tiM-SvwQ3mQmkMNdY+1+Ysi0F2eThyCjziKVwpOQ@mail.gmail.com>
 <20141119100954.GV27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141119100954.GV27002@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 19, 2014 at 7:09 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Alexandre,
>
> On Wed, Nov 19, 2014 at 06:07:50PM +0900, Alexandre Courbot wrote:
>>  On Wed, Nov 19, 2014 at 6:02 PM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > I'd make gpiod_get_direction static and only use it to fill in
>> > /sys/kernel/debug/gpio.
>>
>> That's very tempting. I see only atmel_serial.c using this function,
>> and there is no gpio_get_direction() declared anywhere so no user of
>> this either. I'm not sure what I was thinking when I decided to expo=
rt
>> it?
> In next there is also drivers/tty/serial/mxs-auart.c.

Ok. I think we can get rid of gpiod_get_direction() if
serial_mctrl_gpio implements its own way to query the direction (maybe
using a bitmap in the mctrl_gpios and a mctrl_gpio_get_direction()
function that queries that map). Using gpiod_get_direction() is just
too unreliable.

Janusz, since your change for mxs-auart is in -next, would you mind
amending it to do this? Then we could do the same for atmel_serial and
remove gpiod_get_direction() from the public GPIO interface. This
function would do more harm than good anyway.

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
