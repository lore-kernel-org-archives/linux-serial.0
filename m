Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E36DC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38B960F56
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 11:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhJOL0m (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 07:26:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:25628 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238470AbhJOL0k (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 07:26:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="208010932"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="208010932"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 04:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="592952752"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 04:24:28 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mbO86-000PrZ-NT;
        Fri, 15 Oct 2021 17:24:14 +0300
Date:   Fri, 15 Oct 2021 17:24:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: 8250: rename unlock labels
Message-ID: <YWmPDhj+x2E6XkYC@smile.fi.intel.com>
References: <20211015111422.1027-1-johan@kernel.org>
 <20211015111422.1027-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015111422.1027-3-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 15, 2021 at 01:14:21PM +0200, Johan Hovold wrote:
> Rename a couple of oddly named labels that are used to unlock before
> returning after what they do (rather than after the context they are
> used in) to improve readability.

I'm on the same page with the label naming schema, hence
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e4dd82fd7c2a..5775cbff8f6e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1338,7 +1338,7 @@ static void autoconfig(struct uart_8250_port *up)
>  	up->tx_loadsz = uart_config[port->type].tx_loadsz;
>  
>  	if (port->type == PORT_UNKNOWN)
> -		goto out_lock;
> +		goto out_unlock;
>  
>  	/*
>  	 * Reset the UART.
> @@ -1355,7 +1355,7 @@ static void autoconfig(struct uart_8250_port *up)
>  	else
>  		serial_out(up, UART_IER, 0);
>  
> -out_lock:
> +out_unlock:
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
>  	/*
> @@ -2714,12 +2714,12 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
>  	mutex_lock(&tport->mutex);
>  
>  	if (port->uartclk == uartclk)
> -		goto out_lock;
> +		goto out_unlock;
>  
>  	port->uartclk = uartclk;
>  
>  	if (!tty_port_initialized(tport))
> -		goto out_lock;
> +		goto out_unlock;
>  
>  	termios = &tty->termios;
>  
> @@ -2737,7 +2737,7 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
>  	spin_unlock_irqrestore(&port->lock, flags);
>  	serial8250_rpm_put(up);
>  
> -out_lock:
> +out_unlock:
>  	mutex_unlock(&tport->mutex);
>  	up_write(&tty->termios_rwsem);
>  	tty_kref_put(tty);
> -- 
> 2.32.0
> 

-- 
With Best Regards,
Andy Shevchenko


