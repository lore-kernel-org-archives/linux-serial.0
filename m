From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Tue, 09 Feb 2016 16:26:38 +0100
Message-ID: <4571887.rTPndCnv20@wuerfel>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455030539-10798-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> It can not be used to check if an unsigned int reflects an error.
> Doing so can result in the following build warning.
>=20
> drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digicolor_=
uart_probe=E2=80=99:
> include/linux/err.h:21:38: warning:
>         comparison is always false due to limited range of data type
> drivers/tty/serial/digicolor-usart.c:485:6: note:
>         in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
>=20
> If that warning is seen, an error return from platform_get_irq() is m=
issed.
>=20
>=20

The patch looks correct to me, but what compiler version and which kern=
el
tree is it that triggered the warning?

Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and the
changes are still under discussion, but I don't see that warning with
any of the versions.

	Arnd
