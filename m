From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Mon, 27 Jul 2015 15:59:15 +0200
Message-ID: <20150727135915.GL15360@pengutronix.de>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
 <20150723222349.GB9973@kroah.com>
 <CACRpkdZce3Jfh3Mz0mW=XS72UUD5RP5okocLs_--N1B2aLNJDA@mail.gmail.com>
 <55B63241.7080409@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B63241.7080409@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Cassel <niklass@axis.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-cris-kernel <linux-cris-kernel@axis.com>, Jesper Nilsson <jespern@axis.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 27, 2015 at 03:29:37PM +0200, Niklas Cassel wrote:
> On 07/27/2015 03:16 PM, Linus Walleij wrote:
> > On Fri, Jul 24, 2015 at 12:23 AM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
> >>> Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get fu=
nctions")
> >>> makes the flags argument to devm_gpiod_get_optional mandatory but=
 does not
> >>> update all users. This results in the following build error.
> >>>
> >>> drivers/tty/serial/etraxfs-uart.c:933:16: error:
> >>>       too few arguments to function =E2=80=98devm_gpiod_get_optio=
nal=E2=80=99
> >>>
> >>> Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get fu=
nctions")
> >>
> >> This patch isn't in Linus's tree, so whatever tree this commit is =
in,
> >> needs to also take this fix.
> >=20
> > OK I'll take it. It's a bit messy with this breakage but it is for
> > a good cause.
> >=20
> > Niklas: send me your patch when finished.
>=20
> I've already sent them to the linux-serial and linux-kernel mailing l=
ists.
>=20
> I'm sorry that I didn't think of CC:ing you Linus.
> It might be better if you take them, since you got
> the devm_gpiod_get_optional patches in your tree.
If you use devm_gpiod_get_optional with the additional flags parameter
it should already now work for you. So if your change goes in before th=
e
gpio change (which only makes the flags parameter mandatory) everything
is fine. Not sure this makes it easier though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
