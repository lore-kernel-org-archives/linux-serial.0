From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] SERIAL: discover PNP ports before PCI, etc
Date: Thu, 10 Feb 2005 18:39:33 +0000
Message-ID: <20050210183932.A5800@flint.arm.linux.org.uk>
References: <1107979967.27371.42.camel@eeyore> <20050210021652.GA594@neo.rr.com> <1108053798.29578.12.camel@eeyore> <20050210173725.GA380@neo.rr.com> <1108057762.29578.29.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5649 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261191AbVBJSjk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Feb 2005 13:39:40 -0500
Content-Disposition: inline
In-Reply-To: <1108057762.29578.29.camel@eeyore>; from bjorn.helgaas@hp.com on Thu, Feb 10, 2005 at 10:49:22AM -0700
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-serial@vger.kernel.org, shaohua.li@intel.com

On Thu, Feb 10, 2005 at 10:49:22AM -0700, Bjorn Helgaas wrote:
> On Thu, 2005-02-10 at 12:37 -0500, Adam Belay wrote:
> > We could always add this change to -mm and see what effect it has.  Let me
> > know if you still think this makes sense.
> 
> Yeah, I think that's Russell's plan, which I think is the right one.

And I notice that Andrew released a new -mm with the change in.
Let the testing commence! 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
