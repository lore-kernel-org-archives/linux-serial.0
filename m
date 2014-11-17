From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 15:45:00 +0100
Message-ID: <546A09EC.8080809@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl> <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl> <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl> <CACQ1gAjpXnnUPOj3paMGeB=NeQWR_7p6k8WPdxS9YzLakphBhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACQ1gAjpXnnUPOj3paMGeB=NeQWR_7p6k8WPdxS9YzLakphBhw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


W dniu 2014-11-17 o 10:26, Richard Genoud pisze:
> 2014-11-17 0:59 GMT+01:00 Janusz U=C5=BCycki <j.uzycki@elproma.com.pl=
>:
>> W dniu 2014-11-16 o 22:42, Uwe Kleine-K=C3=B6nig pisze:
>>
>> Thanks Uwe. I fully agree with you.
>> a) was just a starter to your suggestion. My options were too conser=
vative -
>> I just
>> wanted to avoid tests on hardware I don't have.
>> I don't understand why gpiod_get_direction() always requires the cal=
lback
>> and b) would be broken (I'm not so familiar with gpiolib) but I don'=
t need
>> it now.
>>
>> So, it looks we can drop the gpio-mxs patch, yes?
>> And, I or Richard should submit a patch for
>> mctrl_gpio/atmel_serial/mxs-auart
>> to introduce the irq helper, yes?
> You're welcome to do it !
> At the time the mctrl_helpers were introduced, there was only one use=
r
> (atmel_serial), so the line between specific code and factorizable
> code was not so clear.
> But clearly, the more we factorize, the better !
>
>> You wrote passing uart_port is enough. Argument "name" for request_i=
rq() can
>> be
>> recovered from dev_name(dev) or dev_driver_string(dev)  where dev =3D
>> port_uart->dev.
> And, honestly, I'm not sure dev_name(dev) is a good name.
> Having something like dev_name(dev)_port_id_CTS may be better.
>

=46or names other than device's or driver's name I would need to alloca=
te
string. Is it so important? You can simple check the interrupt and=20
corresponding port:
cat /proc/interrupts
  50:          0  gpio-mxs  21  80072000.serial
  80:          0  gpio-mxs  18  8006c000.serial
  81:          0  gpio-mxs  19  8006c000.serial
  83:          0  gpio-mxs  21  8006c000.serial
  84:          0  gpio-mxs  22  8006c000.serial

best regards
Janusz

> Seems ok !
>
> Richard.

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
