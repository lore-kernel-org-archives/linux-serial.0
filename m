From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: Remove orphaned header sc26198.h
Date: Wed, 5 Sep 2012 13:20:48 -0700
Message-ID: <20120905202048.GA17716@kroah.com>
References: <1345564193-25994-1-git-send-email-shc_work@mail.ru>
 <1345567392.4564.30.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64381 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759278Ab2IEUXW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Sep 2012 16:23:22 -0400
Received: by pbbrr13 with SMTP id rr13so1499222pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Sep 2012 13:23:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345567392.4564.30.camel@x61.thuisdomein>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Tue, Aug 21, 2012 at 06:43:12PM +0200, Paul Bolle wrote:
> On Tue, 2012-08-21 at 19:49 +0400, Alexander Shiyan wrote:
> > This header was used by the driver "stallion", but the driver has
> > been removed as a result of migration 2.4 -> 2.6 and the header is
> > still present in the system and is not currently used by any driver.
> > We can safely remove it.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  include/linux/sc26198.h |  533 -----------------------------------------------
> 
> commit afbaade3dc99838a0c39699bea175674f27322a1 ("delete seven tty
> headers"), in - I think - tty.git's tty-next branch, already deleted
> this and six other headers.

Yes, this patch doesn't apply to the tty-next branch for that very
reason.

In the future Alexander, please try working off of the linux-next tree,
that's the best place for stuff like this.

greg k-h
