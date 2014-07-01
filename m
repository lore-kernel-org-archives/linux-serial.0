From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] s/FOOTBRIDGE/ARCH_FOOTBRIDGE/
Date: Tue, 1 Jul 2014 23:14:28 +0100
Message-ID: <20140701221428.GC32514@n2100.arm.linux.org.uk>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50499 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752959AbaGAWOo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Jul 2014 18:14:44 -0400
Content-Disposition: inline
In-Reply-To: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Tue, Jul 01, 2014 at 10:37:03PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Russell,
>=20
> I'm not sure that FOOTBRIDGE and ARCH_FOOTBRIDGE are semantically
> identical; if not, feel free to nack this series.

CONFIG_FOOTBRIDGE means that we have a DC21285 in the system.  We
used to have ARCH_FOOTBRIDGE and ARCH_CO285 which both selected
CONFIG_FOOTBRIDGE.

ARCH_FOOTBRIDGE was for either host or addin mode using a PAGE_OFFSET
of 0xc0000000.  ARCH_CO285 had a PAGE_OFFSET of 0x80000000 as they
wanted to be able to map almost all of PCI memory space.

So think of CONFIG_FOOTBRIDGE as meaning that we have the physical
device, and CONFIG_ARCH_FOOTBRIDGE meaning that we want to support
boards with the device on.

So, it may make sense to rename CONFIG_FOOTBRIDGE to CONFIG_DC21285
if that makes the configuration symbol intention clearer.

This is why I prefer even hidden symbols to have a help text - having
the help text explains why they exist...

--=20
=46TTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... sl=
owly
improving, and getting towards what was expected from it.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
