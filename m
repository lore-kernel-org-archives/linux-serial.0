Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB120C7EE37
	for <linux-serial@archiver.kernel.org>; Wed, 24 May 2023 13:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjEXND7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjEXNDj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 09:03:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC87E78
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684933403; x=1716469403;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ADEutKuV3lnnJJ/9v/jr0Hz/n8O6739gQJ74ct3R6Wg=;
  b=oAv580thxzWoNcYb4DTS2alCOfid77gKvzuy9AZpjR7tPiLOIIhz6ICs
   iNLPfyv4YU1CN/gINRPot2sTVM4nJKt32wZXwc1zVXZsW8xf2gEdFhHNx
   aoY6c8AesIvSP6XlUrxNiEVvMt+Zey1sWl89v74ggoVIiBDDsk37LnJks
   z8SJPKzJhVX1rLaj4l3iFncFa0OqdXyEo6Z8etChV/afxJn0rsCSN9fH6
   V0mjMfmNo65Jo02FmEDmxydmz1nWcW+AjbbVyLQd+GzqWXucG20cPrkps
   Lt81aoeKfTrLGhv0DweufdtdeoeVbxqf4L/VyoxqHGbI0KcVdJ3//Spj4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="333179115"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="333179115"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 06:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704339794"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704339794"
Received: from nwhelanx-mobl.ger.corp.intel.com ([10.252.55.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 06:03:00 -0700
Date:   Wed, 24 May 2023 16:02:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/3] serial: 8250: Clear IIR.RDI in
 serial8250_clear_fifos()
In-Reply-To: <20230524122754.481816-3-u.kleine-koenig@pengutronix.de>
Message-ID: <576799f0-1d18-c9ed-bf12-cb2bed1f8bb@linux.intel.com>
References: <20230524122754.481816-1-u.kleine-koenig@pengutronix.de> <20230524122754.481816-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1387683600-1684932196=:1739"
Content-ID: <e052ad95-6e4-fc7-f419-1fbe7dfd0d2@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1387683600-1684932196=:1739
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <adfa32-9a11-7b15-1e8b-13a393e6f273@linux.intel.com>

On Wed, 24 May 2023, Uwe Kleine-König wrote:

> At least on MPC83xx (but I suspect also on other implementations) it can
> happen that after irqs are disabled but before the FIFOs are cleared a
> character is received. Resetting the FIFO throws away that character,
> but doesn't clear the IIR.RDI event that signals that there is read data
> available.
> 
> Read from RX to clear IIR.RDI and throw away the result.
> 
> This fixes a infinite loop after the above described race happened: The
> irq handler (here: fsl8250_handle_irq()) triggers, but LSR.DR isn't set,
> so RX isn't read and the irq handler returns just to be called again.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_port.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index fe8d79c4ae95..8b47ec000922 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -556,6 +556,18 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
>  		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
>  			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
>  		serial_out(p, UART_FCR, 0);
> +
> +		/*
> +		 * When doing rs485 on MPC8313 it can happen that in the short
> +		 * window when switching from RX to TX there is a character in
> +		 * the RX FIFO which isn't processed any more and then discarded
> +		 * in here by clearing the FIFO. In that case IIR signals an RX
> +		 * timeout once irqs are reenabled (i.e. in
> +		 * serial8250_em485_stop_tx()) but LSR shows no pending event.
> +		 * The RX timeout event can only be cleared by reading RX. Do
> +		 * this here before reenabling the FIFO and irqs.
> +		 */
> +		serial_port_in(&p->port, UART_RX);
>  	}
>  }

This solution has too wide impact, I think. It should be made driver 
specific. Can't you read IIR to see if the event indication is there 
before doing this UART_RX read? Maybe add an UART specific function for 
fifo clearing/reset.

I've long wondered this related thing:

Does anyone have idea why serial8250_clear_and_reinit_fifos() and 
serial8250_clear_fifos() are separate, what is the benefit of not setting 
FCR back to up->fcr? That is that intermediate FCR <= 0 really required 
for the FIFO reset sequence or is it just an artifact of how the code is 
structured into those two functions.

It might make sense to drop serial8250_clear_and_reinit_fifos() and 
change serial8250_clear_fifos() into something like this (depending on 
the answers):

static void serial8250_clear_fifos(struct uart_8250_port *p, bool disable)
{
        if (p->capabilities & UART_CAP_FIFO) {
                serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
                serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
                               UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
	        serial_out(p, UART_FCR, disable ? 0 : p->fcr);
        }
}


-- 
 i.
--8323329-1387683600-1684932196=:1739--
