From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] Fix the TIOCGICOUNT problem for good
Date: Sat, 18 Sep 2010 11:58:20 -0400
Message-ID: <20100918155820.GA3942@infradead.org>
References: <20100916171747.25987.33573.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:48391 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab0IRP6V (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Sep 2010 11:58:21 -0400
Content-Disposition: inline
In-Reply-To: <20100916171747.25987.33573.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com, drosenberg@vsecurity.com

On Thu, Sep 16, 2010 at 06:21:06PM +0100, Alan Cox wrote:
> Remembering to clear fields is something driver authors are simply never
> going to remember to get right every new driver. Instead take the problem
> away from them and give them a simple interface to do the job.

Btw, I wonder if all the standard tty ioctls should get similar
treatment.  That way we have a nice enough skeleton of what needs to be
implemented in every tty driver instead of passing down the raw ioctl
method.

