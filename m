Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319F3B8BCB;
	Mon, 31 Aug 2026 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159259; cv=none; b=L1NVvkmeNmBwgJoe43/ApOqNPRf64KwiwU089yL/EibBQ2sNXn++z9hy94a39uc7nVEHonTHEc9+YNGOLxsJNEHke1MvNa9BgcTRn56noJscTXkqSqBWLgQEfIXg6JiVwQ3Bp7+SDbbz87HAVVWlwHmluQ7/lFtXiIx0Idv2cIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159259; c=relaxed/simple;
	bh=AJjPwOZmE9EeletFg7yEV1eQe3nKDuBLRINDUUtcIwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plGzefGv5Gs1mwL9iY/1mscw8ZqjuMBnL4480s4y243VST8gon/E1w8lbAGyNaInQhMipvQ2NfgWhbyN3qHHuM+Mbu1jpd5etw50lCX2YLXfXtC0s8mqvGZnFsHSyo/IpXu7okcy4yFqSl4tFIBWOhYo3yFF2och6Bj/duK7860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OthG0K15; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OthG0K15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788159257; x=1819695257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AJjPwOZmE9EeletFg7yEV1eQe3nKDuBLRINDUUtcIwc=;
  b=OthG0K15AEaQBBclzOkaoo+wBRHHsqZazh58zpm82v7taTJk/ehK3MuF
   i3Ygyre2xu08QlRjTK0MC9sdZx0bNfcwH7kD4B98KxVuxUsuyjjb/OP6x
   jJic3LLhmgda2QQDZBi1MNpdkMeFpcPToDn96P4MOng1F7VMKWLJAODgm
   vUowS3z6WJzMy+q41AFuhhvLJ+SFgFiUOAuss5cE12roSsw83bphVz73d
   HN9ihFHzwBPUbvwrfYLnO7Tj4FUJil40UdYfatl4zJccrCTcltfz1l6le
   iuyRuQ4HBfsvNLt4b76jRUAIwcNBeDsY01e/U0KhZA5Buwf5OAtiRz7Uu
   A==;
X-CSE-ConnectionGUID: ucKmhmt1RrCT1qgzAmAuPQ==
X-CSE-MsgGUID: /5bQobxrRxWPsw7+RJIAIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99219905"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99219905"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:54:14 -0700
X-CSE-ConnectionGUID: +C/VV3K2ThWK101otbAuhA==
X-CSE-MsgGUID: IipTr6nrRkKdlb/L+s6kqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272905395"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:54:13 -0700
Date: Mon, 31 Aug 2026 09:54:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tate Whiteberg <whiteberg@arista.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_mid: wait for LSR tx empty before
 setting termios
Message-ID: <apUlEi2pf1SoJQ-m@ashevche-desk.local>
References: <20260828175733.1650267-1-whiteberg@arista.com>
 <20260828175733.1650267-3-whiteberg@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828175733.1650267-3-whiteberg@arista.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 05:57:28PM +0000, Tate Whiteberg wrote:
> If mid8250_set_termios() is called while data is still in transmission,
> the corresponding register updates will corrupt the transmission.
> 
> Fix this by locking the port and and waiting for the transmitter to
> empty before performing updates. It is necessary to wait for both
> UART_LSR_THRE and UART_LSR_TEMT to ensure the final character is sent.

> Fixes: d9eda9bab237 ("serial: 8250_pci: Intel MID UART support to its own driver")

Obviously this is not the commit when the problem appeared.
Check the commit f549e94effa1 ("serial: 8250_pci: add Intel Penwell ports").

...

> +	uart_port_lock_irq(p);
> +
>  	p->uartclk = fuart * 16 / ps;		/* core uses ps = 16 always */

+ blank line

> +	serial8250_wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
>  
>  	writel(ps, p->membase + INTEL_MID_UART_PS);		/* set PS */
>  	writel(mul, p->membase + INTEL_MID_UART_MUL);		/* set MUL */
>  	writel(div, p->membase + INTEL_MID_UART_DIV);
>  
> +	uart_port_unlock_irq(p);

-- 
With Best Regards,
Andy Shevchenko


