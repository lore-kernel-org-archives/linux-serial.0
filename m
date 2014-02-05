From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/2] serial: sh-sci: Fix cast warning
Date: Wed, 05 Feb 2014 09:42:12 +0900
Message-ID: <000701cf220b$1bf242c0$53d6c840$%han@samsung.com>
References: <000501cf2176$1e733d00$5b59b700$%han@samsung.com>
 <1770030.4nuhDBK3mM@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:9469 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaBEAmP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Feb 2014 19:42:15 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0H005W3ZAC4Z50@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Wed, 05 Feb 2014 09:42:12 +0900 (KST)
In-reply-to: <1770030.4nuhDBK3mM@avalon>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Simon Horman' <horms+renesas@verge.net.au>, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, February 05, 2014 7:09 AM, Laurent Pinchart wrote:
> 
> Hi Jingoo,
> 
> Thank you for the patch.
> 
> On Tuesday 04 February 2014 15:55:41 Jingoo Han wrote:
> > Fix the following compile warning about cast to pointer from
> > integer of different size.
> >
> > drivers/tty/serial/sh-sci.c:2021:19: warning: cast to pointer from integer
> > of different size [-Wint-to-pointer-cast]
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/tty/serial/sh-sci.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index be33d2b..61729d4 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2018,7 +2018,7 @@ static int sci_remap_port(struct uart_port *port)
> >  		 * need to do any remapping, just cast the cookie
> >  		 * directly.
> >  		 */
> > -		port->membase = (void __iomem *)port->mapbase;
> > +		port->membase = (void __iomem *)(unsigned long)port->mapbase;
> 
> What about casting to uintptr_t instead of unsigned long ?

OK, I see.
I will use it and send v2 patch, soon.
I really appreciate your comment. :-)
Thank you.

Best regards,
Jingoo Han

