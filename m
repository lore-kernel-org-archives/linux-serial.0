From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 repost] serial: sh-sci: Add device tree support for
 r8a7{778,740,3a4} and sh73a0
Date: Sat, 12 Jul 2014 08:50:43 +0200
Message-ID: <20140712065040.GB24129@verge.net.au>
References: <20140711091107.GA25710@verge.net.au>
 <20140712004451.GA9549@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140712004451.GA9549@kroah.com>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 11, 2014 at 05:44:51PM -0700, Greg Kroah-Hartman wrote:
> On Fri, Jul 11, 2014 at 11:11:08AM +0200, Simon Horman wrote:
> > Simply document new compat strings.
> > There appears to be no need for a driver updates.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > --
> > v2
> > * Added r8a73a4, r8a7740 and sh73a0 support
> > 
> > Repost to Greg KH.
> > 
> > Greg, I am hoping to get the platform side of this change included in v3.16.
> 
> Isn't it a bit late for 3.16?  I'll go add this to my 3.16 tree, as it's
> just a .txt file, and leave the fighting over new code to the other
> maintainers :)

Thanks.

In order to avoid fighting I'll queue up the code changes for v3.17.
