From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Tue, 5 Mar 2013 12:27:45 +0900
Message-ID: <20130305032744.GO16128@verge.net.au>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
 <1361898208-6683-3-git-send-email-hechtb+renesas@gmail.com>
 <20130301094205.GG27938@verge.net.au>
 <CABYn4syZJjDzuj2YqT3wCvnEuyE0Ab-8x=g1+_Fr9gw43_w_rw@mail.gmail.com>
 <20130302013147.GB3273@verge.net.au>
 <CANqRtoTQ5mRCk1bRjkFOf9gj3w1N5ErO9i1HjBGbw=MA=Rh1aQ@mail.gmail.com>
 <Pine.LNX.4.64.1303041424310.14249@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35882 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759092Ab3CED1s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 22:27:48 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1303041424310.14249@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

On Mon, Mar 04, 2013 at 02:33:40PM +0100, Guennadi Liakhovetski wrote:
> Hi
> 
> On Mon, 4 Mar 2013, Magnus Damm wrote:
> 
> > Hi Simon,
> > 
> > [Added Guennadi to CC]
> > 
> > On Sat, Mar 2, 2013 at 10:31 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Fri, Mar 01, 2013 at 10:21:27AM -0600, Bastian Hecht wrote:
> > >> 2013/3/1 Simon Horman <horms@verge.net.au>:
> > >> > On Tue, Feb 26, 2013 at 11:03:28AM -0600, Bastian Hecht wrote:
> > >> >> We can now use the Device Tree for bringing up our serial devices. We
> > >> >> need to add an alternative early_devices list in setup-r8a7740 without
> > >> >> the serial devices and move them into the Armadillo-reference .dts config file.
> > >> >
> > >> > Hi Bastian,
> > >> >
> > >> > could you please refresh this patch on top of the current topic/intc-of.
> > >> > In particular, it conflicts with changes made by:
> > >> >
> > >> > ARM: shmobile: r8a7740: Do not use early devices with DT reference
> > >>
> > >> Sure.
> > >>
> > >> I've prepared the patch - but I start to wonder if the DT
> > >> specification for the SCIF devices should go into r8a7740.dtsi rather
> > >> than r8a7740-armadillo-reference.dts. So far it's included in
> > >> setup-r8a7740.c and not in the board code - that's a strong indication
> > >> for it, no?
> > >
> > > I forget exactly how the discussion went, but for the kzm9g the
> > > SDHI has ended up in the dts file for the board not the sh73a0 SoC.
> > >
> > > So I assume that r8a7740-armadillo-reference.dts is the correct place
> > > for SDHI on the armadillo.
> > >
> > > Magnus, can you confirm that SDHI belongs to the board not the SoC?
> > 
> > What does the data sheet say?
> > 
> > The SDHI hardware block is included in the SoC. It may however need
> > some board specific configuration. I believe the correct way is to
> > define the common parts in the SoC-specific dtsi file and add
> > board-specific configuration in the board-specific dts file. Perhaps
> > you can consult Guennadi about this, he has been tasked with SDHI and
> > MMCIF.
> 
> That would be the best, I agree. However, we discussed this already on the 
> example of mmcif, you might remember. I asked what's the difference 
> between extending a DT node (from .dtsi) with additional properties (in a 
> board-specific .dts) using an "&phandle" syntax and a full path? Or are 
> they equivalent? There was no reply, so, for such nodes (MMC/SD) I so far 
> settled with complete nodes in .dts. We do use the "&phandle" syntax for 
> pinctrl function groups, for I2C devices. I used a complete path for 
> CPUFreq... Mostly because other platforms did that too.

I am confused.

Using phandle syntax we can add a device to an soc's dtsi file and then add
extra properties in the board file.  This seems to be match the HW well.

What is your alternate suggestion?
