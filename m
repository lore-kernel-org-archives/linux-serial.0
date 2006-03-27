From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] serial8250: set divisor register correctly for AMD Alchemy SoC uart. Re-posted.
Date: Mon, 27 Mar 2006 13:54:23 +0100
Message-ID: <20060327125423.GA24311@flint.arm.linux.org.uk>
References: <20060327131437.P55909@invalid.ed.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33551 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750990AbWC0Myd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Mar 2006 07:54:33 -0500
Content-Disposition: inline
In-Reply-To: <20060327131437.P55909@invalid.ed.ntnu.no>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jon Anders Haugum <jonah@omegav.ntnu.no>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Mon, Mar 27, 2006 at 01:27:34PM +0200, Jon Anders Haugum wrote:
> Alchemy SoC uart have got a non-standard divisor register that needs some 
> special handling.
> 
> This patch adds divisor read/write functions with test and special 
> handling for Alchemy internal uart.
>
> @@ -533,22 +565,20 @@ static int size_fifo(struct uart_8250_po
>   */
>  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
>  {
> -	unsigned char old_dll, old_dlm, old_lcr;
> +	unsigned char old_lcr;
>  	unsigned int id;
> +	unsigned short old_dl;
>  
>  	old_lcr = serial_inp(p, UART_LCR);
>  	serial_outp(p, UART_LCR, UART_LCR_DLAB);
>  
> -	old_dll = serial_inp(p, UART_DLL);
> -	old_dlm = serial_inp(p, UART_DLM);
> +	old_dl = serial_dl_read(p);
>  
> -	serial_outp(p, UART_DLL, 0);
> -	serial_outp(p, UART_DLM, 0);
> +	serial_dl_write(p, 0);
>  
> -	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
> +	id = serial_dl_read(p);
>  
> -	serial_outp(p, UART_DLL, old_dll);
> -	serial_outp(p, UART_DLM, old_dlm);
> +	serial_dl_write(p, old_dl);
>  	serial_outp(p, UART_LCR, old_lcr);
>  
>  	return id;

I'm not sure whether this is a good idea - this is used to detect
an 16C850 UART, so probably should be kept as is.

In other words, we should use serial_dl_read() / serial_dl_write()
when we're actually wanting to read or set the actual divisor, but
not for the autoconfiguration stuff.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
