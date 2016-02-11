From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Date: Thu, 11 Feb 2016 07:13:22 -0800
Message-ID: <20160211151322.GA30389@roeck-us.net>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel>
 <56BAA27A.9050605@roeck-us.net>
 <20160211104650.GU10826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160211104650.GU10826@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Baruch Siach <baruch@tkos.co.il>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, kernel-testers@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 11, 2016 at 10:46:50AM +0000, Russell King - ARM Linux wrot=
e:
> On Tue, Feb 09, 2016 at 06:37:46PM -0800, Guenter Roeck wrote:
> > On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
> > >On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
> > >>IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> > >>It can not be used to check if an unsigned int reflects an error.
> > >>Doing so can result in the following build warning.
> > >>
> > >>drivers/tty/serial/digicolor-usart.c: In function =E2=80=98digico=
lor_uart_probe=E2=80=99:
> > >>include/linux/err.h:21:38: warning:
> > >>         comparison is always false due to limited range of data =
type
> > >>drivers/tty/serial/digicolor-usart.c:485:6: note:
> > >>         in expansion of macro =E2=80=98IS_ERR_VALUE=E2=80=99
> > >>
> > >>If that warning is seen, an error return from platform_get_irq() =
is missed.
> > >>
> > >>
> > >
> > >The patch looks correct to me, but what compiler version and which=
 kernel
> > >tree is it that triggered the warning?
> > >
> > >Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and =
the
> > >changes are still under discussion, but I don't see that warning w=
ith
> > >any of the versions.
> > >
> > I see it with gcc 5.1 and 5.2 (and W=3D1). I did not see / notice A=
ndrzej's patch.
> >=20
> > I agree that fixing the problem in IS_ERR_VALUE() is preferrable.
>=20
> I disagree.  What happens if (eg) you decide to do this:
>=20
> 	u8 irq;
>=20
> 	irq =3D platform_get_irq(...);
> 	if (IS_ERR_VALUE(irq))
> 		...
>=20
> is that the fault of IS_ERR_VALUE() that it will never be true?  No, =
it's
> a programming error in the caller, because the caller is using the wr=
ong
> type here - in fact, you can't do anything in IS_ERR_VALUE() to corre=
ct
> that.
>=20
Yes, I think we all reached that conclusion by now.

Thanks,
Guenter
