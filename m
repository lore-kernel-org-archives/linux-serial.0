From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Kconfig option for compile time build coverage (Was: Re: [PATCH] serial/efm32: add new driver)
Date: Wed, 25 Jan 2012 16:16:26 +0000
Message-ID: <201201251616.27019.arnd@arndb.de>
References: <20111221202847.4ffeba10@bob.linux.org.uk> <20111223204428.GI24496@pengutronix.de> <20120109095903.GC14252@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55074 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab2AYQQc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jan 2012 11:16:32 -0500
In-Reply-To: <20120109095903.GC14252@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, kernel@pengutronix.de, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 09 January 2012, Uwe Kleine-K=F6nig wrote:
> On Fri, Dec 23, 2011 at 09:44:28PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 23, 2011 at 10:35:22AM +0000, Arnd Bergmann wrote:
> > > On Thursday 22 December 2011, Uwe Kleine-K=F6nig wrote:
> > > > [...]
> > > > +config SERIAL_EFM32_USART
> > > > + bool "EFM32 USART port."
> > > > + depends on ARCH_EFM32
> > > > + select SERIAL_CORE
> > [...]
> > > I would generally prefer not to make the driver depend on the
> > > platform, so we can get better compile time coverage. I think a b=
etter
> > > set of dependencies would be
> > >=20
> > >     depends on HAVE_CLK
> > >     depends on OF
> > >     default ARCH_EFM32
> > I'd prefer something like:
> >=20
> >       depends on HAVE_CLK
> >       depends on ARCH_EFM32 || I_DO_BUILD_COVERAGE_TESTING
> >=20
> > This would make it easier for Joe User to pick the right options fo=
r his
> > kernel (assuming he found out to better keep I_DO_BUILD_COVERAGE_TE=
STING
> > disabled). [...]
>
> What do you think about this I_DO_BUILD_COVERAGE_TESTING option? It
> would allow testers to get all possible options enabled (though there
> will never be an EFM32 USART port on a non-EFM32 machine I guess) and
> still users and distribution packagers would easily keep the option o=
ff
> even without cluttering .config and {menu,n,x,whatever}config.

Sorry for the late reply. The same topic has been discussed a lot of
times. We have different ways to handle this in the kernel, but the
way most common way is to use defconfig to decide which drivers to
use on a given machine but give the user the freedom to both enable
and disable any driver whereever possible, even if that would be
a silly thing to do. What we do require normally is that anything
that can be enabled is also able to be built without errors. A lot
of drivers have dependencies on platform specific header files
or other interfaces, so they require that platform to be enabled.

=46or all others I would not make such a restriction and I would always
recommend to be specific in the dependencies, e.g depending on HAVE_CLK
when you use the clock interfaces, instead of depending on other option=
s
that implicitly enable HAVE_CLK.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
