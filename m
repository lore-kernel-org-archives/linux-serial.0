From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to word accesses
Date: Wed, 17 Mar 2010 18:01:28 -0600
Message-ID: <fa686aa41003171701u1b6594f2n78ca22af640e5992@mail.gmail.com>
References: <e1a95faf-6907-4262-94bf-fa6808f7f098@SG2EHSMHS007.ehs.local>
	<fa686aa41003170921g667edc2pcc2bf4eac592c089@mail.gmail.com>
	<873097b0-5388-45b1-8483-3ef01bf8351f@SG2EHSMHS005.ehs.local>
	<fa686aa41003171426p30588619h1240154ae0ba1664@mail.gmail.com>
	<1d3f23371003171631x7e854ff6xd4f647b53b2dbe96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f201.google.com ([209.85.211.201]:47015 "EHLO
	mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0CRABt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 20:01:49 -0400
Received: by ywh39 with SMTP id 39so688664ywh.21
        for <linux-serial@vger.kernel.org>; Wed, 17 Mar 2010 17:01:48 -0700 (PDT)
In-Reply-To: <1d3f23371003171631x7e854ff6xd4f647b53b2dbe96@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Williams <john.williams@petalogix.com>
Cc: John Linn <John.Linn@xilinx.com>, John Linn <linnj@xilinx.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, michal.simek@petalogix.com

On Wed, Mar 17, 2010 at 5:31 PM, John Williams
<john.williams@petalogix.com> wrote:
>
>
> On Thu, Mar 18, 2010 at 7:26 AM, Grant Likely <grant.likely@secretlab=
=2Eca>
> wrote:
>>
>> On Wed, Mar 17, 2010 at 12:04 PM, John Linn <John.Linn@xilinx.com> w=
rote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: John Linn
>> >> Sent: Wednesday, March 17, 2010 10:27 AM
>> >> To: 'Grant Likely'
>> >> Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk;
>> >> michal.simek@petalogix.com;
>> >> john.williams@petalogix.com
>> >> Subject: RE: [PATCH] [V3] uartlite: move from byte accesses to wo=
rd
>> >> accesses
>> >>
>> >> > -----Original Message-----
>> >> > From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Beh=
alf Of
>> >> > Grant Likely
>> >> > Sent: Wednesday, March 17, 2010 10:21 AM
>> >> > To: John Linn
>> >> > Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk;
>> >> > michal.simek@petalogix.com;
>> >> > john.williams@petalogix.com
>> >> > Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to =
word
>> >> > accesses
>> >> >
>> >> > On Wed, Mar 17, 2010 at 9:40 AM, John Linn <john.linn@xilinx.co=
m>
>> >> > wrote:
>> >> > > Byte accesses for I/O devices in Xilinx IP is going to be les=
s
>> >> > > desired in the future such that the driver is being changed t=
o
>> >> > > use 32 bit accesses.
>> >> > >
>> >> > > This change facilitates using the uartlite IP over a PCIe bus
>> >> > > which only allows 32 bit accesses.
>> >> > >
>> >> > > Signed-off-by: John Linn <john.linn@xilinx.com>
>> >> > >
>> >> > > ---
>> >> > >
>> >> > > V2 - updated the commit message based on Peter's comments
>> >> > >
>> >> > > V3 - removed u8 casting based on Peter's comments, cleaned up=
 and
>> >> > > simplified the change by using raw I/O functions rather than
>> >> > > using in_be32 & out_be32 functions.
>> >> >
>> >> > The __raw_{read,write}l() functions aren't the best choice here=
=2E
>> >> > =A0User
>> >> > ioread32be(), iowrite32be() instead if you want them to work
>> >> > cross-architecture (see include/asm-generic/iomap.h).
>> >>
>> >> Maybe the ioread functions will work better than the in/out_be32 =
as
>> >> they
>> >> were not working like I wanted.
>> >>
>> >> I'm still trying to get my head wrapped around the right I/O func=
tions
>> >> to use since there are so many
>> >> options.
>> >>
>> >> I'll look at your suggestions.
>> >
>> > That works ok on Powerpc, but not microblaze yet as there are stil=
l
>> > patches in the process of going into the kernel for that.
>> >
>> > Do we need to wait til those patches are in?
>>
>> I'd make it broken in Kconfig on microblaze until those patches get
>> merged. =A0To the best of my knowledge, the ioread/write routines ar=
e
>> the best functions to use for cross-architecture MMIO code.
>
> The MMIO patchset for MicroBlaze is in linux-next and Michal sent an =
-rc2
> pull request to Linus on 11th March.
>
> Maybe I misunderstood Grant's meaning, but I think this uartlite
> ioread/iowrite change must be conditional on the MicroBlaze MMIO patc=
hset
> being merged.=A0 uartlite is a core driver for MicroBlaze and it's no=
t OK to
> break it just for an MMIO purity tweak!

Of course you're right.  I was getting confused with the ll_temac
driver change.  Sorry.

> Hopefully Linus will pull Michal's changes soon and this wil just res=
olve
> itself.

Yeah, just wait for Michal's pull req to get processed before
respinning the patch.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
