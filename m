Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9DDC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADDA60F56
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhJOL1x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 07:27:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:9682 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhJOL1x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 07:27:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="215060250"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="215060250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 04:25:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="481664216"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 04:25:45 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mbO9L-000PsO-BK;
        Fri, 15 Oct 2021 17:25:31 +0300
Date:   Fri, 15 Oct 2021 17:25:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] serial: 8250_dw: drop bogus uartclk optimisation
Message-ID: <YWmPW5Yg0X8Kcck9@smile.fi.intel.com>
References: <20211015111422.1027-1-johan@kernel.org>
 <20211015111422.1027-4-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015111422.1027-4-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 15, 2021 at 01:14:22PM +0200, Johan Hovold wrote:
> The driver was updating the port uartclk before setting the new rate in
> an attempt to avoid having the clock notifier redundantly update the
> divisors.
> 
> The set_termios() callback is however called under the termios semaphore
> and tty-port mutex so the worker scheduled by the clock notifier will
> block in serial8250_update_uartclk() until the uartclk and divisors have
> been updated anyway.
> 
> Drop the unnecessary swaps and incorrect comment and simply update the
> uartclk field if the clock-rate change was successful.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a3a0154da567..52e03dd0eb3b 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -338,15 +338,12 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>  	rate = clk_round_rate(d->clk, newrate);
>  	if (rate > 0) {
>  		/*
> -		 * Premilinary set the uartclk to the new clock rate so the
> -		 * clock update event handler caused by the clk_set_rate()
> -		 * calling wouldn't actually update the UART divisor since
> -		 * we about to do this anyway.
> +		 * Note that any clock-notifer worker will block in
> +		 * serial8250_update_uartclk() until we are done.
>  		 */
> -		swap(p->uartclk, rate);
>  		ret = clk_set_rate(d->clk, newrate);
> -		if (ret)
> -			swap(p->uartclk, rate);
> +		if (!ret)
> +			p->uartclk = rate;
>  	}
>  	clk_prepare_enable(d->clk);
>  
> -- 
> 2.32.0
> 

-- 
With Best Regards,
Andy Shevchenko


