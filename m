From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 00/29] Add OF support to the sh-sci serial port driver
Date: Thu, 5 Dec 2013 12:33:23 +0900
Message-ID: <20131205033322.GK21443@verge.net.au>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2057415.BMTvM9f5bq@avalon>
 <20131203180953.GD15279@kroah.com>
 <2824851.TLa71oqPbP@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2824851.TLa71oqPbP@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg KH <greg@kroah.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 03, 2013 at 07:28:47PM +0100, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Tuesday 03 December 2013 10:09:53 Greg KH wrote:
> > On Thu, Nov 21, 2013 at 08:17:27AM +0100, Laurent Pinchart wrote:
> > > Hi Simon (and Greg this time),
> > > On Thursday 21 November 2013 13:40:38 Simon Horman wrote:
> > > > On Tue, Nov 19, 2013 at 03:02:01PM +0100, Laurent Pinchart wrote:
> > > > > Hello,
> > > > > 
> > > > > This is the third version of the patch set adds device tree bindings
> > > > > for the sh sci serial port devices and adds OF parsing to the sh-sci
> > > > > driver.
> > > > > 
> > > > > The bindings are based on Bastian Hecht's proposal (see
> > > > > http://www.spinics.net/lists/arm-kernel/msg228129.html). The approach
> > > > > taken here is more minimalistic: instead of describing all hardware
> > > > > characteristics that vary between the SCI device revisions in DT (such
> > > > > as registers layout), that information is stored in the driver and
> > > > > selected based on the compatible property value. Only SCI revisions
> > > > > used on ARM devices are supported through DT, as DT support for SuperH
> > > > > is nowhere down the line.
> > > > > 
> > > > > Patches 01/29 to 06/29 clean up the sh-sci driver. Patches 07/29 to
> > > > > 27/29 replace memory and interrupt resources passed through platform
> > > > > data with platform resources. Beside replacing a custom mechanism with
> > > > > a standard one, it will also make the DT parsing code simpler as
> > > > > resource allocation will be shared between DT and non-DT code paths.
> > > > > Finally, patches 28/29 to 29/29 add OF parsing to the sh-sci driver
> > > > > and create DT bindings documentation.
> > > > > 
> > > > > The patches have been test on a Lager board (r8a7790-based) and a
> > > > > Koelsch board (r8a7791-based). Support for other SoCs will be added as
> > > > > needed. Note that all current Renesas ARM SoCs seem to be compatible
> > > > > with the generic (H)SCI(F)(AB) devices, but the plan is for their DT
> > > > > bindings to list the SoC-specific version in case incompatibilities
> > > > > are found later.
> > > > > 
> > > > > The series will need to be split in three parts to go to mainline.
> > > > > Patches 01/29 to 07/29 should go through Greg's tree, patches 08/29 to
> > > > > 26/29 through Simon's tree, and patches 27/29 to 29/29 through Greg's
> > > > > tree again. Greg, when applying the first seven patches, could you
> > > > > please provide a stable branch for Simon to base his branch on (I can
> > > > > send you a pull request rebased on top of v3.13-rc1 if that can help)
> > > > > ? Simon will in turn provide a stable branch to base the last three
> > > > > patches on.
> > > > 
> > > > Perhaps you meant to CC Greg?
> > > 
> > > Indeed :-)
> > 
> > That's a mess, how about Simon just take all of these in his tree:
> 
> We all seem to agree that it's the best solution, so let's do that. There will 
> be a couple of other sh-sci patches for the next kernel version that should 
> then go through Simon's tree as well. I will make sure to post them for review 
> on the linux-serial list and CC you to get your ack (from what I've been told 
> the ARM SoC maintainer usually dislike driver patches going through their tree 
> without the driver subsystem maintainer ack).
> 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thank you.

Yes, thanks Greg.

Laurent, I have v4 of these patches sitting in patchwork.
Would you like me to look at queuing them up as-is or
are you planning v5?
