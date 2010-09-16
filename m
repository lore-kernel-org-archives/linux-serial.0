From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/3] Fix the TIOCGICOUNT problem for good
Date: Thu, 16 Sep 2010 11:44:46 -0700
Message-ID: <20100916184446.GA8803@kroah.com>
References: <20100916171747.25987.33573.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:48433 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070Ab0IPSpo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Sep 2010 14:45:44 -0400
Content-Disposition: inline
In-Reply-To: <20100916171747.25987.33573.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, drosenberg@vsecurity.com

On Thu, Sep 16, 2010 at 06:21:06PM +0100, Alan Cox wrote:
> Remembering to clear fields is something driver authors are simply never
> going to remember to get right every new driver. Instead take the problem
> away from them and give them a simple interface to do the job.

Looks good.  But is it ok if I keep the one driver patch I have now for
.36 and queue this up for .37?  I'll handle the merge conflicts myself.

thanks,

greg k-h
