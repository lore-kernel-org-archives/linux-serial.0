From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch] serial: compare mapbase and not membase in find_port
Date: Wed, 4 Jan 2006 18:12:26 +0000
Message-ID: <20060104181226.GD3119@flint.arm.linux.org.uk>
References: <221e0ff70601010712u6a0d395dq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46353 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030260AbWADSMd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2006 13:12:33 -0500
Content-Disposition: inline
In-Reply-To: <221e0ff70601010712u6a0d395dq@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gyorgy Jeney <nog.lkml@gmail.com>
Cc: linux-serial@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 04:12:31PM +0100, Gyorgy Jeney wrote:
> From: Gyorgy Jeney
> 
> If the 8250_early driver uses bt_ioremap, find_port() is unable to find the
> correct device since the address returned by ioremap is different to that
> returned by bt_ioremap for the same address.  Since no more than one device
> occupies the same physical address, compareing the physical addresses should
> be safe.

Really, this should be using uart_match_port().  Fixed to use that.

(And in combination with Ben's patch from November time, it works out
to do the right thing.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
