From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/5] PNP: convert x86 legacy serial to platform devs, add SMC IR PNP probe
Date: Wed, 04 Apr 2007 16:45:36 -0600
Message-ID: <20070404224536.337573000@ldl.fc.hp.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:47102 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443AbXDDWqX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Apr 2007 18:46:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Keith Owens <kaos@ocs.com.au>, Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, Matthieu CASTET <castet.matthieu@free.fr>, Jean Tourrilhes <jt@hpl.hp.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ville Syrjala <syrjala@sci.fi>, Russell King <rmk+serial@arm.linux.org.uk>, linux-serial@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org

This series converts i386 and x86_64 legacy serial ports to be platform
devices and prevents probing for them if we have PNP.

This prevents double discovery, where a device was found both by the
legacy probe and by 8250_pnp.

This also prevents the serial driver from claiming IRDA devices (unless
they have a UART PNP ID).  The serial legacy probe sometimes assumed the
wrong IRQ, so the user had to use "setserial" to fix it.

Removing the need for setserial to make IRDA devices work seems good,
but it does break some things.  In particular, you may need to keep
setserial from poking legacy UART stuff back in by doing something like
"dpkg-reconfigure setserial" with the "kernel" option.  Otherwise, the
setserial-discovered "UART" will claim resources and prevent the IRDA
driver from loading.

--
