From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Fri, 9 Mar 2007 08:57:53 +0000
Message-ID: <20070309085753.GC29959@flint.arm.linux.org.uk>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com> <200703081523.39698.rgetz@blackfin.uclinux.org> <20070308204020.GE30023@flint.arm.linux.org.uk> <200703081832.29274.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4749 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbXCII6Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Mar 2007 03:58:16 -0500
Content-Disposition: inline
In-Reply-To: <200703081832.29274.rgetz@blackfin.uclinux.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Oleksiy Kebkal <kebkal@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On Thu, Mar 08, 2007 at 06:32:29PM -0500, Robin Getz wrote:
> On Thu 8 Mar 2007 15:40, Russell King pondered:
> > On Thu, Mar 08, 2007 at 03:23:39PM -0500, Robin Getz wrote:
> > > Right - We both agree - And setting console=/dev/null in the bootargs
> > > still does not help.
> >
> > Ok, good.
> >
> > > When the kernel initializes the UART Port, it asserts RTS - which
> > > confuses the host it is attached to (in this case, the Linux system
> > > is the serial peripheral).
> >
> > ... which occurs /after/ userspace is up and running, when sysfs is
> > available.  So putting it in sysfs is reasonable.
> 
> Hmm - maybe I don't understand things then.
> 
> Today - RTS gets asserted when serial_core calls uart_startup(), which is 
> pretty early in the boot process (unless it is loaded as a module - which I'm 
> not doing).

uart_startup() is called when something opens a serial port.  There's
two points which that happens:

1. when you have serial console enabled, and the kernel opens /dev/console
   before starting userspace.

2. when userspace opens a serial port.

If you're not using a serial console (and you don't have an utterly broken
/dev nodes - iow incorrect /dev/console entry), then (1) doesn't apply.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
