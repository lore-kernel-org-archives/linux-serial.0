From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] kernel/printk.c: Concerns about the console handover
Date: Fri, 21 Sep 2007 14:36:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0709211428300.2724@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709201749240.30788@blysk.ds.pg.gda.pl>
 <20070921010349.2caee558.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:49264 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXIUNhG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2007 09:37:06 -0400
In-Reply-To: <20070921010349.2caee558.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gerd Hoffmann <kraxel@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Yinghai.Lu@Sun.COM, bryan.wu@analog.com, dilinger@queued.net, kraxel@redhat.comGerd Hoffmann <kraxel@suse.de>, lethal@linux-sh.org, rgetz@blackfin.uclinux.org, vapier.adi@gmail.com, Russell King <rmk@arm.linux.org.uk>

On Fri, 21 Sep 2007, Andrew Morton wrote:

> It would be useful to have some basic information like: Which kernel
> version was this found in?  Which kernel version last worked?

 The kernel used was a 2.6.23-rc5 snapshot from Sep 4th, 2007 taken from 
the linux-mips.org tree (as stated by the revision of the patch provided).  
There is no version that can be considered working as the change to add 
the printk() to register_console() went in before drivers/serial/zs.c was 
added and the old drivers/tc/zs.c driver might have been to sloppy to 
handle such bits as the transmitter enable properly.  I may investigate.

 Chances are nobody tried any version of the kernel from the period 
between the printk() was added and drivers/tc/zs.c removed with the 
DECstation; I have not.

 Anyway, I did confirm keeping the transmitter enabled all the time makes 
the problem go away.

  Maciej
