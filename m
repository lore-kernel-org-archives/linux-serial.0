From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] serial: sh-sci: Fix warnings due to improper casts
 and printk formats
Date: Fri, 29 Nov 2013 09:12:12 +0900
Message-ID: <20131129001208.GA6462@verge.net.au>
References: <1385547037-13422-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131128072731.GB24146@verge.net.au>
 <1772107.qNxlNP4NDS@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1772107.qNxlNP4NDS@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 28, 2013 at 03:00:35PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 28 November 2013 16:27:31 Simon Horman wrote:
> > On Wed, Nov 27, 2013 at 11:10:37AM +0100, Laurent Pinchart wrote:
> > > Use the %zu printk specifier to print size_t variables, and cast
> > > pointers to uintptr_t instead of unsigned int where applicable. This
> > > fixes warnings on platforms where pointers and/or dma_addr_t have a
> > > different size than int.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-serial@vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Laurent, I am assuming that you would like Greg to take this one.
> 
> Actually, as we have quite a few pending sh-sci patches interleaved with 
> arch/arm patches, it would be easier if all sh-sci patches went through your 
> tree for this kernel version. That's if Greg agrees of course.

Thanks, that is fine by me so long as its fine by Greg and I get
an Ack from him for each of the sh-sci that go into my tree.
