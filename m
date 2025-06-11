Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6E271459;
	Wed, 11 Jun 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643407; cv=none; b=iZvFFYI5zarKshSwdGubeLxWZa/ssvCDnGlDwQI5JfjcFG4WNhWH2JMPS045vVkA+ZOxhWWzp7xvvq8S5aBW0nyaS8bBJP0Ncr887KPdJW8Ed8gTd6HehSX6EDegxHj9YyXTITNOdw8bGbCmJGIbGuOpYQDv40n3ALHIvyhaVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643407; c=relaxed/simple;
	bh=MLNf9BlK6xMOHAGq5DSVwdju6kiEM8tRxQxwL0LNK24=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tVWgo1I28IksqqB6CjlF4TRq/jTvNU5DNMbuwBQwKEX5A+B4n55/Y2FUUtzdjlIOWAtjr2kwAlH0eWREdHvqZaCr+93UvJ2pSK+FFvIvT9jAoyOxgA4ssNBwb0ox/+QDGVpEuiM/irFPz3ZbuzVPmb8M1yD1JgG/KahnQBx5hws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E88IPVB+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E88IPVB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749643406; x=1781179406;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MLNf9BlK6xMOHAGq5DSVwdju6kiEM8tRxQxwL0LNK24=;
  b=E88IPVB+XNMcgsaGdwVLN/vdCbP/YPsopSrjMOfCcd2GM5ThOXlgkFxt
   HKESv3Ks7c9Iks8opEkecL54f3UUjYjkKh5+VsJuidV0JRLQ/SxBT8x7c
   FrdDZUImmWCesAEY5pT0N2NwG8QFaOiYN9q0cxWgZh/+z/eVsdOHErxxm
   GriRWnLIQhSVW2j2qdHqK1YWxd9oAreBfz3F6qhXU8hRiSUKxqn462O4F
   /4VCXHG75/37UPTX3o9gvr7QOQ5o/9ns+V36tw45rYCF1Z8D8pRvm7Xeg
   cJ3XLvHapdJC42JxrcVMVnw3zC56FbCLSbzr2ehs+saRS20pAhvfjTJi3
   A==;
X-CSE-ConnectionGUID: cNotr/r8SxSZbRoHtKWNgg==
X-CSE-MsgGUID: B7lE8BlhQSCYDBNRTn2Rmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55576967"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="55576967"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:03:25 -0700
X-CSE-ConnectionGUID: RyqVNbn+RLeC9FrtBdOFNw==
X-CSE-MsgGUID: MEbQAkFVTTuxyjqiH1G0gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="184382899"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 05:03:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 15:03:18 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/33] serial: 8250: extract serial8250_THRE_test()
In-Reply-To: <20250611100319.186924-16-jirislaby@kernel.org>
Message-ID: <2c7977aa-831d-16be-667f-9f761ea0060f@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-16-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> serial8250_do_startup() contains a stand-alone code for probing THRE.
> Furthermore, the code block is conditional (port->irq and test for
> UPF_NO_THRE_TEST).
> 
> Move this code to a separate function. The conditional can be evaluated
> easier there -- by a simple return in the beginning. So the indentation
> level lowers and the code is overall more readable now.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 92 +++++++++++++++--------------
>  1 file changed, 49 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index c09a90b38d8f..5466286bb44f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2199,6 +2199,54 @@ static void serial8250_set_TRG_levels(struct uart_port *port)
>  	}
>  }
>  
> +static void serial8250_THRE_test(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned long flags;
> +	bool iir_noint1, iir_noint2;
> +
> +	if (!port->irq)
> +		return;
> +
> +	if (up->port.flags & UPF_NO_THRE_TEST)
> +		return;
> +
> +	if (port->irqflags & IRQF_SHARED)
> +		disable_irq_nosync(port->irq);
> +
> +	/*
> +	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
> +	 * has already been cleared.  Real 16550s should always reassert this interrupt whenever the
> +	 * transmitter is idle and the interrupt is enabled.  Delays are necessary to allow register
> +	 * changes to become visible.

Very long comment lines are hard to read. (This is mostly not related to
line length limits, but with eye movement required.)

It may make sense to place some of the descriptive comment text into a 
function comment instead of placing them mid-function.

> +	 *
> +	 * Synchronize UART_IER access against the console.
> +	 */
> +	uart_port_lock_irqsave(port, &flags);
> +
> +	wait_for_xmitr(up, UART_LSR_THRE);
> +	serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> +	udelay(1); /* allow THRE to set */

These comments mix visually into the code making this look a big wall of 
text overall. Maybe consider adding empty lines to the logic as well as
there are what looks clear steps in this logic.

> +	iir_noint1 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
> +	serial_port_out(port, UART_IER, 0);
> +	serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> +	udelay(1); /* allow a working UART time to re-assert THRE */
> +	iir_noint2 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
> +	serial_port_out(port, UART_IER, 0);
> +
> +	uart_port_unlock_irqrestore(port, flags);
> +
> +	if (port->irqflags & IRQF_SHARED)
> +		enable_irq(port->irq);
> +
> +	/*
> +	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
> +	 * kick the UART on a regular basis.
> +	 */
> +	if ((!iir_noint1 && iir_noint2) || up->port.flags & UPF_BUG_THRE)
> +		up->bugs |= UART_BUG_THRE;
> +}
> +
>  int serial8250_do_startup(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> @@ -2258,49 +2306,7 @@ int serial8250_do_startup(struct uart_port *port)
>  	if (retval)
>  		goto out;
>  
> -	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> -		unsigned char iir1;
> -
> -		if (port->irqflags & IRQF_SHARED)
> -			disable_irq_nosync(port->irq);
> -
> -		/*
> -		 * Test for UARTs that do not reassert THRE when the
> -		 * transmitter is idle and the interrupt has already
> -		 * been cleared.  Real 16550s should always reassert
> -		 * this interrupt whenever the transmitter is idle and
> -		 * the interrupt is enabled.  Delays are necessary to
> -		 * allow register changes to become visible.
> -		 *
> -		 * Synchronize UART_IER access against the console.
> -		 */
> -		uart_port_lock_irqsave(port, &flags);
> -
> -		wait_for_xmitr(up, UART_LSR_THRE);
> -		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> -		udelay(1); /* allow THRE to set */
> -		iir1 = serial_port_in(port, UART_IIR);
> -		serial_port_out(port, UART_IER, 0);
> -		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> -		udelay(1); /* allow a working UART time to re-assert THRE */
> -		iir = serial_port_in(port, UART_IIR);
> -		serial_port_out(port, UART_IER, 0);
> -
> -		uart_port_unlock_irqrestore(port, flags);
> -
> -		if (port->irqflags & IRQF_SHARED)
> -			enable_irq(port->irq);
> -
> -		/*
> -		 * If the interrupt is not reasserted, or we otherwise
> -		 * don't trust the iir, setup a timer to kick the UART
> -		 * on a regular basis.
> -		 */
> -		if ((!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) ||
> -		    up->port.flags & UPF_BUG_THRE) {
> -			up->bugs |= UART_BUG_THRE;
> -		}
> -	}
> +	serial8250_THRE_test(port);
>  
>  	up->ops->setup_timer(up);
>  
> 

-- 
 i.

