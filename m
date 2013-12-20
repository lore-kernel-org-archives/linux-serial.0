From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 00/29] Add OF support to the sh-sci serial port driver
Date: Fri, 20 Dec 2013 02:48:10 +0100
Message-ID: <38543610.aspcIFqj1g@avalon>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131209185918.GC27562@quad.lixom.net> <20131209234205.GB24573@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131209234205.GB24573@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Olof Johansson <olof@lixom.net>, Greg KH <greg@kroah.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Tuesday 10 December 2013 08:42:05 Simon Horman wrote:
> On Mon, Dec 09, 2013 at 10:59:18AM -0800, Olof Johansson wrote:
> > On Thu, Dec 05, 2013 at 04:03:43PM +0900, Simon Horman wrote:
> > > On Thu, Dec 05, 2013 at 06:53:41AM +0100, Laurent Pinchart wrote:

[snip]

> > > > I'm not planning for a v5, but there's another patch series ("[PATCH
> > > > 00/16] sh-sci: Remove unnecessary fields from platform data") that is
> > > > similarly organized as sh-sci / platform / sh-sci patches on top of
> > > > this. Would you like me to reorganize the all the 45 patches in one
> > > > big series with a single set of platform patches in-between two sets
> > > > of sh-sci patches ?
> > > 
> > > That sounds nice, thanks.
> > > 
> > > To be clear, we are planning sh-sci -> soc -> sh-sci ?
> > > 
> > > If so, I'll have a word with Olof (CCed) as he tends to want
> > > to avoid such circular dependencies if possible.
> > 
> > What are the platform changes in the middle that you need?

Basically we need to change the driver platform data, so the first part gets 
the driver in shape by adding new platform data fields, the second part 
switches the platform code, and the third part removes the old fields. Part of 
this is about switching from passing IRQs and memory base through platform 
data to passing them through resources, which is a dependency for OF support.

> I will let Laurent speak to the nature of the changes.
> 
> In terms of patches Laurent has recently published a single series
> which includes sh-sci patches, followed by SoC patches, followed
> by sh-sci patches. The series is "[PATCH 00/47] sh-sci updates for v3.14"
> 
> http://www.spinics.net/lists/linux-sh/msg26033.html

-- 
Regards,

Laurent Pinchart

