From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] gpio: mxs: implement get_direction callback
Date: Mon, 17 Nov 2014 17:14:21 +0100
Message-ID: <CACQ1gAisamCxV8o-gCp58C5AY0OufZX-vSmssxcvRf4uYdHBUg@mail.gmail.com>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl> <20141117082848.GZ27002@pengutronix.de>
 <5469BBBD.30003@elproma.com.pl> <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de> <CACQ1gAje6OA_n37jE_WnSqg4R+U5tr-bGnnfxpGM5NE9c=dAVg@mail.gmail.com>
 <546A064A.5060304@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <546A064A.5060304@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, fabio.estevam@freescale.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2014-11-17 15:29 GMT+01:00 Janusz U=C5=BCycki <j.uzycki@elproma.com.pl>=
:
> Hi Richard,
>
> W dniu 2014-11-17 o 11:05, Richard Genoud pisze:
>>
>> 2014-11-17 10:59 GMT+01:00 Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de>:
>>
>> well, in this case, request_irq() will fail and all the previously
>> requested irqs will be freed:
>>      /*
>>       * If something went wrong, rollback.
>>       */
>>      while (err && (--i >=3D 0))
>>          if (irq[i] >=3D 0)
>>              free_irq(irq[i], port);
>
>
> I hesitate if use the rollback or just call mctrl_gpio_free_irqs().
> Let's note that "i" is enum and the loop ends on i < 0.

That's right, it's a bug.
I thought that enum was signed, but actually, it could be unsigned on
some platforms.
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
