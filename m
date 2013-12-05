From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 00/29] Add OF support to the sh-sci serial port driver
Date: Thu, 05 Dec 2013 11:13:49 +0100
Message-ID: <12385154.nBU2tQtEvn@avalon>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2724721.HK10kZYK7T@avalon> <20131205070342.GC29902@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131205070342.GC29902@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Greg KH <greg@kroah.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-serial@vger.kernel.org

Hi Simon,

On Thursday 05 December 2013 16:03:43 Simon Horman wrote:
> On Thu, Dec 05, 2013 at 06:53:41AM +0100, Laurent Pinchart wrote:
> > On Thursday 05 December 2013 12:33:23 Simon Horman wrote:

[snip]

> > > Laurent, I have v4 of these patches sitting in patchwork.
> > > Would you like me to look at queuing them up as-is or
> > > are you planning v5?
> > 
> > I'm not planning for a v5, but there's another patch series ("[PATCH
> > 00/16] sh-sci: Remove unnecessary fields from platform data") that is
> > similarly organized as sh-sci / platform / sh-sci patches on top of this.
> > Would you like me to reorganize the all the 45 patches in one big series
> > with a single set of platform patches in-between two sets of sh-sci
> > patches ?
> 
> That sounds nice, thanks.
> 
> To be clear, we are planning sh-sci -> soc -> sh-sci ?

That's correct. I believe that should be better than

sh-sci -> soc -> sh-sci -> soc -> sh-sci

:-)

> If so, I'll have a word with Olof (CCed) as he tends to want to avoid such
> circular dependencies if possible.

I prefer to avoid them whenever possible as well, but that's not always the 
case. As all sh-sci patches will go through your tree and thus the ARM SoC 
tree for v3.14 that shouldn't be too much of an issue.

-- 
Regards,

Laurent Pinchart

