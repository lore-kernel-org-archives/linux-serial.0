From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] The correct device id for this card is 0x0022.
Date: Tue, 15 Jan 2013 19:00:21 -0800
Message-ID: <20130116030021.GA29114@kroah.com>
References: <1354740983-4352-1-git-send-email-matts@commtech-fastcom.com>
 <1354740983-4352-2-git-send-email-matts@commtech-fastcom.com>
 <20121205213812.42c61b2e@pyramind.ukuu.org.uk>
 <CAGyNnbh=HLcfscSMjEX=zjzXPbETEmSkzLGAu7kxuEkG9eY0Ow@mail.gmail.com>
 <20130116025938.GB29056@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:59390 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756664Ab3APC7X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jan 2013 21:59:23 -0500
Content-Disposition: inline
In-Reply-To: <20130116025938.GB29056@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Will Fagan <willf@commtech-fastcom.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Schulte <matts_old@commtech-fastcom.com>, linux-serial@vger.kernel.org, Matt Schulte <matts@commtech-fastcom.com>

On Tue, Jan 15, 2013 at 06:59:38PM -0800, Greg KH wrote:
> On Wed, Dec 05, 2012 at 04:20:56PM -0600, Will Fagan wrote:
> > I just spoke with Matt. He isn't by his email and asked if he only
> > needed to resend the patch with the reordering or both patches?
> 
> Both patches please.
> 
> Also, please let me know "what" card you are talking about here in the
> subject and body of the patch.  Also the device type as well?
> 
> ideally the Subject would look like:
> 	Subject: tty: serial: fix device id for the FOO device
> 
> Can you resend both of these after fixing that up so that I can apply
> them?

Oh nevermind, it looks like it was resent, my todo patch queue is looney
right now, sorry for the noise.

greg k-h
