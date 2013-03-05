From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Tue, 5 Mar 2013 12:36:02 +0900
Message-ID: <20130305033601.GP16128@verge.net.au>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
 <1361898208-6683-3-git-send-email-hechtb+renesas@gmail.com>
 <20130301094205.GG27938@verge.net.au>
 <CABYn4syZJjDzuj2YqT3wCvnEuyE0Ab-8x=g1+_Fr9gw43_w_rw@mail.gmail.com>
 <20130302013147.GB3273@verge.net.au>
 <CANqRtoTQ5mRCk1bRjkFOf9gj3w1N5ErO9i1HjBGbw=MA=Rh1aQ@mail.gmail.com>
 <CABYn4sxPpzKGc83WkRYzcAzJ1TeDgBPgpjvnyGkvgy4kT4Jt6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49834 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab3CEDgF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 22:36:05 -0500
Content-Disposition: inline
In-Reply-To: <CABYn4sxPpzKGc83WkRYzcAzJ1TeDgBPgpjvnyGkvgy4kT4Jt6w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, Mar 04, 2013 at 04:44:30PM +0100, Bastian Hecht wrote:
> Hi Simon!
> 
> 2013/3/4 Magnus Damm <magnus.damm@gmail.com>:
> > Hi Simon,
> >
> > [Added Guennadi to CC]
> >
> > On Sat, Mar 2, 2013 at 10:31 AM, Simon Horman <horms@verge.net.au> wrote:
> >> On Fri, Mar 01, 2013 at 10:21:27AM -0600, Bastian Hecht wrote:
> >>> 2013/3/1 Simon Horman <horms@verge.net.au>:
> >>> > On Tue, Feb 26, 2013 at 11:03:28AM -0600, Bastian Hecht wrote:
> >>> >> We can now use the Device Tree for bringing up our serial devices. We
> >>> >> need to add an alternative early_devices list in setup-r8a7740 without
> >>> >> the serial devices and move them into the Armadillo-reference .dts config file.
> >>> >
> >>> > Hi Bastian,
> >>> >
> >>> > could you please refresh this patch on top of the current topic/intc-of.
> >>> > In particular, it conflicts with changes made by:
> >>> >
> >>> > ARM: shmobile: r8a7740: Do not use early devices with DT reference
> >>>
> >>> Sure.
> >>>
> >>> I've prepared the patch - but I start to wonder if the DT
> >>> specification for the SCIF devices should go into r8a7740.dtsi rather
> >>> than r8a7740-armadillo-reference.dts. So far it's included in
> >>> setup-r8a7740.c and not in the board code - that's a strong indication
> >>> for it, no?
> >>
> >> I forget exactly how the discussion went, but for the kzm9g the
> >> SDHI has ended up in the dts file for the board not the sh73a0 SoC.
> >>
> >> So I assume that r8a7740-armadillo-reference.dts is the correct place
> >> for SDHI on the armadillo.
> >>
> >> Magnus, can you confirm that SDHI belongs to the board not the SoC?
> >
> > What does the data sheet say?
> >
> > The SDHI hardware block is included in the SoC. It may however need
> > some board specific configuration. I believe the correct way is to
> > define the common parts in the SoC-specific dtsi file and add
> > board-specific configuration in the board-specific dts file. Perhaps
> > you can consult Guennadi about this, he has been tasked with SDHI and
> > MMCIF.
> >
> >>> I want to post a patchset for the CMT timer soon. There it's the same.
> >>
> >> Magnus, could you also let us know if CMT should go in the board or SoC dts?
> >
> > In the SoC. As a general rule, if there is a platform device in
> > setup-nnnn.c then the device does not need any board specific
> > configuration. Such devices should be put in the SoC-specific dtsi
> > file.
> 
> Ok I posted a v4 SCIF DT patchset putting the SCIF devices into r8a7740.dtsi.
> 
> Simon, are you aware about this in topic/intc-of? It shows up booting
> the non-DT version.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000040
> pgd = c0004000
> [00000040] *pgd=00000000
> Internal error: Oops: 5 [#1] ARM
> CPU: 0    Not tainted  (3.8.0-rc3-00205-gfb2696a #298)
> PC is at __gpio_get_value+0x18/0x5c
> LR is at eva_init+0x190/0x544

Yes, I am aware of it, it is the reason that topic/intc-of is
not included in topic/all+next at the moment.

I believe it is caused by SH pinctl DT support.

http://permalink.gmane.org/gmane.linux.ports.sh.devel/19649


> We should add standard bootargs in the r8a7740-armadillo800eva.dts as
> well. Shall I post a small patch?

I have applied a patch to do that which should be present in v3.9-rc1.

Now that v3.9-rc1 has been released I will see about rebasing my
branches on top of it.
