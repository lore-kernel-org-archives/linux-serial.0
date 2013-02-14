From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/arc-uart: Urgent DT related update
Date: Thu, 14 Feb 2013 09:23:04 -0800
Message-ID: <20130214172304.GA29021@kroah.com>
References: <201302090928.43929.arnd@arndb.de>
 <1360572101-12744-1-git-send-email-vgupta@synopsys.com>
 <511B88F8.6010907@synopsys.com>
 <20130213163833.GA3465@kroah.com>
 <511C7C38.7030009@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:64896 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434Ab3BNRXH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Feb 2013 12:23:07 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so241509pbb.6
        for <linux-serial@vger.kernel.org>; Thu, 14 Feb 2013 09:23:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <511C7C38.7030009@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org

On Thu, Feb 14, 2013 at 11:25:04AM +0530, Vineet Gupta wrote:
> > I've taken this now, it will be sent to Linus for 3.9-rc1.
> 
> Thanks greg. I understand the tree closing rules' purpose, to let things stabilize
> ahead of merge window - both from mechanical conflicts perspective as well as
> runtime conflicts. However I'm slightly confused here about the process, specially
> as a n00b maintainer and was hoping you could clarify it.
> 
> Your announcement of Feb 9th said
> 
> >With the release of the 3.8-rc7 kernel, I think it's time to close the
> >TTY/serial tree for new features / cleanups for 3.9.  So I'm closing my
> >tree, and will only be applying obvious bugfixes or regressions to it
> >until 3.9-rc1 comes out.
> 
> So a bug fix sent on say Feb 11th would have been be applied to your tree to end
> up in 3.9 merge-window pull to Linus- correct or no ?

Yes.

> So in that sense, since Arnd/Grant are deeming this patch as bug fix,
> shouldn't it make into 3.9 merge-window merge.

Yes, and that is where it will be, as I said so above.

> So maybe, it's the criticality of the bug which warrants that.  Please
> note that I'm just trying to understand the process here and not
> arguing about patch itself.
> 
> >You can keep sending me patches for the tree that don't fit the "bugfix"
> >category, but note that I'll be storing them away to wait for 3.9-rc1
> >comes out, which might be a few weeks, so please be patient.
> 
> And once 3.9-rc1 hits, everything becomes 3.10 merge material anyways
> except for bug fixes.

Yes.

Hope this helps,

greg k-h
