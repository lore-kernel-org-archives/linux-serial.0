From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] kernel/printk.c: Concerns about the console handover
Date: Fri, 21 Sep 2007 14:43:32 +0100
Message-ID: <20070921134331.GC20277@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64N.0709201749240.30788@blysk.ds.pg.gda.pl> <20070921010349.2caee558.akpm@linux-foundation.org> <Pine.LNX.4.64N.0709211428300.2724@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34063 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757713AbXIUNn6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2007 09:43:58 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0709211428300.2724@blysk.ds.pg.gda.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Gerd Hoffmann <kraxel@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Yinghai.Lu@Sun.COM, bryan.wu@analog.com, dilinger@queued.net, kraxel@redhat.com, lethal@linux-sh.org, rgetz@blackfin.uclinux.org, vapier.adi@gmail.com

On Fri, Sep 21, 2007 at 02:36:50PM +0100, Maciej W. Rozycki wrote:
> On Fri, 21 Sep 2007, Andrew Morton wrote:
> 
> > It would be useful to have some basic information like: Which kernel
> > version was this found in?  Which kernel version last worked?
> 
>  The kernel used was a 2.6.23-rc5 snapshot from Sep 4th, 2007 taken from 
> the linux-mips.org tree (as stated by the revision of the patch provided).  
> There is no version that can be considered working as the change to add 
> the printk() to register_console() went in before drivers/serial/zs.c was 
> added and the old drivers/tc/zs.c driver might have been to sloppy to 
> handle such bits as the transmitter enable properly.  I may investigate.
> 
>  Chances are nobody tried any version of the kernel from the period 
> between the printk() was added and drivers/tc/zs.c removed with the 
> DECstation; I have not.
> 
>  Anyway, I did confirm keeping the transmitter enabled all the time makes 
> the problem go away.

I suspect the correct fix for this is to take the fix in the ARM tree
for serial_core's console initialisation, and ensure that zs.c handles
the power management of the port (enabling/disabling transmitter)
in the power management callback.

You can find the fix in the mbox archive:

 http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cut/arm:devel.mbox

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
