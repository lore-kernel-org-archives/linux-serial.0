From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/3] Fix the TIOCGICOUNT problem for good
Date: Thu, 16 Sep 2010 23:01:57 +0100
Message-ID: <20100916230157.0c045cdd@lxorguk.ukuu.org.uk>
References: <20100916171747.25987.33573.stgit@localhost.localdomain>
	<20100916184446.GA8803@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52750 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752677Ab0IPVkY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Sep 2010 17:40:24 -0400
In-Reply-To: <20100916184446.GA8803@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, drosenberg@vsecurity.com

On Thu, 16 Sep 2010 11:44:46 -0700
Greg KH <greg@kroah.com> wrote:

> On Thu, Sep 16, 2010 at 06:21:06PM +0100, Alan Cox wrote:
> > Remembering to clear fields is something driver authors are simply never
> > going to remember to get right every new driver. Instead take the problem
> > away from them and give them a simple interface to do the job.
> 
> Looks good.  But is it ok if I keep the one driver patch I have now for
> .36 and queue this up for .37?  I'll handle the merge conflicts myself.

Probably sensible given the closeness of .36 and the scale of changes
