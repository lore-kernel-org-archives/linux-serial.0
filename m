From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH RESEND 1/2] 8250: pm callback for platform uarts
Date: Fri, 24 Sep 2010 16:41:11 -0700
Message-ID: <20100924234111.GC20601@kroah.com>
References: <1285344809-16839-1-git-send-email-manuel.lauss@googlemail.com> <20100924182258.34a76623@lxorguk.ukuu.org.uk> <AANLkTin=OTRA-cYJyYUn7es6R3cpuZtTLgoggkXgeAnD@mail.gmail.com> <20100925005040.1a127135@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45295 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224Ab0IXXnY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Sep 2010 19:43:24 -0400
Content-Disposition: inline
In-Reply-To: <20100925005040.1a127135@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, Sep 25, 2010 at 12:50:40AM +0100, Alan Cox wrote:
> > > This bit makes sense - but why can't you simply propogate it to the
> > > existing uart_8250_port callback when registering ?
> > 
> > 
> > I need a hook for platform code to reenable the UART block clocks before
> > serial8250_set_sleep() is invoked on resume.  The current code actually
> > works, it's just that on resume the bootloader disables the clocks for
> > all UART blocks except the debug one, which leaves all others dead.
> > 
> > So I added the these calls into these platform methods around
> > serial8250_set_sleep().
> 
> Which isn't the right way to do this IMHO. It may work for your specific
> case but a solution needs to be generic.
> 
> The comment about sticking it in the wrong structd also holds.
> 
> So NAK this patch.

Ok, I'll go drop the two patches in this series from my tree.

thanks,

greg k-h
