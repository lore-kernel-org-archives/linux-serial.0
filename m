From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 0/3] Fix the TIOCGICOUNT problem for good
Date: Mon, 20 Sep 2010 09:31:07 +0100
Message-ID: <20100920093107.379c431c@linux.intel.com>
References: <20100916171747.25987.33573.stgit@localhost.localdomain>
	<20100918155820.GA3942@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13239 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756057Ab0ITJRW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Sep 2010 05:17:22 -0400
In-Reply-To: <20100918155820.GA3942@infradead.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com, drosenberg@vsecurity.com

On Sat, 18 Sep 2010 11:58:20 -0400
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Sep 16, 2010 at 06:21:06PM +0100, Alan Cox wrote:
> > Remembering to clear fields is something driver authors are simply
> > never going to remember to get right every new driver. Instead take
> > the problem away from them and give them a simple interface to do
> > the job.
> 
> Btw, I wonder if all the standard tty ioctls should get similar
> treatment.  That way we have a nice enough skeleton of what needs to
> be implemented in every tty driver instead of passing down the raw
> ioctl method.

They have pretty much entirely now - TIOCMIWAIT is the main one that
hasn't been done, but that really wants a generic implementation in
tty_port that most drivers could then use.

Alan
