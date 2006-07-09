From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] serial: Fix compilation error in dz.c
Date: Sun, 9 Jul 2006 20:59:49 +0100
Message-ID: <20060709195949.GC32457@flint.arm.linux.org.uk>
References: <20060626161811.GA14240@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64777 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161102AbWGIT7z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Jul 2006 15:59:55 -0400
Content-Disposition: inline
In-Reply-To: <20060626161811.GA14240@deprecation.cyrius.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-serial@vger.kernel.org

On Mon, Jun 26, 2006 at 06:18:11PM +0200, Martin Michlmayr wrote:
> Fix the following compilation error in the dz serial driver that got
> introduced with the "kernel console should send CRLF not LFCR" change.
> 
>   CC      drivers/serial/dz.o
> drivers/serial/dz.c: In function 'dz_console_putchar':
> drivers/serial/dz.c:679: error: 'uport' undeclared (first use in this function)
> drivers/serial/dz.c:679: error: (Each undeclared identifier is reported only once
> drivers/serial/dz.c:679: error: for each function it appears in.)
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
