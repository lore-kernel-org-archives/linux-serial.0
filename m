Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE34C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 17 Oct 2022 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJQM10 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJQM1Y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Oct 2022 08:27:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D2E481DD
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666009643; x=1697545643;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LLiTi1YJP90XvzR/ctjZhKQbNWMspP4F2F/BvPPX66k=;
  b=E8orLUYEwq0qpZHngfoZNoguNxScpI53EoqgOfDDsq1vSceogl1IBu1H
   ljTWWrX4cyDeDouC/o77dz+g/VXZzFX3NpI6y+H7aZc10IQpbjY9S+g0j
   bOlJIVjDzeQv1iep+/jymFiTfivE28aZpAEWJxCaIwDZWH1psazEnHuGt
   1NSj8PqMFMB0Iqv3LLxUcTUurClGKT/QWhMMYYhmMkJs1lSFti/kna2po
   Kqc8rahRVMKZqV6nKrsZVCJ+Tt2fHbcUavVqHyypo4Us9Ivt2FbMTcDnR
   yKqfq2sqL/ZpqbudecR0lX1i6qLLKlRXd8j5JNvUAKbv60GyDKrPNj4aa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305773405"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305773405"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:27:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="873448941"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="873448941"
Received: from ohoehne-mobl4.ger.corp.intel.com ([10.251.213.173])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 05:27:21 -0700
Date:   Mon, 17 Oct 2022 15:27:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        kernel@pengutronix.de,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: UART on MPC83xx in irq loop
In-Reply-To: <20221017094500.3wwd2njnao7rru4n@pengutronix.de>
Message-ID: <97de1514-ecd4-68ae-2e9a-d821cb1c7b22@linux.intel.com>
References: <20221017094500.3wwd2njnao7rru4n@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1711028773-1666009642=:5493"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1711028773-1666009642=:5493
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 17 Oct 2022, Uwe Kleine-König wrote:

> Hello,
> 
> I have a system based on MPC8313ERDB here that in some situations gets
> stuck in an irq loop. I have a reproducer here that works reliably. A
> workaround is:
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 45b8a59d937c..5ab32b6ba701 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2009,6 +2009,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  
>  	status = serial_port_in(port, UART_LSR);
>  
> +	/*
> +	 * Sometimes a "Character time-out" (IID3:0 == 0xc) happens on MPC8313,
> +	 * but LSR doesn't report "Data ready". To clear the former the receive
> +	 * buffer must be read. It's unclear if the char read is valid or not.
> +	 */
> +	if ((iir & UART_IIR_ID) == UART_IIR_RX_TIMEOUT)
> +		status |= UART_LSR_DR;
> +
>  	/*
>  	 * If port is stopped and there are no error conditions in the
>  	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
> 
> I havn't debugged that further than written in the comment but I wonder
> if this is a known issue (didn't find it in the errata though) and/or if
> someone with hardware knowledge could confirm this to be a hardware
> fault.
> 
> Without feedback from NXP I'd look in more detail into that to for
> example find out the timing and so maybe more hints about the hardware
> and a better SW workaround/fix.
> 
> Any input is very welcome.

I find it bit odd you seem to assume w/o any justification that the data 
would be valid (that workaround will read one byte and consider it 
valid, no?). According to the comments & workarounds to the same problem
(just look for IIR_RX_TIMEOUT and you'll find a few), they all do dummy 
reads rather than assume the data is valid.

-- 
 i.

--8323329-1711028773-1666009642=:5493--
