From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to word accesses
Date: Thu, 18 Mar 2010 09:37:50 +1000
Message-ID: <1d3f23371003171637v7915321ep3ab60857641075d8@mail.gmail.com>
References: <e1a95faf-6907-4262-94bf-fa6808f7f098@SG2EHSMHS007.ehs.local>
	 <fa686aa41003170921g667edc2pcc2bf4eac592c089@mail.gmail.com>
	 <873097b0-5388-45b1-8483-3ef01bf8351f@SG2EHSMHS005.ehs.local>
	 <fa686aa41003171426p30588619h1240154ae0ba1664@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:53463 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab0CQXhy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 19:37:54 -0400
Received: by iwn12 with SMTP id 12so1328604iwn.21
        for <linux-serial@vger.kernel.org>; Wed, 17 Mar 2010 16:37:52 -0700 (PDT)
In-Reply-To: <fa686aa41003171426p30588619h1240154ae0ba1664@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: John Linn <John.Linn@xilinx.com>, John Linn <linnj@xilinx.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, michal.simek@petalogix.com

Sorry, resending after disabling HTML mode in gmail:

On Thu, Mar 18, 2010 at 7:26 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
>
> On Wed, Mar 17, 2010 at 12:04 PM, John Linn <John.Linn@xilinx.com> wr=
ote:
> >
> >
> >> -----Original Message-----
> >> From: John Linn
> >> Sent: Wednesday, March 17, 2010 10:27 AM
> >> To: 'Grant Likely'
> >> Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk; michal.simek@=
petalogix.com;
> >> john.williams@petalogix.com
> >> Subject: RE: [PATCH] [V3] uartlite: move from byte accesses to wor=
d accesses
> >>
> >> > -----Original Message-----
> >> > From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Beha=
lf Of Grant Likely
> >> > Sent: Wednesday, March 17, 2010 10:21 AM
> >> > To: John Linn
> >> > Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk; michal.sime=
k@petalogix.com;
> >> > john.williams@petalogix.com
> >> > Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to w=
ord accesses
> >> >
> >> > On Wed, Mar 17, 2010 at 9:40 AM, John Linn <john.linn@xilinx.com=
> wrote:
> >> > > Byte accesses for I/O devices in Xilinx IP is going to be less
> >> > > desired in the future such that the driver is being changed to
> >> > > use 32 bit accesses.
> >> > >
> >> > > This change facilitates using the uartlite IP over a PCIe bus
> >> > > which only allows 32 bit accesses.
> >> > >
> >> > > Signed-off-by: John Linn <john.linn@xilinx.com>
> >> > >
> >> > > ---
> >> > >
> >> > > V2 - updated the commit message based on Peter's comments
> >> > >
> >> > > V3 - removed u8 casting based on Peter's comments, cleaned up =
and
> >> > > simplified the change by using raw I/O functions rather than
> >> > > using in_be32 & out_be32 functions.
> >> >
> >> > The __raw_{read,write}l() functions aren't the best choice here.=
 =A0User
> >> > ioread32be(), iowrite32be() instead if you want them to work
> >> > cross-architecture (see include/asm-generic/iomap.h).
> >>
> >> Maybe the ioread functions will work better than the in/out_be32 a=
s they
> >> were not working like I wanted.
> >>
> >> I'm still trying to get my head wrapped around the right I/O funct=
ions to use since there are so many
> >> options.
> >>
> >> I'll look at your suggestions.
> >
> > That works ok on Powerpc, but not microblaze yet as there are still=
 patches in the process of going into the kernel for that.
> >
> > Do we need to wait til those patches are in?
>
> I'd make it broken in Kconfig on microblaze until those patches get
> merged. =A0To the best of my knowledge, the ioread/write routines are
> the best functions to use for cross-architecture MMIO code.

The MMIO patchset for MicroBlaze is in linux-next and Michal sent an
-rc2 pull request to Linus on 11th March.

Maybe I misunderstood Grant's meaning, but I think this uartlite
ioread/iowrite change must be conditional on the MicroBlaze MMIO
patchset being merged.  uartlite is a core driver for MicroBlaze and
it's not OK to break it just for an MMIO purity tweak!

Hopefully Linus will pull Michal's changes soon and this wil just
resolve itself.

John
--
John Williams
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com =A0p: +61-7-30090663 =A0f: +61-7-30090663
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
