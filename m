From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Make sure UART is powered up when dumping MCTRL status
Date: Wed, 10 May 2006 17:39:19 +0100
Message-ID: <20060510163919.GF32632@flint.arm.linux.org.uk>
References: <20060505221537.GK14872@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55309 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965017AbWEJQjZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 May 2006 12:39:25 -0400
Content-Disposition: inline
In-Reply-To: <20060505221537.GK14872@mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "George G. Davis" <gdavis@mvista.com>
Cc: linux-serial@vger.kernel.org

On Fri, May 05, 2006 at 06:15:37PM -0400, George G. Davis wrote:
> @@ -2068,6 +2076,10 @@ uart_configure_port(struct uart_driver *
>  
>  		uart_report_port(drv, port);
>  
> +		/* Power up port for set_mctrl() */
> +		if (!uart_console(port))
> +			uart_change_pm(state, 0);
> +

If it's possible for uarts to be powered down here, wouldn't it be a
good idea to ensure that the console is also powered up?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
