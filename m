From: Federico Natali <federico.natali@selex-es.com>
Subject: Re: Adding a serial device
Date: Wed, 25 Sep 2013 07:35:53 +0000 (UTC)
Message-ID: <loom.20130925T092237-530@post.gmane.org>
References: <loom.20130924T092704-635@post.gmane.org> <20130924134452.GB7246@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49561 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab3IYHgO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Sep 2013 03:36:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VOjdr-00042z-PP
	for linux-serial@vger.kernel.org; Wed, 25 Sep 2013 09:36:11 +0200
Received: from host186-141-static.47-85-b.business.telecomitalia.it ([85.47.141.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2013 09:36:11 +0200
Received: from federico.natali by host186-141-static.47-85-b.business.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2013 09:36:11 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Greg KH <gregkh <at> linuxfoundation.org> writes:

> 
> On Tue, Sep 24, 2013 at 08:49:48AM +0000, Federico Natali wrote:
> > 
> > Hi to everyone, 
> > 
> > I'm quite new at kernel hacking and I'm having problems trying to make 
a 
> > serial device work on a custom board.
> > 
> > I hope this is the right place for asking support, if not I'd be 
grateful 
> > if could you point me to the right place.
> > 
> > My situation is as follows:
> > 
> > I'm working on a custom board based on the ARM SoC DM8168 by Texas 
> > Instruments and I'm using a Linux distribution from TI based on 2.6.37 
> > kernel
> 
> As you are stuck on a really old, and obsolete kernel, that was provided
> by a vendor, there's almost nothing we can do here to help with this.  I
> suggest you contact the vendor as they are the best ones to help out,
> especially as you are paying for support from them for this codebase.
> 
> Best of luck,

Thank you for your reply, I'll contact the TI for support. 

In the meanwhile could you please tell me if the procedure I'm following is 
correct from a standard kernel point of view or if there is some 
fundamental mistake in what I'm doing?

Bye, Federico Natali



