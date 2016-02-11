From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Thu, 11 Feb 2016 10:46:50 +0000
Message-ID: <20160211104650.GU10826@n2100.arm.linux.org.uk>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel>
 <56BAA27A.9050605@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56BAA27A.9050605-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 09, 2016 at 06:37:46PM -0800, Guenter Roeck wrote:
> On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
> >On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
> >>IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> >>It can not be used to check if an unsigned int reflects an error.
> >>Doing so can result in the following build warning.
> >>
> >>drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digicolo=
r_uart_probe=E2=80=99:
> >>include/linux/err.h:21:38: warning:
> >>         comparison is always false due to limited range of data ty=
pe
> >>drivers/tty/serial/digicolor-usart.c:485:6: note:
> >>         in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
> >>
> >>If that warning is seen, an error return from platform_get_irq() is=
 missed.
> >>
> >>
> >
> >The patch looks correct to me, but what compiler version and which k=
ernel
> >tree is it that triggered the warning?
> >
> >Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and th=
e
> >changes are still under discussion, but I don't see that warning wit=
h
> >any of the versions.
> >
> I see it with gcc 5.1 and 5.2 (and W=3D1). I did not see / notice And=
rzej's patch.
>=20
> I agree that fixing the problem in IS_ERR_VALUE() is preferrable.

I disagree.  What happens if (eg) you decide to do this:

	u8 irq;

	irq =3D platform_get_irq(...);
	if (IS_ERR_VALUE(irq))
		...

is that the fault of IS_ERR_VALUE() that it will never be true?  No, it=
's
a programming error in the caller, because the caller is using the wron=
g
type here - in fact, you can't do anything in IS_ERR_VALUE() to correct
that.

The same is true if you assign an error value to an unsigned int: the
problem is in the caller, not in IS_ERR_VALUE().

What would be preferable is if there was some way IS_ERR_VALUE() could
detect if it's used on something that isn't at least a short, and is
signed, but I suspect coccinelle can do that much better than trying to
work out some way to get the C compiler to check that.

--=20
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
