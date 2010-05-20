From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/11] BKL pruning and serial bug fixing
Date: Thu, 20 May 2010 12:01:52 -0700
Message-ID: <20100520190152.GA26047@kroah.com>
References: <20100519120111.16717.71992.stgit@localhost.localdomain>
 <20100520175636.GB17077@kroah.com>
 <20100520190605.141a70ad@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39773 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab0ETTDX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 May 2010 15:03:23 -0400
Content-Disposition: inline
In-Reply-To: <20100520190605.141a70ad@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

On Thu, May 20, 2010 at 07:06:05PM +0100, Alan Cox wrote:
> On Thu, 20 May 2010 10:56:36 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > On Wed, May 19, 2010 at 01:01:42PM +0100, Alan Cox wrote:
> > > BKL elemination using the existing locks
> > 
> > Hm, have all of these patches been in -next before now?  Do you think
> > these are ready to go into .35?
> 
> Sorry - you asked for them to be re-sent with the BKL removal fixes from
> Arnd which is for .36. They aren't needed for .35 and don't really fix
> anything that would be worth backporting either.
> 
> Not .35 material.

Ah, good, I just didn't know where to apply them.  I'll wait till
.35-rc1 is out before queueing them up.

thanks,

greg k-h
