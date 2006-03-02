From: Jon Anders Haugum <jonah@omegav.ntnu.no>
Subject: Re: [PATCH] Fix compile error in 8250_au1x00.c
Date: Thu, 2 Mar 2006 13:00:27 +0100 (CET)
Message-ID: <20060302124634.T81066@invalid.ed.ntnu.no>
References: <20060207211500.GC5227@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fri.itea.ntnu.no ([129.241.7.60]:57281 "EHLO fri.itea.ntnu.no")
	by vger.kernel.org with ESMTP id S1750923AbWCBMAb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Mar 2006 07:00:31 -0500
In-Reply-To: <20060207211500.GC5227@cosmic.amd.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Tue, 7 Feb 2006, Jordan Crouse wrote:

> There are additional rumors of strangeness on the DB1550, but those
> are unsubstantiated at this point.  At least with this patch, it will
> compile.

I can confirm strangeness on Au1550, and I've pinned it down to wrong 
way of setting the divisor register. The alchemy uart have got a spearate 
register for divisor, while the driver tries to set the divisor latch 
just like on any 16550 uart.

How would be a good way of solving this? I can imagine a couple of ways:

1. Make divisor latch read/write a bit more abstract, so that a 
alternative function can be used for alchemy.

2. Add divisor latch to the alchemy uart register map. But since the 
divisor register is located in a single 32-bit register and the driver 
will try to access it one byte at a time; byte access would be needed. And 
this would add some endian handling...


-- 
Jon Anders Haugum

