From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: fix device name
Date: Fri, 06 Aug 2010 16:23:51 +0900
Message-ID: <008701cb3538$54a12a00$fde37e00$%kim@samsung.com>
References: <20100805201000.14030.34703.stgit@darius-desktop>
 <AANLkTikp2ThBqF2jkU4CXS9-iYRoy3AWpeqWXjmLF6Gd@mail.gmail.com>
 <4C5BAFF6.10606@gmail.com> <4C5BB462.6010409@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61020 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab0HFHXp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Aug 2010 03:23:45 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L6P0010CZ7JLIA0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 06 Aug 2010 16:23:43 +0900 (KST)
Received: from kgenekim ([12.23.103.96])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L6P009MBZ7J58@mmp2.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 06 Aug 2010 16:23:43 +0900 (KST)
In-reply-to: <4C5BB462.6010409@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Joonyoung Shim' <jy0922.shim@samsung.com>, 'Paulius Zaleckas' <paulius.zaleckas@gmail.com>
Cc: 'Darius Augulis' <augulis.darius@gmail.com>, 'Kyungmin Park' <kmpark@infradead.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Joonyoung Shim wrote:
> 
> On 8/6/2010 3:47 PM, Paulius Zaleckas wrote:
> > On 08/06/2010 03:04 AM, Kyungmin Park wrote:
> >> Hi,
> >>
> >> It's already posted by Mr. Shim
> >> http://marc.info/?l=linux-arm-kernel&m=127410047306149&w=2
> >
> > Darius patch is a little bit cleaner.
> >
> 
> OK, it's better.
> 
> Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>
> 

Hi all,

I think, this should be handled by Ben Dooks....
As Kyungmin Park said, there was his comment about this.

This is just for your information....

===

On Tue, May 18, 2010 at 12:52:13PM +0900, Joonyoung Shim wrote:
> On 5/18/2010 11:48 AM, Ben Dooks wrote:
> > On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
> >> Thd dev_name and driver_name should be switched each other.
> > 
> > Hmm, this doesn't seem to have appeard on the linux-arm-kernel list yet.
> >  
> > Please provide some information about what problem that this is fixing
> > and the impact on any existing systems.
> > 
> 
> The serial device nodes are created to s3c2410_serial* on android 
> platform instead of ttySAC*.

This has been how they've been for ages, surely the android device node
creation sytstem supports symlinking /dev/SACx -> /dev/s3c2410_serialx,
like many other operating sysyerms that can already do this.

Changing this just because android (something as-yet unmerged into mainline)
does not like it. I'm not even happy with an #ifdef around this.

If you really feel this is a problem that you absolutely must fix in kernel
then please provide a kernel commandline option to change the serial driver
name and use that on any platform that needs it. Another way would be to
update the serial platform data to have a field for which name to choose.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

===


> >> As discussed with Ben. even though it's right patch, there's some
> >> users to use previous interface.
> >> I also think it will be fixed. but need to coordinate with existing
> >> users.
> >
> > IMO this is obvious bug fix.
> >
> > Acked-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> >
> >> Ben, how to you think?
> >>
> >> On Fri, Aug 6, 2010 at 5:10 AM, Darius
> >> Augulis<augulis.darius@gmail.com>  wrote:
> >>> Swap device and driver names in serial/samsung.c
> >>>
> >>> Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
> >>> ---
> >>>   drivers/serial/samsung.c |    4 ++--
> >>>   1 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> >>> index a9d6c56..9d63f24 100644
> >>> --- a/drivers/serial/samsung.c
> >>> +++ b/drivers/serial/samsung.c
> >>> @@ -878,10 +878,10 @@ static struct uart_ops s3c24xx_serial_ops = {
> >>>
> >>>   static struct uart_driver s3c24xx_uart_drv = {
> >>>         .owner          = THIS_MODULE,
> >>> -       .dev_name       = "s3c2410_serial",
> >>> +       .driver_name    = "s3c2410_serial",
> >>>         .nr             = CONFIG_SERIAL_SAMSUNG_UARTS,
> >>>         .cons           = S3C24XX_SERIAL_CONSOLE,
> >>> -       .driver_name    = S3C24XX_SERIAL_NAME,
> >>> +       .dev_name       = S3C24XX_SERIAL_NAME,
> >>>         .major          = S3C24XX_SERIAL_MAJOR,
> >>>         .minor          = S3C24XX_SERIAL_MINOR,
> >>>   };
> >>>
> >>>


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

