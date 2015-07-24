From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Fri, 24 Jul 2015 08:33:27 +0200
Message-ID: <20150724063327.GI745@pengutronix.de>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
 <20150723222349.GB9973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150723222349.GB9973@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 23, 2015 at 03:23:49PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
> > Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get func=
tions")
> > makes the flags argument to devm_gpiod_get_optional mandatory but d=
oes not
> > update all users. This results in the following build error.
> >=20
> > drivers/tty/serial/etraxfs-uart.c:933:16: error:
> > 	too few arguments to function =E2=80=98devm_gpiod_get_optional=E2=80=
=99
> >=20
> > Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get func=
tions")
>=20
> This patch isn't in Linus's tree, so whatever tree this commit is in,
> needs to also take this fix.
It is in Linus's tree. The Walleij one though, not Torvalds :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
