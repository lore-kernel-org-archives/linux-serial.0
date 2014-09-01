From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 5/6] ARM: shmobile: r8a7794: document SCIF clock support
Date: Mon, 01 Sep 2014 14:59:46 -0700
Message-ID: <20140901215946.5251.96347@quantum>
References: <1409336110-32734-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1409336110-32734-6-git-send-email-ulrich.hecht+renesas@gmail.com>
 <20140901013042.GH32075@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:53915 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbaIAV75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Sep 2014 17:59:57 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so6937649pdj.35
        for <linux-serial@vger.kernel.org>; Mon, 01 Sep 2014 14:59:57 -0700 (PDT)
In-Reply-To: <20140901013042.GH32075@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Quoting Simon Horman (2014-08-31 18:30:42)
> Hi Ulrich,
> 
> please repost this patch with the following recipients added
> (both CCed on this email):
> 
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> 
> I am also sure that Mike Turquette would not mind being dropped from
> the CC list.

Yeah, I don't really care about DT binding updates ;-)

Regards,
Mike

> 
> Please also include:
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> On Fri, Aug 29, 2014 at 08:15:09PM +0200, Ulrich Hecht wrote:
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > index b355660..7b87eb2 100644
> > --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > @@ -20,6 +20,10 @@ Required properties:
> >      - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
> >      - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
> >      - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
> > +    - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
> > +    - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
> > +    - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
> > +    - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
> >      - "renesas,scif" for generic SCIF compatible UART.
> >      - "renesas,scifa" for generic SCIFA compatible UART.
> >      - "renesas,scifb" for generic SCIFB compatible UART.
> > -- 
> > 1.8.4.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
