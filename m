From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Wed, 28 Nov 2012 09:30:10 -0800
Message-ID: <20121128173010.GC32286@kroah.com>
References: <20121114060724.GN30156@marvin.atrad.com.au>
 <20121114121222.3e42860f@pyramind.ukuu.org.uk>
 <20121114231054.GC4505@marvin.atrad.com.au>
 <20121114235719.794a9bdc@pyramind.ukuu.org.uk>
 <20121115001110.GE4505@marvin.atrad.com.au>
 <20121115155347.4be3dce8@pyramind.ukuu.org.uk>
 <20121128022917.GD28558@marvin.atrad.com.au>
 <20121128132419.1094d2d3@pyramind.ukuu.org.uk>
 <20121128134140.GA29452@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55297 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975Ab2K1RaM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 12:30:12 -0500
Content-Disposition: inline
In-Reply-To: <20121128134140.GA29452@marvin.atrad.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Thu, Nov 29, 2012 at 12:11:40AM +1030, Jonathan Woithe wrote:
> On Wed, Nov 28, 2012 at 01:24:19PM +0000, Alan Cox wrote:
> > > With regard to the ioctl, should this be an implementation of the ioctl
> > > provided by the old out-of-tree driver, or is there an established
> > > standard/example which I should write against instead?
> > 
> > We have a standard (if possibly needing a few bits adding) ioctl for
> > basic RS422/485 features. That's TIOCG/SRS485 (which for all the naming
> > is also kind of 422 and other related bits as well)
> 
> Ok, thanks for the pointer.  I'll take a look at this in due course.
> 
> > Can we get a Signed-off-by: for the first patch so we can try and get it
> > into 3.8 ?
> 
> Sure.  See below.  The rest of the previous commit message was fine so I
> haven't replicated it here.

Please do, otherwise I have to hand-edit the patch to add it back, and
odds are, I will get it wrong...

thanks,

greg k-h
