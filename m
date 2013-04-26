From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Fri, 26 Apr 2013 16:21:52 -0700
Message-ID: <20130426232152.GA10407@kroah.com>
References: <1366926071.3452.17.camel@thor.lan>
 <517A79E1.8060504@compro.net>
 <1366983913.3452.33.camel@thor.lan>
 <517A8EF1.8040006@compro.net>
 <20130426143526.GA15132@kroah.com>
 <517A98D6.2020701@compro.net>
 <20130426151905.GA27340@kroah.com>
 <1366990765.3452.50.camel@thor.lan>
 <20130426160348.GA28863@kroah.com>
 <517AC036.7000009@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44367 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab3DZXVz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Apr 2013 19:21:55 -0400
Received: by mail-pd0-f171.google.com with SMTP id t12so2690457pdi.2
        for <linux-serial@vger.kernel.org>; Fri, 26 Apr 2013 16:21:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517AC036.7000009@compro.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Hounschell <markh@compro.net>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On Fri, Apr 26, 2013 at 01:58:14PM -0400, Mark Hounschell wrote:
> As for the Digi card driver/drivers, I can't say why not. There is a
> remnant of the actual one this thread is pertaining to in
> ./Documentation/serial/digiepca.txt. I've never submitted it or any
> of their others I have to maintain because I didn't know I could nor
> would know how to start. I thought that Digi would have had to do
> it.
> 
> As far as Compro's drivers go, I think we have just been a little
> wary/unknowing of what it would take and what the results of the
> effort would actually be. Would they still do what _we_ needed them
> to do? Are we kernel savvy enough to get them to a state you would
> accept? etc... We do understand that if they were in the kernel that
> the best qualified people would be the ones that "kept them current"
> with the latest kernel changes. It's certainly something that no one
> here would object to doing. Are you the man to talk to? What is the
> actual process?

Yes, I'm the person to talk to about doing this, we can take it off-list
if you want.

But, for some reading material about the process, take a look at
Documentation/SubmittingDrivers and Documentation/SubmittingPatches in
the kernel source tree.

Also, if you don't want to do the work, I, and a bunch of others, will
be glad to do it for you, for free, see the site linuxdriverproject.org
for some details about that.

Hope this helps,

greg k-h
