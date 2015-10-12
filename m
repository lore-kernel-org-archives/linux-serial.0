From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: fix mctrl helper functions
Date: Mon, 12 Oct 2015 17:15:42 +0200
Message-ID: <20151012151542.GY3982@pengutronix.de>
References: <5611419.Budt39N01Y@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5611419.Budt39N01Y@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

Hello Arnd,

On Mon, Oct 12, 2015 at 05:04:14PM +0200, Arnd Bergmann wrote:
> A recent patch to create common helper functions for modem control
> lines created empty helper functions in a header file, but accidental=
ly
> did not mark them as 'static inline', which causes build errors:
>=20
> drivers/tty/serial/mxs-auart.o: In function `mctrl_gpio_enable_ms':
> mxs-auart.c:(.text+0x171c): multiple definition of `mctrl_gpio_enable=
_ms'
> drivers/tty/serial/clps711x.o:clps711x.c:(.text+0x768): first defined=
 here
> drivers/tty/serial/mxs-auart.o: In function `mctrl_gpio_disable_ms':
> mxs-auart.c:(.text+0x1720): multiple definition of `mctrl_gpio_disabl=
e_ms'
> drivers/tty/serial/clps711x.o:clps711x.c:(.text+0x76c): first defined=
 here
>=20
> This adds the missing annotation, so the functions do not get placed
> in each object file.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ce59e48fdbad ("serial: mctrl_gpio: implement interrupt handlin=
g")
Sounds and looks right. Thanks.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
