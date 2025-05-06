Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87296280A4D;
	Tue,  6 May 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534348; cv=none; b=eMoxDo4H2Cvgx8ydWv9BzeFFiBd6ncF15fTjDTZ5mgCoweD457PDwBx/wJsv99YE1hsjhE3+Wnk5B4WPpJCUoCKKqWRsj2ufX+7hnwBaU5fcZTU7xmQrexMHMzZ9/fDOWvsZg3b+VlAgjjuHY+9R82l8nG36syeu5W6HxO1dQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534348; c=relaxed/simple;
	bh=kXX4nc5q++bTLdVqTjAwDwXHD++x2VmwCQKLGF0w+Ns=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GXBoRJSmXpOxrxRMfXEiuQRqTuoiJcrr93p92zDkR2LrIT2mkugryrBsrAGMdCrtiC6zCPdOLykFitIg8BGw3Q3ntKTOu/z/+MIEQ9A3f/fdBmPzOWyX43unnm/xV0TcJ1SyRUmuxrSkjjYeyZLaMGBy1wSV+Ph6YWvjl1309ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYvHgf7p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYvHgf7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746534346; x=1778070346;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kXX4nc5q++bTLdVqTjAwDwXHD++x2VmwCQKLGF0w+Ns=;
  b=KYvHgf7pNOcP0qJhimpl4J6k0b4n3codeNBgMJ05yjx9ZqbwzqM6SVUb
   5odFSh3tv1uNwr//fScIn3DEWm7Bcc9oZBQ2XLbYGDuqJi343MDle2OKh
   6Bw4ITUnK3xBs73VJmkXESHZE+ESrQTQHM62jqJ4IGp2+W+R+JvwSbYGs
   xtAe5cUjr/bJ9Mu3T9kUNEODL2cbWIpIpkVmuotnE6a2SM88mvMIqgfE1
   ybKMQ2rBqFqdD73YD/7RuodAaH+xzKN1F3SD6ENemSEGEvabt1jBYZZDW
   iwNYOwBHTpEliSzPiUXVj6r2X1wCp62zpKE1VBO9yJLYprcnK6CLolwjh
   w==;
X-CSE-ConnectionGUID: w9rGrTBDRK2B0Ag54CJNTQ==
X-CSE-MsgGUID: lPjG6nG9Rb6upjtAJtMphg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47457643"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="47457643"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:25:45 -0700
X-CSE-ConnectionGUID: 02PNiSStR1+X30d9+EsQQA==
X-CSE-MsgGUID: bUJvuiWhTPilaf7CCnCNrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="136542207"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.207])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:25:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 May 2025 15:25:35 +0300 (EEST)
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: arnd@arndb.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    benjamin.larsson@genexis.eu, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    heikki.krogerus@linux.intel.com, Jiri Slaby <jirislaby@kernel.org>, 
    jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, markus.mayer@linaro.org, 
    matt.porter@linaro.org, namcao@linutronix.de, paulmck@kernel.org, 
    pmladek@suse.com, schnelle@linux.ibm.com, sunilvl@ventanamicro.com, 
    tim.kryger@linaro.org
Subject: Re: [PATCH v5 4/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
In-Reply-To: <20250506112321.61710-4-cuiyunhui@bytedance.com>
Message-ID: <85e57aad-c612-7f1a-03cf-cabd406a1c44@linux.intel.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com> <20250506112321.61710-4-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

I think shortlog should include mention to "dummy read" to make it a 
bit more specific.

On Tue, 6 May 2025, Yunhui Cui wrote:

> In the case of RX_TIMEOUT, to avoid PSLVERR, disable the FIFO

As with patch 2, please don't assume it is know to the reader how PSLVERR 
is triggered.

> before reading UART_RX when UART_LSR_DR is not set.

IMO, it would be better to explain the problem better first, something 
along these lines:

DW UART can fire RX_TIMEOUT interrupt without data and remain in that 
state forever. dw8250_handle_irq() detects this condition by checking if 
UART_LSR_DR is not asserted when RX_TIMEOUT occurred, and if detected, 
performs a dummy read to kick DW UART out of this state.

Performing dummy read from UART_RX is problematic because with ... it lead 
to ...

And only then explain the solution (disable FIFO for while performing of 
the dummy read).

> 
> Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f41c4a9ed58b..ffa8cb10b39c 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -288,9 +288,17 @@ static int dw8250_handle_irq(struct uart_port *p)
>  		uart_port_lock_irqsave(p, &flags);
>  		status = serial_lsr_in(up);
>  
> -		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
> +		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
> +			/* To avoid PSLVERR, disable the FIFO first. */
> +			if (up->fcr & UART_FCR_ENABLE_FIFO)
> +				serial_out(up, UART_FCR, 0);
> +
>  			(void) p->serial_in(p, UART_RX);
>  
> +			if (up->fcr & UART_FCR_ENABLE_FIFO)
> +				serial_out(up, UART_FCR, up->fcr);
> +		}
> +
>  		uart_port_unlock_irqrestore(p, flags);
>  	}
>  
> 

-- 
 i.

