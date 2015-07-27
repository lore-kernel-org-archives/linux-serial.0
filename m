From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Mon, 27 Jul 2015 16:08:10 +0200
Message-ID: <CACRpkdZAcX2h0hUCDrxk-hxMTmyxusA5snJVvHyY-Bmsh3wPQw@mail.gmail.com>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
	<20150723222349.GB9973@kroah.com>
	<CACRpkdZce3Jfh3Mz0mW=XS72UUD5RP5okocLs_--N1B2aLNJDA@mail.gmail.com>
	<55B63241.7080409@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B63241.7080409@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Cassel <niklass@axis.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-cris-kernel <linux-cris-kernel@axis.com>, Jesper Nilsson <jespern@axis.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 27, 2015 at 3:29 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> On 07/27/2015 03:16 PM, Linus Walleij wrote:

>> Niklas: send me your patch when finished.
>
> I've already sent them to the linux-serial and linux-kernel mailing lists.
>
> I'm sorry that I didn't think of CC:ing you Linus.
> It might be better if you take them, since you got
> the devm_gpiod_get_optional patches in your tree.
>
> http://marc.info/?l=linux-serial&m=143778406314867
> http://marc.info/?l=linux-serial&m=143778407714871

This should work also with the current kernel, so better if Greg
take them I guess. I'll go in and ACK it.

Yours,
Linus Walleij
