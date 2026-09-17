Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E0346FA8;
	Thu, 17 Sep 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627348; cv=none; b=SNS4VH/92cHi+B4/2D6BO98lXdlMPty3ynQA6zdmWy+Bxhqj1riVElZ7vGLryujw2Fx8gy6oL6lj8v+scmPZPQ0SdJ1zm2n8utCP5weN80fIf9AJC4woN5HRhHmJwI1jmP+hS65Tr4jIvMVsyOTl6+k2AqB/SvHj0SizX+3Lqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627348; c=relaxed/simple;
	bh=GLl+PNDb3G6wQ93kIOoz2vznPBNPJZqJdDb2FXYmeHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF2w0gZc3UeoM7VgSdLBQsGbeW1qgzygSyO3JZXlHcegKRc2mspl+olbLVNJd5EdRbYrFHo9Wn1KTBEMMH/m7nsdgmS+11PDByTk3mDJdF5uIu+iZmbxF7+XEAFcuNDlxfAKdu8D99NOZoJixOo3qpryiogm3kGXq4kmCxC7sYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HShAYTHQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HShAYTHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789627347; x=1821163347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GLl+PNDb3G6wQ93kIOoz2vznPBNPJZqJdDb2FXYmeHI=;
  b=HShAYTHQkbsmZZehrsFH7wx68WSvyMKID8R97iQv/utoXYyXOVFcUEu5
   T7aPPi0rtkqmW3fIm46TbbAjil+fjK1pV5y8mVUumTlGRbJYhZNxNMrL0
   ar/UDHs6d/f4f8mo9nC9f40iwBGeWKEgYcFEV72O/mr57+8VnhgkwZLlZ
   NwYKPaFS+zMlTzNaLfp+L+HrwdZKgqcvNHQ68vvDsP7TFAt5IvGRxJ8Pw
   LXDC3r5HqonVpzzLXtu9TLGXE6BaRd73H/GnQvVK5W00r7qU28tVWJ3gl
   HoiBMGks1itSpjOMpUj0DNjasYOAFq5WUoqzrU14rzT0WrNsp4obQ5Hct
   w==;
X-CSE-ConnectionGUID: OnofZLOvTfiKi/pToGZDQA==
X-CSE-MsgGUID: KUqahWM8QluFEdC5suLRWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92528025"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92528025"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:42:25 -0700
X-CSE-ConnectionGUID: PG/D0x/ySmKmZq1ey6kmtQ==
X-CSE-MsgGUID: JHg0psEGTpaArnv+HRX1zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297099751"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:42:23 -0700
Date: Thu, 17 Sep 2026 09:42:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Malathi A <malathi.a2000@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
Message-ID: <aquLzbM25C8dDb0p@ashevche-desk.local>
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917040511.103232-1-malathi.a2000@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 04:05:09AM +0000, Malathi A wrote:
> uniphier_uart_probe() enables priv->clk by hand and is then responsible
> for disabling it again on every error path. It misses one: when
> uart_read_port_properties() fails the function returns directly, leaving
> the clock prepared and enabled. The neighbouring path, taken when
> serial8250_register_8250_port() fails, does call clk_disable_unprepare(),
> which shows the leak is an oversight rather than intent.
> 
> Rather than adding another manual unwind, switch to
> devm_clk_get_enabled() so the clock is released by devres. That removes
> the error path entirely, along with the explicit disables in the
> register failure path and in uniphier_uart_remove().
> 
> The clock is still disabled and re-enabled by hand across system sleep,
> which stays balanced: only SET_SYSTEM_SLEEP_PM_OPS is used, so the
> device cannot be unbound while suspended and devres always sees an
> enabled clock at detach.
> 
> Found by smatch:
> 
>   drivers/tty/serial/8250/8250_uniphier.c:232 uniphier_uart_probe() warn: 'priv->clk' from clk_prepare_enable() not released on lines: 205.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	priv->clk = devm_clk_get(dev, NULL);
> +	priv->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "failed to get clock\n");
> +		dev_err(dev, "failed to get and enable clock\n");
>  		return PTR_ERR(priv->clk);

Consider fixing another latent bug here, id est with intermittent probe defer
this will spam the kernel dmesg a lot, so converting to use dev_err_probe()
will fix the issue (but at the same time you may convert all of the error
messages in probe to use return dev_err_probe() pattern). This needs to be
a separate change.

>  	}

-- 
With Best Regards,
Andy Shevchenko


