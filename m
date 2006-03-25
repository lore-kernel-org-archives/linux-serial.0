From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] serial8250: set divisor register correctly for AMD Alchemy SoC uart
Date: Sat, 25 Mar 2006 17:50:43 +0000
Message-ID: <20060325175042.GH6100@flint.arm.linux.org.uk>
References: <20060303140428.T96056@invalid.ed.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46603 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751496AbWCYRuv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Mar 2006 12:50:51 -0500
Content-Disposition: inline
In-Reply-To: <20060303140428.T96056@invalid.ed.ntnu.no>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jon Anders Haugum <jonah@omegav.ntnu.no>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Fri, Mar 03, 2006 at 02:56:38PM +0100, Jon Anders Haugum wrote:
> Alchemy SoC uart have got a non-standard divisor register that needs some 
> special handling.
> 
> This patch adds divisor read/write functions with test and special 
> handling for Alchemy internal uart.

This doesn't apply to mainline anymore.

patching file drivers/serial/8250.c
Hunk #1 succeeded at 362 with fuzz 2.
Hunk #2 FAILED at 528.
Hunk #3 FAILED at 540.
Hunk #4 FAILED at 552.
Hunk #5 FAILED at 565.
Hunk #6 FAILED at 780.
Hunk #7 FAILED at 788.
Hunk #8 succeeded at 1890 with fuzz 2.
6 out of 8 hunks FAILED -- saving rejects to file drivers/serial/8250.c.rej

Please resend.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
