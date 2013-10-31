From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/5] Add OF support to the sh-sci serial port driver
Date: Thu, 31 Oct 2013 13:30:12 +0100
Message-ID: <2472479.KWXlO4kKsi@avalon>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20131031052116.GJ1603@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131031052116.GJ1603@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Simon,

On Thursday 31 October 2013 14:21:16 Simon Horman wrote:
> [ CCed Greg KH. It is my assumption that he will take this series
>   once it is ready ]
> 
> On Tue, Oct 29, 2013 at 11:29:54AM +0100, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch set adds device tree bindings for the sh sci serial port
> > devices and adds OF parsing to the sh-sci driver.
> > 
> > The bindings are based on Bastian Hecht's proposal (see
> > http://www.spinics.net/lists/arm-kernel/msg228129.html). The approach
> > taken here is more minimalistic: instead of describing all hardware
> > characteristics that vary between the SCI device revisions in DT (such as
> > registers layout), that information is stored in the driver and selected
> > based on the compatible property value. Only SCI revisions used on ARM
> > devices are supported through DT, as DT support for SuperH is nowhere
> > down the line.
> > 
> > The first three patches clean up the sh-sci driver. They're not strictly
> > required for OF support but make sense nonetheless. The last two patches
> > add OF parsing to the sh-sci driver and create DT bindings documentation.
> > 
> > The patches have been test on a Lager board (r8a7790-based). Support for
> > other SoCs will be added as needed. Note that all current Renesas ARM
> > SoCs seem to be compatible with the generic (H)SCI(F)(AB) devices, but
> > the plan is for their DT bindings to list the SoC-specific version in
> > case incompatibilities are found later.
> > 
> > Cc: devicetree@vger.kernel.org
> > 
> > Bastian Hecht (1):
> >   serial: sh-sci: Add OF support
> > 
> > Laurent Pinchart (4):
> >   serial: sh-sci: Sort headers alphabetically
> >   serial: sh-sci: Remove baud rate calculation algorithm 5
> >   serial: sh-sci: Simplify baud rate calculation algorithms
> >   serial: sh-sci: Add device tree bindings documentation
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Laurent, is this series waiting on anything other than a review of the
> bindings from the Device-Tree people?

It's only waiting for review of the DT bindings and their implementation 
(patches 4/5 and 5/5). As I've modified Bastian's patch in 4/5 I'd like to 
give him an opportunity to review it as well.

-- 
Regards,

Laurent Pinchart

