From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] fix for 8250.c *wrongly* detecting XScale UART(s) on x86 PC
Date: Sun, 6 Mar 2005 10:19:12 +0000
Message-ID: <20050306101912.A19558@flint.arm.linux.org.uk>
References: <20050306093321.GA3040@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32787 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261352AbVCFKTR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 Mar 2005 05:19:17 -0500
Content-Disposition: inline
In-Reply-To: <20050306093321.GA3040@taniwha.stupidest.org>; from cw@f00f.org on Sun, Mar 06, 2005 at 01:33:21AM -0800
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, Mar 06, 2005 at 01:33:21AM -0800, Chris Wedgwood wrote:
> Breaks my UARTS.
> 
> I'm not thrilled with this patch but 8250.c has similar warts so I
> guess it's not too bad.  Ideally we could refactor this a bit so if
> this isn't acceptable let me know and I'll do that instead.

If it breaks here (due to your ports being "embraced and extended") it
could well break elsewhere, and wrapping it in CONFIG_ARM doesn't solve
that.

I'm not sure what the solution to this is, but unless we can autodetect
the port "type", it rather screws the current direction of 8250, which
has been to move away from port types to a set of port capabilities.

I wonder if its possible to get hold of any documentation for your
misdetected serial port...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
