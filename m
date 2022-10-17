Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB37C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 17 Oct 2022 14:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJQOR7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Oct 2022 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJQOR6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Oct 2022 10:17:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF28642E6
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666016277; x=1697552277;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+daT08ZSw04e4Wrwn3hvD/1TTPWvhOSwqgZN6OFfIyI=;
  b=bGmsKTa21n741yn2PX7gtCnnCIYiF9kMflf+Lj7jwHD7mcY2uYsTZEcX
   JU0FhG4Hexp5y17NayxPvJ54eMIHmUUrtS7+ILvyCr9cBaZbIS7myLdi1
   Ea8ouUswraotTky7FmqBoVBHYZ2iMdpjHzWaTztE2A6GqhZnbUBytXYSf
   0vLrbsspIg3nL89A3rL79dZfT0I1ROYDM0+TBcDgzqJUeVMxl09RPhOoV
   Ctnzh9FEU3YnMuzWNqi48gPpI7q+mlZVz/S9WC8U5WnkmqQQO7dPArHfK
   aNBcPMo0a8mMKfN2rHPxqUtiZ5kMMErjUYLVL5ALbSrY9JV0EFD1KJ/Jt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307464470"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="307464470"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 07:17:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="659363812"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="659363812"
Received: from ohoehne-mobl4.ger.corp.intel.com ([10.251.213.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 07:17:55 -0700
Date:   Mon, 17 Oct 2022 17:17:53 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     kernel@pengutronix.de,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: UART on MPC83xx in irq loop
In-Reply-To: <20221017141142.2otrfh5y3afosdvq@pengutronix.de>
Message-ID: <391cd1f3-f8f6-5c47-933b-fd3e2992bf78@linux.intel.com>
References: <20221017094500.3wwd2njnao7rru4n@pengutronix.de> <97de1514-ecd4-68ae-2e9a-d821cb1c7b22@linux.intel.com> <20221017141142.2otrfh5y3afosdvq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1787985329-1666016276=:5493"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1787985329-1666016276=:5493
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 17 Oct 2022, Uwe Kleine-König wrote:

> On Mon, Oct 17, 2022 at 03:27:19PM +0300, Ilpo Järvinen wrote:
> > On Mon, 17 Oct 2022, Uwe Kleine-König wrote:
> > 
> > > Hello,
> > > 
> > > I have a system based on MPC8313ERDB here that in some situations gets
> > > stuck in an irq loop. I have a reproducer here that works reliably. A
> > > workaround is:
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index 45b8a59d937c..5ab32b6ba701 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -2009,6 +2009,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
> > >  
> > >  	status = serial_port_in(port, UART_LSR);
> > >  
> > > +	/*
> > > +	 * Sometimes a "Character time-out" (IID3:0 == 0xc) happens on MPC8313,
> > > +	 * but LSR doesn't report "Data ready". To clear the former the receive
> > > +	 * buffer must be read. It's unclear if the char read is valid or not.
> > > +	 */
> > > +	if ((iir & UART_IIR_ID) == UART_IIR_RX_TIMEOUT)
> > > +		status |= UART_LSR_DR;
> > > +
> > >  	/*
> > >  	 * If port is stopped and there are no error conditions in the
> > >  	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
> > > 
> > > I havn't debugged that further than written in the comment but I wonder
> > > if this is a known issue (didn't find it in the errata though) and/or if
> > > someone with hardware knowledge could confirm this to be a hardware
> > > fault.
> > > 
> > > Without feedback from NXP I'd look in more detail into that to for
> > > example find out the timing and so maybe more hints about the hardware
> > > and a better SW workaround/fix.
> > > 
> > > Any input is very welcome.
> > 
> > I find it bit odd you seem to assume w/o any justification that the data 
> > would be valid (that workaround will read one byte and consider it 
> > valid, no?). According to the comments & workarounds to the same problem
> > (just look for IIR_RX_TIMEOUT and you'll find a few), they all do dummy 
> > reads rather than assume the data is valid.
> 
> AFAICT the irq doesn't stop being pending without the read.

At least the comment in 8250_dw says it has similar irq loop behavior if
nothing is read when IIR_RX_TIMEOUT is seen w/o DR. The others 
IIR_RX_TIMEOUT comments don't state it so it could be either way (but if 
I'd hazard a guess w/o history dig, they'll probably irq loop as well).

> But yes,
> there are some details to research/explain, for example what is read
> from the data register and if this byte is valid or not.
>
> Also without status having the DR (or BI) bit set, UART_IIR_RX_TIMEOUT
> doesn't kick in?!

I didn't understand what you were trying to ask/note here.

-- 
 i.

--8323329-1787985329-1666016276=:5493--
