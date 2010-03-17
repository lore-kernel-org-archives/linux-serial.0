From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to word accesses
Date: Wed, 17 Mar 2010 15:26:31 -0600
Message-ID: <fa686aa41003171426p30588619h1240154ae0ba1664@mail.gmail.com>
References: <e1a95faf-6907-4262-94bf-fa6808f7f098@SG2EHSMHS007.ehs.local>
	<fa686aa41003170921g667edc2pcc2bf4eac592c089@mail.gmail.com>
	<873097b0-5388-45b1-8483-3ef01bf8351f@SG2EHSMHS005.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f201.google.com ([209.85.211.201]:44516 "EHLO
	mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab0CQV0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 17:26:52 -0400
Received: by ywh39 with SMTP id 39so618406ywh.21
        for <linux-serial@vger.kernel.org>; Wed, 17 Mar 2010 14:26:51 -0700 (PDT)
In-Reply-To: <873097b0-5388-45b1-8483-3ef01bf8351f@SG2EHSMHS005.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: John Linn <linnj@xilinx.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, michal.simek@petalogix.com, john.williams@petalogix.com

On Wed, Mar 17, 2010 at 12:04 PM, John Linn <John.Linn@xilinx.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: John Linn
>> Sent: Wednesday, March 17, 2010 10:27 AM
>> To: 'Grant Likely'
>> Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk; michal.simek@pe=
talogix.com;
>> john.williams@petalogix.com
>> Subject: RE: [PATCH] [V3] uartlite: move from byte accesses to word =
accesses
>>
>> > -----Original Message-----
>> > From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf=
 Of Grant Likely
>> > Sent: Wednesday, March 17, 2010 10:21 AM
>> > To: John Linn
>> > Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk; michal.simek@=
petalogix.com;
>> > john.williams@petalogix.com
>> > Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to wor=
d accesses
>> >
>> > On Wed, Mar 17, 2010 at 9:40 AM, John Linn <john.linn@xilinx.com> =
wrote:
>> > > Byte accesses for I/O devices in Xilinx IP is going to be less
>> > > desired in the future such that the driver is being changed to
>> > > use 32 bit accesses.
>> > >
>> > > This change facilitates using the uartlite IP over a PCIe bus
>> > > which only allows 32 bit accesses.
>> > >
>> > > Signed-off-by: John Linn <john.linn@xilinx.com>
>> > >
>> > > ---
>> > >
>> > > V2 - updated the commit message based on Peter's comments
>> > >
>> > > V3 - removed u8 casting based on Peter's comments, cleaned up an=
d
>> > > simplified the change by using raw I/O functions rather than
>> > > using in_be32 & out_be32 functions.
>> >
>> > The __raw_{read,write}l() functions aren't the best choice here. =A0=
User
>> > ioread32be(), iowrite32be() instead if you want them to work
>> > cross-architecture (see include/asm-generic/iomap.h).
>>
>> Maybe the ioread functions will work better than the in/out_be32 as =
they
>> were not working like I wanted.
>>
>> I'm still trying to get my head wrapped around the right I/O functio=
ns to use since there are so many
>> options.
>>
>> I'll look at your suggestions.
>
> That works ok on Powerpc, but not microblaze yet as there are still p=
atches in the process of going into the kernel for that.
>
> Do we need to wait til those patches are in?

I'd make it broken in Kconfig on microblaze until those patches get
merged.  To the best of my knowledge, the ioread/write routines are
the best functions to use for cross-architecture MMIO code.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
