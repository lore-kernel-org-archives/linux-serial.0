Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBE27C157;
	Tue,  6 May 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533190; cv=none; b=eKE64nNkRGtCfALgAhu0isYdjbPgLM4KMU9XLX0DoDocxuc2nW8PTpu6tNFxhVPVAyTmpwXVt6JOGT697fq/arCYTvR2Xugpd2yl1eGjojeDddm/0+QBrAendhN4q+j1Z4JovZWarfPtnk34uumWp2aPBHtp8iH1kmXG2kMiR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533190; c=relaxed/simple;
	bh=yrApMg2Q1BCISMtqxwlIotBwEopk5QQD4jpgaUv6yKY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cYDAe+2U9MTgfVn888aKjDyZNYvgEZQKegUMVLIFIWa6YXKfsr4fZ3aL2r16DsrKPGMe8ab1vtOrx5EwowQr3aOn/8tkYk6uYi2ZSQN3cc47SJaibEpVxzXOqVWJjeBGodwVrJ9qRbKL+X0vTn5WIZJOYygTbENny9DqZ6+g/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIzU+cPg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIzU+cPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746533188; x=1778069188;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yrApMg2Q1BCISMtqxwlIotBwEopk5QQD4jpgaUv6yKY=;
  b=eIzU+cPgIIi5ZKJHNxpHx+KWa4Pvf1eGGQAwCQpyvBi/RQ/2jFgIHEzY
   uRx14GcLhtL1MvECS5HIAGQItiYML6pr+TVgznGSJqhH/Bwmdb6eqK3vh
   CUxxnw8lnnW/gUjvvg+H7S9CBhl4ryYoxqK2lr2ka9ugiEvvP8rmptMR7
   tK2H2HPTwBS/fcdYFyucaP3FhxYLR42f+KVO8kJE4lCZ6myzgvpTsATZa
   Fx5Eb2tglGj8I3p/zvC1o/NLihPmDnSBvHQqLih/vfUIL8P8fmqYdUW1p
   6NJj62uxqJeyCZNsl7SWPU9wzCXfQOFodCUOVdtqsjDLhfXqlkBM+GBq2
   g==;
X-CSE-ConnectionGUID: 6Rm264A3R9qlIt5upV+h3g==
X-CSE-MsgGUID: ahV1/4CLRaqPuSk2Bj7yGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52007532"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="52007532"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:06:27 -0700
X-CSE-ConnectionGUID: zhgYECvEQTK5zEuXRNcezw==
X-CSE-MsgGUID: 1tjypfTPTVe3wRdYITSyIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="136594290"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:06:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 May 2025 15:06:18 +0300 (EEST)
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
Subject: Re: [PATCH v5 3/4] serial: 8250_dw: warning on entering dw8250_force_idle
 unlocked
In-Reply-To: <20250506112321.61710-3-cuiyunhui@bytedance.com>
Message-ID: <71a295db-72ea-bf2a-338f-416b178f5305@linux.intel.com>
References: <20250506112321.61710-1-cuiyunhui@bytedance.com> <20250506112321.61710-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 May 2025, Yunhui Cui wrote:

> Read UART_RX and check UART_LSR_DR in critical section. Unsure if

Unsure if -> Ensure the

> caller of dw8250_force_idle() holds port->lock. Don't acquire it
> directly to avoid deadlock. Use lockdep_assert_held_once for warning.

Add (), although the last two sentences don't seem that useful, IMO.

> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index af24ec25d976..f41c4a9ed58b 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/lockdep.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> @@ -112,6 +113,13 @@ static void dw8250_force_idle(struct uart_port *p)
>  	struct uart_8250_port *up = up_to_u8250p(p);
>  	unsigned int lsr;
>  
> +	/*
> +	 * The serial_in(p, UART_RX) should be under port->lock, but we can't add
> +	 * it to avoid AA deadlock as we're unsure if serial_out*(...UART_LCR)
> +	 * is under port->lock.

I'm left to wonder who/what "we" is here? Could you change it something 
more precise.

> +	 */
> +	lockdep_assert_held_once(&p->lock);
> +
>  	serial8250_clear_and_reinit_fifos(up);
>  
>  	/*
> 

-- 
 i.

