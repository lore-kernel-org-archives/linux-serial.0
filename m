From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Tue, 21 Jul 2015 23:01:15 +0200
Message-ID: <20150721210115.GJ9981@pengutronix.de>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437510892-30376-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 21, 2015 at 01:34:52PM -0700, Guenter Roeck wrote:
> Commit b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get functi=
ons")
> makes the flags argument to devm_gpiod_get_optional mandatory but doe=
s not
> update all users. This results in the following build error.
>=20
> drivers/tty/serial/etraxfs-uart.c:933:16: error:
> 	too few arguments to function =E2=80=98devm_gpiod_get_optional=E2=80=
=99
>=20
> Fixes: b17d1bf16cc7 ("gpio: make flags mandatory for gpiod_get functi=
ons")
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
We discussed this driver while I worked on updating the gpiod API. I
don't care much about this driver, but if you want to do something abou=
t
the build failure, I'd prefer:

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 76e65b714471..3a6a7c235f09 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1066,6 +1066,7 @@ config SERIAL_VT8500_CONSOLE
 config SERIAL_ETRAXFS
 	bool "ETRAX FS serial port support"
 	depends on ETRAX_ARCH_V32 && OF
+	depends on BROKEN
 	select SERIAL_CORE
=20
 config SERIAL_ETRAXFS_CONSOLE

Best regards
Uwe
--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
