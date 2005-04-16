From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Date: Sat, 16 Apr 2005 13:08:36 +1000
Message-ID: <E1DMdfg-00047d-00@gondolin.me.apana.org.au>
References: <20050416023852.GI4831@stusta.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arnor.apana.org.au ([203.14.152.115]:15372 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262607AbVDPDSu
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Apr 2005 23:18:50 -0400
In-Reply-To: <20050416023852.GI4831@stusta.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: adobriyan@mail.ru, akpm@osdl.org, bjorn.helgaas@hp.com, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, acpi-devel@lists.sourceforge.ne

Adrian Bunk <bunk@stusta.de> wrote:
>
>> drivers/serial/8250_acpi.c doesn't use CONFIG_ symbols.
> 
> 8250_acpi.c #include's <acpi/acpi_bus.h> which requires config.h .
> 
> In the Linux kernel, it's more common to put such header dependencies 
> for header files into the C files, but if the ACPI people agree a patch 

I disagree with this assertion.  Try

grep -l linux/config.h include/linux/*.h | wc -l

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
