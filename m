From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v6] serial: rewrite pxa2xx-uart to use 8250_core
Date: Mon, 22 Feb 2016 08:17:33 +0100
Message-ID: <87si0lw6wi.fsf@belgarion.home>
References: <1450897204-6839-1-git-send-email-ynvich@gmail.com>
	<1450970122-12869-1-git-send-email-ynvich@gmail.com>
	<20160207062206.GB16270@kroah.com>
	<1456106191.2386.13.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456106191.2386.13.camel@gmail.com> (Sergei Ianovich's message
	of "Mon, 22 Feb 2016 04:56:31 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, James Cameron <quozl@laptop.org>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Scott Wood <scottwood@freescale.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Ralf Baechle <ralf@linux-mips.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Sergei Ianovich <ynvich@gmail.com> writes:

> On Sat, 2016-02-06 at 22:22 -0800, Greg Kroah-Hartman wrote:
>> On Thu, Dec 24, 2015 at 06:15:14PM +0300, Sergei Ianovich wrote:
>> > pxa2xx-uart was a separate uart platform driver. It was declaring
>> > the same device names and numbers as 8250 driver. As a result,
>> > it was impossible to use 8250 driver on PXA SoCs.
>> >=20
>> > Upon closer examination pxa2xx-uart turned out to be a clone of
>> > 8250_core driver.
>> >=20
>> > Workaround for Erratum #19 according to Marvel(R) PXA270M Processo=
r
>> > Specification Update (April 19, 2010) is dropped. 8250_core reads
>> > from FIFO immediately after checking DR bit in LSR.
>> >=20
>> > The patch leaves the original SERIAL_PXA driver around. The
>> > original
>> > driver is just marked DEPRECATED in Kconfig and C source. When
>> > the original driver is considered safe to remove, no changes
>> > to SERIAL_8250 will be necessary.
>>=20
>> But, you just broke existing configurations, right?=C2=A0=C2=A0The s=
erial port is
>> a different name now, are you willing to handle the angry users?
>
> No, the port name remains /dev/ttyS0. In fact, this conflict (both
> drivers use the same name and char major) is the reason for the patch=
=2E
> Noone should notice the change at runtime. There will be a warning at
> compile time which should make the transition to the new driver faste=
r.
>
>> If so, great, get the platform maintainer to sign off on this please=
 and
>> then resend it.

If you're talking about the PXA maintainer, then :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

I'm happy with the patch, all pxa board maintainers have been warned, a=
nd there
exists a fallback solution.

So let's go forward, and if people complain, let them complain and forw=
ard them
to me.

Cheers.

--=20
Robert
