From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250 check iir rdi in interrupt
Date: Tue, 30 Oct 2012 14:24:57 +0000
Message-ID: <20121030142457.00840d63@pyramind.ukuu.org.uk>
References: <alpine.LFD.2.02.1210221633450.28146@nightowl>
	<20121023110133.62bed522@pyramind.ukuu.org.uk>
	<CAJ0e-Fofs48N9VnYr1_8Kch6+yHjGx9iCWBRtRsqpD-B_rWutQ@mail.gmail.com>
	<20121026151902.0a382d16@pyramind.ukuu.org.uk>
	<CAJ0e-Fqzq6s6H=9CMpqJKug2=oR89_qw_52Yz-ihJd-8Bc-_+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59607 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab2J3OT5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Oct 2012 10:19:57 -0400
In-Reply-To: <CAJ0e-Fqzq6s6H=9CMpqJKug2=oR89_qw_52Yz-ihJd-8Bc-_+Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Min Zhang <mzhang@mvista.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 26 Oct 2012 14:57:31 -0700
Min Zhang <mzhang@mvista.com> wrote:

> On Fri, Oct 26, 2012 at 7:19 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > So we only need to check this in serial8250_handle_irq when IIR indicates
> > a data timeout interrupt ?
> >
> > Can we do
> >
> >         if ((iir & 0x0F) == 0x0C) {
> >                 /* Expensive RDI check */
> >         }
> >
> >
> >
> > Alan
> 
> Checking data timeout interrupt is only for "too much work for irq"
> problem. There is another console freeze problem which is caused by
> reading receive FIFO when there is no RDI interrupt, such as during
> THRI transmit interrupt, so no timeout interrupt. This time one has to
> check two both IIR and LSR. After all these checking, it becomes the
> original patch anyway.
> 
> I am posting another simpler revision to exclude timer handler from
> this workaround, and make this workaround default off and inline.

We have two problems one of which is understood. Your patch continues to
do an extra read in an absolutely critical hot path and one that on many
systems will cost upwards of 8uS.

Can we therefore work through this neatly one problem at a time ?

In addition it seems your patch causes data loss if your check triggers
and a character appears during the check, at which point I don't see what
stops your RX read from dropping a byte of real user data ?

Alan
