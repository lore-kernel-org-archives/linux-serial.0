From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: fix device name
Date: Wed, 01 Sep 2010 10:46:03 +0900
Message-ID: <012b01cb4977$72adf4d0$5809de70$%kim@samsung.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
 <AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
 <4C5BAFF6.10606@gmail.com> <4C5BB462.6010409@samsung.com>
 <008701cb3538$54a12a00$fde37e00$%kim@samsung.com> <4C7B5838.7060605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46212 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0IABpz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Aug 2010 21:45:55 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L8100F5IOWFWCA0@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Wed, 01 Sep 2010 10:45:51 +0900 (KST)
Received: from kgenekim ([12.23.103.96])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L81000EHOWFFJ@mmp1.samsung.com> for
 linux-serial@vger.kernel.org; Wed, 01 Sep 2010 10:45:51 +0900 (KST)
In-reply-to: <4C7B5838.7060605@gmail.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Darius Augulis' <augulis.darius@gmail.com>
Cc: 'Joonyoung Shim' <jy0922.shim@samsung.com>, 'Paulius Zaleckas' <paulius.zaleckas@gmail.com>, 'Kyungmin Park' <kmpark@infradead.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Darius Augulis wrote:
> 
> Hi Kukjin,
> 
Hi ;-)

> please pick up this one to your tree too.
> 

As I still thinking, this should be handled by Ben Dooks.

And please refer to below Ben's comments about this.

> Thanks,
> 
> Darius.
> 
> On 08/06/2010 10:23 AM, Kukjin Kim wrote:
> > Joonyoung Shim wrote:
> >>
> >> On 8/6/2010 3:47 PM, Paulius Zaleckas wrote:
> >>> On 08/06/2010 03:04 AM, Kyungmin Park wrote:
> >>>> Hi,
> >>>>
> >>>> It's already posted by Mr. Shim
> >>>> http://marc.info/?l=linux-arm-kernel&m=127410047306149&w=2
> >>>
> >>> Darius patch is a little bit cleaner.
> >>>
> >>
> >> OK, it's better.
> >>
> >> Acked-by: Joonyoung Shim<jy0922.shim@samsung.com>
> >>
> >
> > Hi all,
> >
> > I think, this should be handled by Ben Dooks....
> > As Kyungmin Park said, there was his comment about this.
> >
> > This is just for your information....
> >
> > ===
> >
> > On Tue, May 18, 2010 at 12:52:13PM +0900, Joonyoung Shim wrote:
> >> On 5/18/2010 11:48 AM, Ben Dooks wrote:
> >>> On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
> >>>> Thd dev_name and driver_name should be switched each other.
> >>>
> >>> Hmm, this doesn't seem to have appeard on the linux-arm-kernel list
yet.
> >>>
> >>> Please provide some information about what problem that this is fixing
> >>> and the impact on any existing systems.
> >>>
> >>
> >> The serial device nodes are created to s3c2410_serial* on android
> >> platform instead of ttySAC*.
> >
> > This has been how they've been for ages, surely the android device node
> > creation sytstem supports symlinking /dev/SACx ->  /dev/s3c2410_serialx,
> > like many other operating sysyerms that can already do this.
> >
> > Changing this just because android (something as-yet unmerged into
mainline)
> > does not like it. I'm not even happy with an #ifdef around this.
> >
> > If you really feel this is a problem that you absolutely must fix in
kernel
> > then please provide a kernel commandline option to change the serial
driver
> > name and use that on any platform that needs it. Another way would be to
> > update the serial platform data to have a field for which name to
choose.
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

