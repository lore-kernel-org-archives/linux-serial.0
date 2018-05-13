From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/3] tty: implement led triggers
Date: Sun, 13 May 2018 17:23:34 +0300
Message-ID: <CAHp75Vf0RmAU8Qvk13JkFJob95pBEv27o4k8FVKo+0vs-SxYRg@mail.gmail.com>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de> <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 8, 2018 at 1:05 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The rx trigger fires when data is pushed to the ldisc by the driver. This
> is a bit later than the actual receiving of data but has the nice benefit
> that it doesn't need adaption for each driver and isn't in the hot path.
>
> Similarly the tx trigger fires when data was copied from userspace and is
> given to the ldisc.

>  #include <uapi/linux/tty.h>
>  #include <linux/rwsem.h>
>  #include <linux/llist.h>
> +#include <linux/leds.h>

Even for unordered lists of inclusions I would still try to put new
lines in "somehow" ordered positions.
For example here, I would rather put it before llist.h.

--=20
With Best Regards,
Andy Shevchenko
