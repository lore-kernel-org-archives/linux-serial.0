From: Greg KH <greg@kroah.com>
Subject: Re: [RFC 0/5] Starting to pull out the I/O operations
Date: Fri, 18 Mar 2011 13:04:39 -0700
Message-ID: <20110318200439.GB4453@kroah.com>
References: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35708 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756818Ab1CRUEv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 16:04:51 -0400
Content-Disposition: inline
In-Reply-To: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Fri, Mar 18, 2011 at 03:24:29PM +0000, Alan Cox wrote:
> This is an untested WIP but as it was coming in discussion about device-tree
> as well I figured it will be useful to post the prototype code at this point.
> 
> There is lots left to do - in particular resource claim/release should be an
> ops method, and it's going to need people to update various embedded 8250 
> drivers when we finally go for a version of it.
> 
> On the bright side once we have an ops structure we have the basis for avoiding
> further mayhem in the arch code.

This looks great to me, nice job.

Feel free to resend it when you want me to queue it up for .40.

thanks,

greg k-h
