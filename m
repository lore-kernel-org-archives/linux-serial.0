From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 07:35:26 -0700
Message-ID: <20130426143526.GA15132@kroah.com>
References: <51781A19.5030707@compro.net>
 <1366926071.3452.17.camel@thor.lan>
 <517A79E1.8060504@compro.net>
 <1366983913.3452.33.camel@thor.lan>
 <517A8EF1.8040006@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47245 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3DZOf3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 10:35:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id xa7so1168219pbc.5
        for <linux-serial@vger.kernel.org>; Fri, 26 Apr 2013 07:35:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517A8EF1.8040006@compro.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Hounschell <markh@compro.net>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On Fri, Apr 26, 2013 at 10:28:01AM -0400, Mark Hounschell wrote:
> This particular driver and one other are normal PCI based cards. I
> also have one other that is PCI-e. This particular one is the only
> one that creates all these weird device entries. The other 2 are
> pretty straight forward. One entry per port. I figured I'd tackle
> this one first.

I would remove those other "weird" device entries from the driver, we
removed those types of device nodes from the kernel tree many many years
ago.  Just stick to one device node per port, and all should be fine.

Also, any reason why these drivers aren't in the main kernel tree?  If
they were, all of this work would have been done for you :)

thanks,

greg k-h
