From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v6] serial: rewrite pxa2xx-uart to use 8250_core
Date: Mon, 22 Feb 2016 04:56:31 +0300
Message-ID: <1456106191.2386.13.camel@gmail.com>
References: <1450897204-6839-1-git-send-email-ynvich@gmail.com>
	 <1450970122-12869-1-git-send-email-ynvich@gmail.com>
	 <20160207062206.GB16270@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160207062206.GB16270@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, James Cameron <quozl@laptop.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Scott Wood <scottwood@freescale.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Ralf Baechle <ralf@linux-mips.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, 2016-02-06 at 22:22 -0800, Greg Kroah-Hartman wrote:
> On Thu, Dec 24, 2015 at 06:15:14PM +0300, Sergei Ianovich wrote:
> > pxa2xx-uart was a separate uart platform driver. It was declaring
> > the same device names and numbers as 8250 driver. As a result,
> > it was impossible to use 8250 driver on PXA SoCs.
> >=20
> > Upon closer examination pxa2xx-uart turned out to be a clone of
> > 8250_core driver.
> >=20
> > Workaround for Erratum #19 according to Marvel(R) PXA270M Processor
> > Specification Update (April 19, 2010) is dropped. 8250_core reads
> > from FIFO immediately after checking DR bit in LSR.
> >=20
> > The patch leaves the original SERIAL_PXA driver around. The
> > original
> > driver is just marked DEPRECATED in Kconfig and C source. When
> > the original driver is considered safe to remove, no changes
> > to SERIAL_8250 will be necessary.
>=20
> But, you just broke existing configurations, right?=C2=A0=C2=A0The se=
rial port is
> a different name now, are you willing to handle the angry users?

No, the port name remains /dev/ttyS0. In fact, this conflict (both
drivers use the same name and char major) is the reason for the patch.
Noone should notice the change at runtime. There will be a warning at
compile time which should make the transition to the new driver faster.

> If so, great, get the platform maintainer to sign off on this please =
and
> then resend it.

The previous version of the patch has been around for 2 years with half
a dozen of Acks and Reviews, but it hasn't landed. Could you suggest a
better approach?

--=20
Sergei Ianovich <ynvich@gmail.com>
