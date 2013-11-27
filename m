From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty: atmel_serial: include <mach/hardware.h> explicitly
Date: Wed, 27 Nov 2013 17:42:15 +0100
Message-ID: <20131127164215.GS28642@pengutronix.de>
References: <1385545111-1256-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5295BFE3.5070700@atmel.com>
 <20131127100243.GQ28642@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47255 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab3K0QmX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 11:42:23 -0500
Content-Disposition: inline
In-Reply-To: <20131127100243.GQ28642@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel@pengutronix.de, Jiri Slaby <jslaby@suse.cz>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org

On Wed, Nov 27, 2013 at 11:02:43AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Nov 27, 2013 at 10:48:19AM +0100, Nicolas Ferre wrote:
> > On 27/11/2013 10:38, Uwe Kleine-K=F6nig :
> > >When compiled for at91rm9200 (i.e. ARM) the driver needs among oth=
ers
> > >the symbol AT91RM9200_BASE_US0 which is defined in
> > >arch/arm/mach-at91/include/mach/at91rm9200.h. This file is include=
d
> > >implicitly via several steps. As ARM's <asm/timex.h> will stop inc=
luding
> > ><mach/hardware.h> later in this series explicitly include
> > ><mach/hardware.h>
> > >
> > >Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Uwe, this AT91RM9200_BASE_US0 value is supposed to disappear in 3.1=
4
> > tanks to a patch from Linus W. ([PATCH v4] ARM/serial: at91: switch
> > atmel serial to use gpiolib) (not in linux-next yet).
> >=20
> > So I think that this patch is not needed for 3.14.
> So I'll keep this patch in my queue for now, but keep an eye on this
> one. The other symbols were dropped, too?
I just verified that Linus W.'s patch is good enough for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
