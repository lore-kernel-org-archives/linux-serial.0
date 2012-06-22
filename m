From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 09/12] commit 22126843cb3c2a782c2d52614486115f3e9db478
Date: Fri, 22 Jun 2012 18:04:23 +0100
Message-ID: <20120622180423.24c0001b@pyramind.ukuu.org.uk>
References: <20120622153600.1405.15575.stgit@localhost.localdomain>
	<20120622154438.1405.43658.stgit@localhost.localdomain>
	<20120622153657.GB6081@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:40936 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138Ab2FVRAh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Jun 2012 13:00:37 -0400
In-Reply-To: <20120622153657.GB6081@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, 22 Jun 2012 08:36:57 -0700
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Jun 22, 2012 at 04:44:59PM +0100, Alan Cox wrote:
> > From: Alan Cox <alan@linux.intel.com>
> > 
> > tty: move the termios object into the tty
> > 
> >     This will let us sort out a whole pile of tty related races. The
> >     alternative would be to keep points and refcount the termios objects.
> >     However
> >     1. They are tiny anyway
> >     2. Many devices don't use the stored copies
> >     3. We can remove a pty special case
> > 
> >     Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> Odd subject line, and formatting, did something go wrong with your
> scripts?

Apparently so. I will given them a stern talking to and repost
