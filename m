From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Did quatech changes make 3.8? (was: Re: Comments requested:
 driver for Quatech PCI serial cards)
Date: Sun, 9 Dec 2012 18:19:28 -0800
Message-ID: <20121210021927.GB7562@kroah.com>
References: <20121114231054.GC4505@marvin.atrad.com.au>
 <20121114235719.794a9bdc@pyramind.ukuu.org.uk>
 <20121115001110.GE4505@marvin.atrad.com.au>
 <20121115155347.4be3dce8@pyramind.ukuu.org.uk>
 <20121128022917.GD28558@marvin.atrad.com.au>
 <20121128132419.1094d2d3@pyramind.ukuu.org.uk>
 <20121128134140.GA29452@marvin.atrad.com.au>
 <20121128173010.GC32286@kroah.com>
 <20121128223300.GA24713@marvin.atrad.com.au>
 <20121210001347.GB22907@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46095 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab2LJCRK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Dec 2012 21:17:10 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1534576pbc.19
        for <linux-serial@vger.kernel.org>; Sun, 09 Dec 2012 18:17:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121210001347.GB22907@marvin.atrad.com.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Mon, Dec 10, 2012 at 10:43:47AM +1030, Jonathan Woithe wrote:
> On Thu, Nov 29, 2012 at 09:03:00AM +1030, Jonathan Woithe wrote:
> > On Wed, Nov 28, 2012 at 09:30:10AM -0800, Greg KH wrote:
> > > On Thu, Nov 29, 2012 at 12:11:40AM +1030, Jonathan Woithe wrote:
> > > > On Wed, Nov 28, 2012 at 01:24:19PM +0000, Alan Cox wrote:
> > > > > Can we get a Signed-off-by: for the first patch so we can try and get it
> > > > > into 3.8 ?
> > > > 
> > > > Sure.  See below.  The rest of the previous commit message was fine so I
> > > > haven't replicated it here.
> > > 
> > > Please do, otherwise I have to hand-edit the patch to add it back, and
> > > odds are, I will get it wrong...
> > 
> > No problem.  See below.  I took the opportunity to tweak the commit message
> > a touch.
> 
> I am wondering (for documentation purposes) whether the quatech changes
> below made 3.8 or whether they'll appear in 3.9.  I don't see them in
> linux-next or tty-next, but I'm still learning git and might have done
> something wrong while searching.

Odd, I somehow missed this, thinking Alan would resend it later, I'll
queue it up next week and it should make 3.8-final.

thanks,

greg k-h
