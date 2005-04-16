From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Date: Sat, 16 Apr 2005 08:59:23 +0100
Message-ID: <20050416085923.A10826@flint.arm.linux.org.uk>
References: <20050415151053.GM5456@stusta.de> <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru> <20050416023852.GI4831@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41744 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261280AbVDPH7a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 16 Apr 2005 03:59:30 -0400
Content-Disposition: inline
In-Reply-To: <20050416023852.GI4831@stusta.de>; from bunk@stusta.de on Sat, Apr 16, 2005 at 04:38:52AM +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, acpi-devel@lists.sourceforge.ne

On Sat, Apr 16, 2005 at 04:38:52AM +0200, Adrian Bunk wrote:
> In the Linux kernel, it's more common to put such header dependencies 
> for header files into the C files, but if the ACPI people agree a patch 
> to add the #include <linux/config.h> to acpi_bus.h is the other possble 
> correct solution for this issue.

With the exception of linux/config.h.

Do a 'make configcheck' and it'll tell you where linux/config.h is missing
and where it shouldn't be.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
