From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 00/29] Add OF support to the sh-sci serial port driver
Date: Tue, 10 Dec 2013 02:03:12 +0100
Message-ID: <1522281.dMO104xr5U@avalon>
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

Hi Olof,

On Tuesday 10 December 2013 08:42:05 Simon Horman wrote:
> On Mon, Dec 09, 2013 at 10:59:18AM -0800, Olof Johansson wrote:
> > On Thu, Dec 05, 2013 at 04:03:43PM +0900, Simon Horman wrote:

[snip]

> > > To be clear, we are planning sh-sci -> soc -> sh-sci ?
> > > 
> > > If so, I'll have a word with Olof (CCed) as he tends to want
> > > to avoid such circular dependencies if possible.
> > 
> > What are the platform changes in the middle that you need?
> 
> I will let Laurent speak to the nature of the changes.
> 
> In terms of patches Laurent has recently published a single series
> which includes sh-sci patches, followed by SoC patches, followed
> by sh-sci patches. The series is "[PATCH 00/47] sh-sci updates for v3.14"
> 
> http://www.spinics.net/lists/linux-sh/msg26033.html

There's two of them. The series replaces platform data fields for platform 
device resources (for memory I/O region address and IRQs) and other platform 
data fields (for baud rate calculation information). This requires modifying 
the driver first to support the new method of passing information, followed by 
modifying the platforms to use it, and finally removing the old method from 
the driver.

As all sh-sci driver patches will go through Simon's tree for this kernel 
release, and as the series has been acked by Greg as the serial tree 
maintainer, I believe this should not be a problem from a merge perspective.

-- 
Regards,

Laurent Pinchart

