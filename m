From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/3] s/FOOTBRIDGE/ARCH_FOOTBRIDGE/
Date: Wed, 2 Jul 2014 09:13:12 +0200
Message-ID: <20140702071312.GO14781@pengutronix.de>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140701221428.GC32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54828 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaGBHN3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jul 2014 03:13:29 -0400
Content-Disposition: inline
In-Reply-To: <20140701221428.GC32514@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Hello Russell,

On Tue, Jul 01, 2014 at 11:14:28PM +0100, Russell King - ARM Linux wrot=
e:
> On Tue, Jul 01, 2014 at 10:37:03PM +0200, Uwe Kleine-K=F6nig wrote:
> > I'm not sure that FOOTBRIDGE and ARCH_FOOTBRIDGE are semantically
> > identical; if not, feel free to nack this series.
>=20
> CONFIG_FOOTBRIDGE means that we have a DC21285 in the system.  We
> used to have ARCH_FOOTBRIDGE and ARCH_CO285 which both selected
> CONFIG_FOOTBRIDGE.
>=20
> ARCH_FOOTBRIDGE was for either host or addin mode using a PAGE_OFFSET
> of 0xc0000000.  ARCH_CO285 had a PAGE_OFFSET of 0x80000000 as they
> wanted to be able to map almost all of PCI memory space.
>=20
> So think of CONFIG_FOOTBRIDGE as meaning that we have the physical
> device, and CONFIG_ARCH_FOOTBRIDGE meaning that we want to support
> boards with the device on.
I expected something like that. Is it possible to "have" the device on =
a
cpu !=3D StrongARM? If so I wonder why ARCH_FOOTBRIDGE is a "ARM system
type". And if not, wouldn't it be possible and better to have all
platforms which select CPU_SA110 (ARCH_EBSA110, ARCH_FOOTBRIDGE; what
about RPC?) in a single mach dir and make FOOTBRIDGE an option there?

It's hard to find information on the net about these chips, even
http://developer.intel.com/design/strong/sa110.htm only talks about x86
stuff only, so please excuse my unknowingness.
=20
> So, it may make sense to rename CONFIG_FOOTBRIDGE to CONFIG_DC21285
> if that makes the configuration symbol intention clearer.
Maybe even better CONFIG_HAS_DC21285?

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
