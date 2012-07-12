From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/10] tty: move the termios object into the tty
Date: Fri, 13 Jul 2012 00:43:00 +0100
Message-ID: <20120713004300.138af34c@pyramind.ukuu.org.uk>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
	<20120712120042.1321.81017.stgit@localhost.localdomain>
	<20120712215323.GA9952@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60789 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161590Ab2GLXjT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 19:39:19 -0400
In-Reply-To: <20120712215323.GA9952@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

On Thu, 12 Jul 2012 14:53:23 -0700
Greg KH <greg@kroah.com> wrote:

> On Thu, Jul 12, 2012 at 01:00:53PM +0100, Alan Cox wrote:
> > From: Alan Cox <alan@linux.intel.com>
> > 
> > This will let us sort out a whole pile of tty related races. The
> > alternative would be to keep points and refcount the termios objects.
> > However
> > 1. They are tiny anyway
> > 2. Many devices don't use the stored copies
> > 3. We can remove a pty special case
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> Because I couldn't include a few of the previous patches, this one fails
> to apply.  Care to fix those up and resend the remaining ones?

Let me just resend the lot in the right order and with the right bits
sorted tomorrow.

Alan
