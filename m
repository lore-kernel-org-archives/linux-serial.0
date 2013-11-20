From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 00/29] Add OF support to the sh-sci serial port driver
Date: Wed, 20 Nov 2013 09:18:37 +0900
Message-ID: <20131120001836.GB7391@verge.net.au>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131119015539.GA9186@verge.net.au>
 <1673549.kq3QFrtT8Z@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1673549.kq3QFrtT8Z@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 19, 2013 at 02:12:43PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 19 November 2013 10:55:39 Simon Horman wrote:
> > On Sun, Nov 10, 2013 at 04:33:12AM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This is the second version of the patch set adds device tree bindings for
> > > the sh sci serial port devices and adds OF parsing to the sh-sci driver.
> > > 
> > > The bindings are based on Bastian Hecht's proposal (see
> > > http://www.spinics.net/lists/arm-kernel/msg228129.html). The approach
> > > taken here is more minimalistic: instead of describing all hardware
> > > characteristics that vary between the SCI device revisions in DT (such as
> > > registers layout), that information is stored in the driver and selected
> > > based on the compatible property value. Only SCI revisions used on ARM
> > > devices are supported through DT, as DT support for SuperH is nowhere
> > > down the line.
> > > 
> > > Patches 01/29 to 06/29 clean up the sh-sci driver.
> > 
> > It seems to me that these could be queued up by Greg.
> > Let me know if you would like me to pass them on to him.
> > I'm quite happy for you to do that yourself. Or to wait.
> > Its entirely up to you.
> > 
> > In any case for those patches:
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Thank you. I'll resend the series with the DT bindings updated for r8a7791 and 
> will ask Greg to pick the patches up and provide a stable branch with patches 
> 01/29 to 07/29.

Thanks, that sounds great.
