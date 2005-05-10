From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] make 8250_pnp use pnp_manual_config_dev()
Date: Tue, 10 May 2005 13:51:28 +0100
Message-ID: <20050510135128.C3358@flint.arm.linux.org.uk>
References: <20050510121521.GB4676@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37903 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261630AbVEJMve (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 08:51:34 -0400
Content-Disposition: inline
In-Reply-To: <20050510121521.GB4676@cathedrallabs.org>; from aris@cathedrallabs.org on Tue, May 10, 2005 at 09:15:21AM -0300
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-serial@vger.kernel.org

On Tue, May 10, 2005 at 09:15:21AM -0300, Aristeu Sergio Rozanski Filho wrote:
> Hi,
> 	this patch makes 8250_pnp use pnp_manual_config_dev() so
> 	pnp_reserve_{io,irq} option will be valid for serial ports too.
> 	Please consider applying

Please copy this to Adam Belay.  There are some problems with PNP
serial ports because they can clash with with standard addresses
for x86 ports.

We don't particularly want to reconfigure the standard x86 ports
to some other addresses just because we've already detected them
and claimed their resources external to PNP.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
