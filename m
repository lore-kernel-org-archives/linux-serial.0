From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: bfin_5xx: move resources into board files
Date: Thu, 28 Oct 2010 11:11:33 -0700
Message-ID: <20101028181133.GC2573@kroah.com>
References: <1288167527-31648-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46298 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761137Ab0J1SVa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Oct 2010 14:21:30 -0400
Content-Disposition: inline
In-Reply-To: <1288167527-31648-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Wed, Oct 27, 2010 at 04:18:47AM -0400, Mike Frysinger wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Rather than maintain Kconfig entries where people have to enter raw
> numbers and hardcode lists of addresses/pins in the driver itself,
> push it all to platform resources.  This lets us simplify the driver,
> the Kconfig, and gives board porters greater flexibility.
> 
> In the process, we need to also start supporting the early platform
> interface.  Not a big deal, but it causes the patch to be bigger than
> a simple resource relocation.
> 
> All the Blackfin boards already have their resources updated and in
> place for this change.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> Note: this is for 2.6.38 ... it depends on a Blackfin clean up patch
> 	that i'll be merging at the start of the 2.6.38 cycle.  looking
> 	for feedback here and/or just an Ack so i may merge it through my
> 	Blackfin tree with the related changes.

Fine with me, feel free to merge it through your tree for .38 with a:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
for it.

thanks,

greg k-h
