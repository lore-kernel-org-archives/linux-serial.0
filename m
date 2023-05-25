Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88767C77B7E
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 07:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbjEYHfD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 03:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbjEYHey (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 03:34:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379A8189
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685000093; x=1716536093;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iMQHTLRVP7iOL6bxIqX1eJvzadZFQXxU/WGdbz194fE=;
  b=QCfO/x62IbcXB+3zbN6zfyqbTq83DtarfNSDkJXvFG7Roiq/5F1DGKBL
   5Y9bLtijxRVmqW4qh8tkIadzUIEs2bqRD5xIoJWi6tti3MRpXDTLNPPrA
   E8t9U8b9+TfLxNHnesMlEcl6vLsZ1uKWMb1zRmzMIPr12K1o/K/IvFIj9
   8leXbrA53xex8QZGnvyuQ8xc/+bjXDzouwVgLT16HIns/eQqfJjCA4K4h
   prRuN80do/hxmQ0kaU1gE2ZY1TVbYDglpgpgPygyVb81ncAWv2QZcgwih
   Hvu+pbCu/XYPdBHtGNHAHxZlVGc0Nr4Dm2VfEyYUxuIpBJDDP2dN6CikI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="334163012"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="334163012"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951354252"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="951354252"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:33:40 -0700
Date:   Thu, 25 May 2023 10:33:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/3] serial: 8250: Clear IIR.RDI in
 serial8250_clear_fifos()
In-Reply-To: <20230524143654.dfkbo22vdpc73nqs@pengutronix.de>
Message-ID: <33e6bb80-6e31-a9d-9f9c-6af74822e885@linux.intel.com>
References: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de> <20230524122754.481816-3-u.kleine-koenig@pengutronix.de> <576799f0-1d18-c9ed-bf12-cb2bed1f8bb@linux.intel.com> <20230524143654.dfkbo22vdpc73nqs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1183645628-1685000022=:1738"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1183645628-1685000022=:1738
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 24 May 2023, Uwe Kleine-König wrote:

> On Wed, May 24, 2023 at 04:02:58PM +0300, Ilpo Järvinen wrote:
> > On Wed, 24 May 2023, Uwe Kleine-König wrote:
> > 
> > > At least on MPC83xx (but I suspect also on other implementations) it can
> > > happen that after irqs are disabled but before the FIFOs are cleared a
> > > character is received. Resetting the FIFO throws away that character,
> > > but doesn't clear the IIR.RDI event that signals that there is read data
> > > available.
> > > 
> > > Read from RX to clear IIR.RDI and throw away the result.
> > > 
> > > This fixes a infinite loop after the above described race happened: The
> > > irq handler (here: fsl8250_handle_irq()) triggers, but LSR.DR isn't set,
> > > so RX isn't read and the irq handler returns just to be called again.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/tty/serial/8250/8250_port.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index fe8d79c4ae95..8b47ec000922 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -556,6 +556,18 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
> > >  		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
> > >  			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> > >  		serial_out(p, UART_FCR, 0);
> > > +
> > > +		/*
> > > +		 * When doing rs485 on MPC8313 it can happen that in the short
> > > +		 * window when switching from RX to TX there is a character in
> > > +		 * the RX FIFO which isn't processed any more and then discarded
> > > +		 * in here by clearing the FIFO. In that case IIR signals an RX
> > > +		 * timeout once irqs are reenabled (i.e. in
> > > +		 * serial8250_em485_stop_tx()) but LSR shows no pending event.
> > > +		 * The RX timeout event can only be cleared by reading RX. Do
> > > +		 * this here before reenabling the FIFO and irqs.
> > > +		 */
> > > +		serial_port_in(&p->port, UART_RX);
> > >  	}
> > >  }
> > 
> > This solution has too wide impact, I think.
> 
> What is the impact? After the FIFO is reset reading the RX register
> shouldn't matter?
> 
> > It should be made driver specific.
> 
> I'm not a big fan, the 8250 driver is already very fragmented.
> 
> > Can't you read IIR to see if the event indication is there before
> > doing this UART_RX read?
> 
> Assuming reading IIR and reading RX take approx the same amount of
> time, I don't see an upside of checking IIR first?!
> 
> > Maybe add an UART specific function for fifo clearing/reset.
> 
> See above. And with the theory that reading RX doesn't hurt after the
> FIFO was just cleared, adding this to generic code has the upside that
> other variants that might have the same issue get fixed, too.

See e.g. 4f4e670342b14f302e17c93bd22fc943bbaaf1de. I guess you could argue 
since FIFO is not just cleared at that point but also disabled it won't 
trigger that particular problem but I'd prefer to not depend on that given 
I'd want moving into the direction where the unnecessary looking FIFO 
disable does not occur (as was discussed below).

> > I've long wondered this related thing:
> > 
> > Does anyone have idea why serial8250_clear_and_reinit_fifos() and 
> > serial8250_clear_fifos() are separate, what is the benefit of not setting 
> > FCR back to up->fcr? That is that intermediate FCR <= 0 really required 
> > for the FIFO reset sequence or is it just an artifact of how the code is 
> > structured into those two functions.
> > 
> > It might make sense to drop serial8250_clear_and_reinit_fifos() and 
> > change serial8250_clear_fifos() into something like this (depending on 
> > the answers):
> > 
> > static void serial8250_clear_fifos(struct uart_8250_port *p, bool disable)
> > {
> >         if (p->capabilities & UART_CAP_FIFO) {
> >                 serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
> >                 serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
> >                                UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
> > 	        serial_out(p, UART_FCR, disable ? 0 : p->fcr);
> >         }
> > }
> 
> I'd say this should work. Apart from skipping
> 
> 	serial_out(p, UART_FCR, 0);
> 
> it has the side effect of skipping
> 
> 	serial_out(p, UART_FCR, p->fcr);
> 
> if !(p->capabilities & UART_CAP_FIFO). That shouldn't matter though.

Yes, but I'd expect clear fifos to be no-op when FIFO is not enabled so 
it's better IMHO.

Thanks foy your thoughts on this. Maybe I'll spend the time to dig through 
all the related history about it to see if there's something interesting 
to find.


-- 
 i.

--8323329-1183645628-1685000022=:1738--
