From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH 05/13] serial: omap: drop DMA support
Date: Tue, 21 Aug 2012 16:05:22 +0530
Message-ID: <CAMQu2gyGVhB63rn+G6B3nFLki5ib40C_2o2Bh1mBd8sw8wT_Ng@mail.gmail.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345540555-24359-6-git-send-email-balbi@ti.com> <CAMQu2gw93ES=u9J1FfWK_CKkgUq8V487+tmKtQ34p8O7VJ6aHA@mail.gmail.com>
 <20120821102045.GL10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:45420 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756353Ab2HUKfo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Aug 2012 06:35:44 -0400
Received: by ialo24 with SMTP id o24so4156001ial.5
        for <linux-serial@vger.kernel.org>; Tue, 21 Aug 2012 03:35:43 -0700 (PDT)
In-Reply-To: <20120821102045.GL10347@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: balbi@ti.com
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>

On Tue, Aug 21, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Aug 21, 2012 at 03:14:19PM +0530, Shilimkar, Santosh wrote:
>> On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > The current support is known to be broken and
>> > a later patch will come re-adding it using
>> > dma engine API.
>> >
>> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > ---
>> Thanks Felipe !!
>
> no problem.
>
>> One less driver now towards OMAP DMA
>> engine conversion.
>
> indeed :-) I'll take a closer look into rx timeout IRQ, but it looks
> like we can use it to kick dma only for "big" transfers... need to play
> with it for a while first, though.
>
Yep. The RX path with DMA is bit of difficult part to manage for
UART.

>> FWIW,
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> is this Ack for this patch only or the entire series ??
>
Two more patches to review and then I will do it for
full series on top of the cover-letter :-)

Regards
Santosh
