From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Wed, 22 Jul 2015 09:06:59 +0200
Message-ID: <20150722070659.GK9981@pengutronix.de>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
 <20150721210115.GJ9981@pengutronix.de>
 <55AEC50E.3030202@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55AEC50E.3030202@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello,

On Tue, Jul 21, 2015 at 03:17:50PM -0700, Guenter Roeck wrote:
> On 07/21/2015 02:01 PM, Uwe Kleine-K=C3=B6nig wrote:
> >On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
> >>Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get func=
tions")
> >>makes the flags argument to devm_gpiod_get_optional mandatory but d=
oes not
> >>update all users. This results in the following build error.
> >>
> >>drivers/tty/serial/etraxfs-uart.c:933:16: error:
> >>	too few arguments to function =E2=80=98devm_gpiod_get_optional=E2=80=
=99
> >>
> >>Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get func=
tions")
> >>Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >>Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >We discussed this driver while I worked on updating the gpiod API. I
> >don't care much about this driver, but if you want to do something a=
bout
> >the build failure, I'd prefer:
> >
> >diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> >index 76e65b714471..3a6a7c235f09 100644
> >--- a/drivers/tty/serial/Kconfig
> >+++ b/drivers/tty/serial/Kconfig
> >@@ -1066,6 +1066,7 @@ config SERIAL_VT8500_CONSOLE
> >  config SERIAL_ETRAXFS
> >  	bool "ETRAX FS serial port support"
> >  	depends on ETRAX_ARCH_V32 && OF
> >+	depends on BROKEN
> >  	select SERIAL_CORE
> >
> >  config SERIAL_ETRAXFS_CONSOLE
> >
> >Best regards
> >Uwe
> >
>=20
> Uwe,
>=20
> I understand the value of BROKEN, but I do not think it would be
> appropriate here. It would be appropriate for a driver which is reall=
y
> broken, not one that doesn't build anymore because an API it uses
> was updated and the driver code wasn't updated for some reason.
>=20
> With your suggested patch I would no longer be able to run my qemu te=
sts
> for this architecture, which I would not entirely be happy about.
>=20
> You may not care, but maybe others do.
>=20
> Makes me wonder: It used to be that API changes were handled by those
> making the API changes, not by those responsible for the code using
> the API. Has this changed recently, ie is it now acceptable to not
> update all callers of a modified API (on purpose, as it looks like
> it was done here) ?
While I stumbled over the calls to gpiod_get variants in the etraxfs
serial driver I noticed several problems with that driver. I pointed
them out in

	http://www.spinics.net/lists/linux-serial/msg17794.html

=2E If you read the follow-ups Jesper Nilsson then said:

	I can push a patch that just drops all signal handling (since
	it's bogus ATM), or you can ignore the driver as currently
	implemented.

I explicitly did the latter. Apart from that single driver I fixed all
users. @Jesper: You said you poked Niklas to care for that. Any news
from that front?

I'm all for the usual habit that API changes should be handled by the
API changer. But if the code was already relying on undefined behaviour
before the change and fixing that needs testing on the respective
hardware, I think pushing the needed work back to the driver owner is
fine. IMHO a simple build fix that doesn't fix the brokeness isn't that
helpful here.

Having said that I don't care for that driver. So if you say it's good
enough for you to simply add GPIOD_ASIS and the responsible maintainers
are ok, too, I won't stand in the way.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
