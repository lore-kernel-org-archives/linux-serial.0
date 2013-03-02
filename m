From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Sat, 2 Mar 2013 10:31:48 +0900
Message-ID: <20130302013147.GB3273@verge.net.au>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
 <1361898208-6683-3-git-send-email-hechtb+renesas@gmail.com>
 <20130301094205.GG27938@verge.net.au>
 <CABYn4syZJjDzuj2YqT3wCvnEuyE0Ab-8x=g1+_Fr9gw43_w_rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABYn4syZJjDzuj2YqT3wCvnEuyE0Ab-8x=g1+_Fr9gw43_w_rw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 01, 2013 at 10:21:27AM -0600, Bastian Hecht wrote:
> 2013/3/1 Simon Horman <horms@verge.net.au>:
> > On Tue, Feb 26, 2013 at 11:03:28AM -0600, Bastian Hecht wrote:
> >> We can now use the Device Tree for bringing up our serial devices. We
> >> need to add an alternative early_devices list in setup-r8a7740 without
> >> the serial devices and move them into the Armadillo-reference .dts config file.
> >
> > Hi Bastian,
> >
> > could you please refresh this patch on top of the current topic/intc-of.
> > In particular, it conflicts with changes made by:
> >
> > ARM: shmobile: r8a7740: Do not use early devices with DT reference
> 
> Sure.
> 
> I've prepared the patch - but I start to wonder if the DT
> specification for the SCIF devices should go into r8a7740.dtsi rather
> than r8a7740-armadillo-reference.dts. So far it's included in
> setup-r8a7740.c and not in the board code - that's a strong indication
> for it, no?

I forget exactly how the discussion went, but for the kzm9g the
SDHI has ended up in the dts file for the board not the sh73a0 SoC.

So I assume that r8a7740-armadillo-reference.dts is the correct place
for SDHI on the armadillo.

Magnus, can you confirm that SDHI belongs to the board not the SoC?

> I want to post a patchset for the CMT timer soon. There it's the same.

Magnus, could you also let us know if CMT should go in the board or SoC dts?
