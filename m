From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] add ignore_ports option
Date: Tue, 10 May 2005 13:50:00 +0100
Message-ID: <20050510135000.B3358@flint.arm.linux.org.uk>
References: <20050510121151.GA4676@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37391 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261629AbVEJMuF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 May 2005 08:50:05 -0400
Content-Disposition: inline
In-Reply-To: <20050510121151.GA4676@cathedrallabs.org>; from aris@cathedrallabs.org on Tue, May 10, 2005 at 09:11:51AM -0300
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-serial@vger.kernel.org

On Tue, May 10, 2005 at 09:11:51AM -0300, Aristeu Sergio Rozanski Filho wrote:
> Hi,
> 	this patch adds an option to 8250 driver to avoid probing for a
> 	serial port in specified addresses.
> 	Please consider applying

You don't say why this is desireable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
