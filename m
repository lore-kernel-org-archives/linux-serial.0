From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] serial: 8250: Add ns16550a to OF compatible
	list
Date: Tue, 24 Nov 2009 06:35:35 -0800
Message-ID: <20091124143535.GA30711@kroah.com>
References: <1259054502-28284-1-git-send-email-monstr@monstr.eu> <1259054502-28284-2-git-send-email-monstr@monstr.eu> <200911240953.52204.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46095 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933107AbZKXOkW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Nov 2009 09:40:22 -0500
Content-Disposition: inline
In-Reply-To: <200911240953.52204.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@monstr.eu, chrisw@sous-sol.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, alonz@discretix.com, linux-serial@vger.kernel.org, stable@kernel.org, john.williams@petalogix.com

On Tue, Nov 24, 2009 at 09:53:52AM +0000, Arnd Bergmann wrote:
> On Tuesday 24 November 2009 09:21:42 monstr@monstr.eu wrote:
> > From: Michal Simek <monstr@monstr.eu>
> > 
> > Signed-off-by: Michal Simek <monstr@monstr.eu>
> 
> I was holding off on that patch to make sure the discussion had ended,
> but this part certainly looks good.
> 
> Some points on form though:
> 
> * The patch is missing a changelog, which is always required, but especially
> important if you're changing code that you want in -stable!
> 
> * You did not cc me. Ok, I just noticed I'm missing an entry in the MAINTAINERS
> file, but scripts/get_maintainer.pl would have given you a good indication of
> who feels responsible. You also didn't cc Alon, who submitted a similar patch
> [1] just days ago, which I assume prompted you to send this. If you didn't see
> his patch, nevermind.
> 
> * Patches go into mainline first, then into stable [2]. Asking for inclusion into
> -stable for a patch that is still being discussed for inclusion in -next is
> the wrong order, no matter how obvious and trivial the patch is.

The easiest way to do this is to add:
	cc: stable <stable@kernel.org>
to the signed-off-by area of the patch.  Then, when it goes into Linus's
tree the stable developers will be automatically notified of it and suck
it into their tree as well, no additional work needs to be done by you
at all.

thanks,

greg k-h
