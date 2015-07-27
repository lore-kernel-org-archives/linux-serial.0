From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Mon, 27 Jul 2015 15:16:38 +0200
Message-ID: <CACRpkdZce3Jfh3Mz0mW=XS72UUD5RP5okocLs_--N1B2aLNJDA@mail.gmail.com>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
	<20150723222349.GB9973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150723222349.GB9973@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Cassel <niklas.cassel@axis.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 24, 2015 at 12:23 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
>> Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get funct=
ions")
>> makes the flags argument to devm_gpiod_get_optional mandatory but do=
es not
>> update all users. This results in the following build error.
>>
>> drivers/tty/serial/etraxfs-uart.c:933:16: error:
>>       too few arguments to function =E2=80=98devm_gpiod_get_optional=
=E2=80=99
>>
>> Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get funct=
ions")
>
> This patch isn't in Linus's tree, so whatever tree this commit is in,
> needs to also take this fix.

OK I'll take it. It's a bit messy with this breakage but it is for
a good cause.

Niklas: send me your patch when finished.

Yours,
Linus Walleij
