Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953911E5724;
	Fri, 24 Apr 2026 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027920; cv=none; b=o9MP13KOMavQZpPKH6WDgKRVIwKcXuilTFJF/FT3jS3zY5+qv3/Uux1VIHLTzp6XDdXxe6bwm1fSLVAIH9f98p0EO2tvsd6HH1D/mawV5A+imi31Aa2QX4V1VciBadqa+WGwiLlVuiURbnrgYYk7Jg4c7UE3vZFUClRLMjBnLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027920; c=relaxed/simple;
	bh=Lxdj3ydrE1qIOEPimq/aSMaYFmWxwRjhBBNh87eEGu4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UUoN1Z0MkWvJqXkHACkhv5g2lZKqge/VAjSSQG+RXwu7IeZ+EF4Ywu05qGzwm2ghL2mqd4t8BBD35Dv1EyBdruOhYNoumjH3m9jzcWfeBIcnPIV00eQH33FTNefTjfY5cZ1CBkHylP8jYoxF3S8+QHFgrV7zaTDBhcogfF6M4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3Jx/3ct; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3Jx/3ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777027919; x=1808563919;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lxdj3ydrE1qIOEPimq/aSMaYFmWxwRjhBBNh87eEGu4=;
  b=G3Jx/3ctaLnrT7wRjqdGmHF6rWh1Nnl0Q3yBstoldaj9wOFV6KVrWWNS
   7xzqw0x7pJzIOYvgjfwNmL7qmTpoWELissWEx11W/1+BB5/jg7YpFlQNU
   2zeTeu9+JL9efL2u5f/VbQUJ/OrKgAe0ygrGW+pq07tzX5QOsWd9kXKE9
   siPuzqGrcsrrdAj8c2aTWxuBF6qkJDC8atRiYAauvlptCXz/H4gExHzNp
   PXERleAf6asbBAHXlc37INI9yN3CGUtC0yxVJZtuRy76Ha7SjXjUXLcyS
   5sEKO4xSkTkxJqoHA8zdXSgSU4jdZcRC8KZjX7Dg3yX/OljM9lxqPGMXS
   w==;
X-CSE-ConnectionGUID: OOF7rgAISw2X7vnRvB8T1w==
X-CSE-MsgGUID: dcmyNiFWSkq4zjwK3SVUsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="100659501"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="100659501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 03:51:58 -0700
X-CSE-ConnectionGUID: LYBs6SOGSoqn7wMJIby9ow==
X-CSE-MsgGUID: mzsDWxLoTsyh1ILFTNZvpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="263328444"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 03:51:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Apr 2026 13:51:52 +0300 (EEST)
To: Hugo Villeneuve <hugo@hugovil.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 6/9] serial: core: prevent irrelevant I/O infos display
 for UPIO_BUS
In-Reply-To: <20260423-tty-upio-v1-6-baf82d3b86d1@dimonoff.com>
Message-ID: <96429741-16d0-3e4b-b42f-d273a2adfba7@linux.intel.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com> <20260423-tty-upio-v1-6-baf82d3b86d1@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Apr 2026, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> It doesn't make sense to display irrelevant MMIO or legacy I/O information
> for serial devices on I2C or SPI busses. Now that we have a separate I/O
> type for these types of devices, prevent display of I/O information for
> them. Using uart_iotype_*() functions to do so also addresses the now
> invalid check for "iotype >= UPIO_MEM".
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/serial_core.c | 50 ++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 0bfdb69817e4259681fbc4658c9a68200aa2b65f..42559eda6fc134de77c3a7b850d565ebdc89e216 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2011,13 +2011,18 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
>  	if (!uport)
>  		return;
>  
> -	mmio = uport->iotype >= UPIO_MEM;
> -	seq_printf(m, "%u: uart:%s %s%08llX irq:%u",
> -			uport->line, uart_type(uport),
> -			mmio ? "mmio:0x" : "port:",
> -			mmio ? (unsigned long long)uport->mapbase
> -			     : (unsigned long long)uport->iobase,
> -			uport->irq);
> +	seq_printf(m, "%u: uart:%s", uport->line, uart_type(uport));
> +
> +	mmio = uart_iotype_mmio(uport->iotype);
> +
> +	if (mmio || uart_iotype_legacy_io(uport->iotype)) {
> +		seq_printf(m, " %s%08llX",
> +			   mmio ? "mmio:0x" : "port:",
> +			   mmio ? (unsigned long long)uport->mapbase
> +			   : (unsigned long long)uport->iobase);

This should align to ?

> +	}
> +
> +	seq_printf(m, "irq:%u", uport->irq);
>  
>  	if (uport->type == PORT_UNKNOWN) {
>  		seq_putc(m, '\n');
> @@ -2482,31 +2487,20 @@ EXPORT_SYMBOL(uart_resume_port);
>  static inline void
>  uart_report_port(struct uart_driver *drv, struct uart_port *port)
>  {
> -	char address[64];
> +	char address[64] = "";
>  
> -	switch (port->iotype) {
> -	case UPIO_PORT:
> -		snprintf(address, sizeof(address), "I/O 0x%lx", port->iobase);
> -		break;
> -	case UPIO_HUB6:
> +	if (uart_iotype_mmio(port->iotype))
>  		snprintf(address, sizeof(address),
> -			 "I/O 0x%lx offset 0x%x", port->iobase, port->hub6);
> -		break;
> -	case UPIO_MEM:
> -	case UPIO_MEM16:
> -	case UPIO_MEM32:
> -	case UPIO_MEM32BE:
> -	case UPIO_AU:
> -	case UPIO_TSI:
> -		snprintf(address, sizeof(address),
> -			 "MMIO 0x%llx", (unsigned long long)port->mapbase);
> -		break;
> -	default:
> -		strscpy(address, "*unknown*", sizeof(address));
> -		break;
> +			 " at MMIO 0x%llx", (unsigned long long)port->mapbase);
> +	else if (uart_iotype_legacy_io(port->iotype)) {
> +		if (port->iotype == UPIO_PORT)
> +			snprintf(address, sizeof(address), " at I/O 0x%lx", port->iobase);
> +		else if (port->iotype == UPIO_HUB6)
> +			snprintf(address, sizeof(address),
> +				 " at I/O 0x%lx offset 0x%x", port->iobase, port->hub6);

Please use scnprintf() so we could perhaps one day get rid of snprintf() 
entirely.

>  	}
>  
> -	pr_info("%s%s%s at %s (irq = %u, base_baud = %u) is a %s\n",
> +	pr_info("%s%s%s%s (irq = %u, base_baud = %u) is a %s\n",
>  		port->dev ? dev_name(port->dev) : "",
>  		port->dev ? ": " : "",
>  		port->name,
> 
> 

-- 
 i.

