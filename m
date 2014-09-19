From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 05/10] drivers: PL011: refactor pl011_probe()
Date: Fri, 19 Sep 2014 13:40:04 +0100
Message-ID: <20140919124004.GI5182@n2100.arm.linux.org.uk>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com> <1411129283-17219-6-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:34526 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750924AbaISMkd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:40:33 -0400
Content-Disposition: inline
In-Reply-To: <1411129283-17219-6-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

On Fri, Sep 19, 2014 at 01:21:18PM +0100, Andre Przywara wrote:
> Currently the pl011_probe() function is relying on some AMBA IDs
> and a device tree node to initialize the driver and a port.
> Both features are not necessarily required for the driver:
> - we lack AMBA IDs in the ARM SBSA generic UART and
> - we lack a DT node in ACPI systems.
> So lets refactor the function to ease later reuse.

Both features are not "necessary" for any driver, but that doesn't mean
we work around it by throwing a platform driver at it.  We already have
this same problem with PL010 UARTs, and the DT support for AMBA has the
ability to specify the AMBA ID.

Moreover, there is nothing which prevents you from declaring an AMBA
device with an appropriate AMBA ID for the driver to bind to - which is
presumably something very similar to what you're already doing with a
platform device.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
