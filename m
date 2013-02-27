From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] serial: ifx6x60: add missing variable initialization
Date: Wed, 27 Feb 2013 19:20:07 +0900
Message-ID: <001d01ce14d4$046ce230$0d46a690$%han@samsung.com>
References: <008e01ce14a7$c1406580$43c13080$%han@samsung.com>
 <512DD785.5050001@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29178 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab3B0KUJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Feb 2013 05:20:09 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIV00026JDKR1T0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Wed, 27 Feb 2013 19:20:08 +0900 (KST)
In-reply-to: <512DD785.5050001@suse.cz>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Jiri Slaby' <jslaby@suse.cz>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Chen Jun' <jun.d.chen@intel.com>

On Wednesday, February 27, 2013 6:53 PM, Jiri Slaby wrote:
> 
> On 02/27/2013 06:03 AM, Jingoo Han wrote:
> > Fixed build warning as below:
> >
> > drivers/tty/serial/ifx6x60.c:753:8: warning: 'more' may be used uninitialized in this function [-
> Wuninitialized]
> 
> This needs some more investigation and explanation than that. Are you
> fixing a real compiler warning or hiding a bug here?

Sorry, I don't have the deep knowledge about ifx6x60.
I just want to remove build warning.

Maybe, Chen Jun or other guy will resolve this warning properly.

Please, abandon this patch.

> 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/tty/serial/ifx6x60.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
> > index 68d7ce9..3d78baf 100644
> > --- a/drivers/tty/serial/ifx6x60.c
> > +++ b/drivers/tty/serial/ifx6x60.c
> > @@ -687,7 +687,7 @@ static void ifx_spi_complete(void *ctx)
> >  	struct tty_ldisc *ldisc = NULL;
> >  	int length;
> >  	int actual_length;
> > -	unsigned char more;
> > +	unsigned char more = 0;
> >  	unsigned char cts;
> >  	int local_write_pending = 0;
> >  	int queue_length;
> >
> 
> 
> --
> js
> suse labs

