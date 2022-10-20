Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15498C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 20 Oct 2022 12:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJTMe2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJTMe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Oct 2022 08:34:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E8CE0C
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2022 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666269262; x=1697805262;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/ZXnqBQzMCofXBmxuaHbS0XbO9aPZbS2fp4KbhvfkiY=;
  b=bOh17oodKos1A5cpAhjAUCW/cj1uGUAvR30ga4Q1/USEUFTOF3d3NGfz
   73zaSKMuziInHgLCOoDa/Ieyusg4D++mvwVuj4N7eFqGdlSrerJ623WLv
   5IVk4MHQ905R19XfsMjq5cR2scMRHl9kr6YQcAH7rnHi/sXS3yYKXOjWd
   YSJr53m8XwsLbojC1jo1nAwcFGKik2prPY+EJURopqVp8GvRP2/uulVpg
   Gby55tvq+y/YeMwE+byohTduA8XgxyAYws/x/JVEUbPOQ49meXireMvfX
   A59kd+zIvi3VNqO1eZJ86ZMQ6fKgE2IrAExwl6vU7aWw5D5FTPagQa/Tg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286411404"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="286411404"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 05:34:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="958904247"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="958904247"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 05:34:20 -0700
Date:   Thu, 20 Oct 2022 15:34:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] serial: 8250: allow use of non-runtime configured
 uart ports
In-Reply-To: <20221018133419.134110-1-martin@geanix.com>
Message-ID: <7baa90-e168-4bbe-5ce1-12c7de2ee04e@linux.intel.com>
References: <20221018133419.134110-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1688317086-1666269261=:1542"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1688317086-1666269261=:1542
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 18 Oct 2022, Martin Hundebøll wrote:

> The logic to find unused ports when registering new 8250 uart ports
> searches only up to CONFIG_SERIAL_8250_RUNTIME_UARTS, which forces users
> of external 8250 ports to increase the number of runtime ports
> artificially.
> 
> Fix this by initializing each allocated port structure with basic
> settings like line number and uart operation callbacks, and by searching
> the entire array of allocated ports to find an unused one.

So nr_uarts no longer means "Maximum number of UARTs supported." ?
Perhaps it should be reworded too.

-- 
 i.
 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 94fbf0add2ce..a166cc66e7d1 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -500,7 +500,7 @@ static void __init serial8250_isa_init_ports(void)
>  	if (nr_uarts > UART_NR)
>  		nr_uarts = UART_NR;
>  
> -	for (i = 0; i < nr_uarts; i++) {
> +	for (i = 0; i < UART_NR; i++) {
>  		struct uart_8250_port *up = &serial8250_ports[i];
>  		struct uart_port *port = &up->port;
>  
> @@ -926,15 +926,16 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
>  
>  	/* try line number first if still available */
>  	i = port->line;
> -	if (i < nr_uarts && serial8250_ports[i].port.type == PORT_UNKNOWN &&
> +	if (i < UART_NR && serial8250_ports[i].port.type == PORT_UNKNOWN &&
>  			serial8250_ports[i].port.iobase == 0)
>  		return &serial8250_ports[i];
> +
>  	/*
>  	 * We didn't find a matching entry, so look for the first
>  	 * free entry.  We look for one which hasn't been previously
>  	 * used (indicated by zero iobase).
>  	 */
> -	for (i = 0; i < nr_uarts; i++)
> +	for (i = 0; i < UART_NR; i++)
>  		if (serial8250_ports[i].port.type == PORT_UNKNOWN &&
>  		    serial8250_ports[i].port.iobase == 0)
>  			return &serial8250_ports[i];
> @@ -943,7 +944,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
>  	 * That also failed.  Last resort is to find any entry which
>  	 * doesn't have a real port associated with it.
>  	 */
> -	for (i = 0; i < nr_uarts; i++)
> +	for (i = 0; i < UART_NR; i++)
>  		if (serial8250_ports[i].port.type == PORT_UNKNOWN)
>  			return &serial8250_ports[i];
>  
> 

--8323329-1688317086-1666269261=:1542--
