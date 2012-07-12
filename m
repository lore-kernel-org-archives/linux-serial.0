From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 07/10] tty: move the termios object into the tty
Date: Thu, 12 Jul 2012 14:53:23 -0700
Message-ID: <20120712215323.GA9952@kroah.com>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
 <20120712120042.1321.81017.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59354 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161578Ab2GLVxZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 17:53:25 -0400
Content-Disposition: inline
In-Reply-To: <20120712120042.1321.81017.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Thu, Jul 12, 2012 at 01:00:53PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> This will let us sort out a whole pile of tty related races. The
> alternative would be to keep points and refcount the termios objects.
> However
> 1. They are tiny anyway
> 2. Many devices don't use the stored copies
> 3. We can remove a pty special case
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Because I couldn't include a few of the previous patches, this one fails
to apply.  Care to fix those up and resend the remaining ones?

thanks,

greg k-h
