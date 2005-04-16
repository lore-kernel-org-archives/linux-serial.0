From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Date: Sat, 16 Apr 2005 04:38:52 +0200
Message-ID: <20050416023852.GI4831@stusta.de>
References: <20050415151053.GM5456@stusta.de> <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46092 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262582AbVDPCix (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Apr 2005 22:38:53 -0400
Content-Disposition: inline
In-Reply-To: <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, acpi-devel@lists.sourceforge.ne

On Fri, Apr 15, 2005 at 08:10:54PM +0400, Alexey Dobriyan wrote:
> On Fri, 15 Apr 2005 17:10:53 +0200, Adrian Bunk wrote:
> 
> > This patch fixes the following warning:
> 
> >   CC      drivers/serial/8250_acpi.o
> > drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> > drivers/serial/8250_acpi.c:51: warning: implicit declaration of function `acpi_register_gsi'
> 
> > --- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old
> > +++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c
> 
> > +#include <linux/config.h>
> 
> drivers/serial/8250_acpi.c doesn't use CONFIG_ symbols.

8250_acpi.c #include's <acpi/acpi_bus.h> which requires config.h .

In the Linux kernel, it's more common to put such header dependencies 
for header files into the C files, but if the ACPI people agree a patch 
to add the #include <linux/config.h> to acpi_bus.h is the other possble 
correct solution for this issue.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

