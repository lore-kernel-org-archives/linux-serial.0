Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B819CCF5;
	Tue, 21 Apr 2026 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773909; cv=none; b=VANHKSGkt0J6p+VyZQFn0nxI0TKaXPzssvVOTjYBADpWafM0nvydWRqf+9/MGB0nIlRPihcLxF4rZygXPulHUsEkhs/j+JkOai2zp1y+l0qLo4K56dW/yKHImFznVHxMu/uno2SbJZn95DQ/7rr9FZaaQ3S159jS/SmOHD0G48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773909; c=relaxed/simple;
	bh=PenIqUUnQCpm0dma4EMkb9a/RBxddIPYadbHh0p8JIw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UDLkYUIq2JdYTrYYC8P8orfrmy49GXClXCXhzS4oKs0nRFKX5TDoXUPv6uMf3DHspwC9dDuwBsfOujkozzbYwT1IkgICnL0k79vtMgLQYmE9fuzwBwpsqmf0ktLs1OlWAw9Pu9JP27OPqbUqnZtiw0Ry/N5kDL29zE/JdOTl02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqf2p4zH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqf2p4zH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776773907; x=1808309907;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PenIqUUnQCpm0dma4EMkb9a/RBxddIPYadbHh0p8JIw=;
  b=lqf2p4zHyK7FdNHdDn/Iu1UiZe+VwjCE8Bzomb0uc3EUMAMlNMiIkdE4
   Y98VJtSU1tJ0wepul6HNYBo3nBm4v20gp4Bce7aD4Ec/yPsMgZVrXYodE
   e+rVD9Ks42hCzbbHRUucmz8JKM5pS1XpLsIHy2vk1mf36G44rCr38hF6W
   5X+yUmDVyro56jSXGoXrdndbVBaIeA0iZiqbJiyxPmji4oboto0Eil5En
   RgSdQsebhDJzS2lVmLaPJs3lhRWAQ1i7q157g9VuRDW5XkWEMRB3YQwU9
   OQxNHuSrAG3S6FlwyxdSNfL0YU0pMB8zO4T+2H+ZUYc8Cp6Lho7olVERN
   Q==;
X-CSE-ConnectionGUID: c0bqHxaqQ3u1f5jFDr9b6w==
X-CSE-MsgGUID: oHQVBxIqTGGM5Szsiyg4Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89175859"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="89175859"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 05:18:27 -0700
X-CSE-ConnectionGUID: CEpZVInFQBKIBerpdjfasQ==
X-CSE-MsgGUID: Jpeca53kSheybGJEYT2xhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="229347174"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 05:18:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Apr 2026 15:18:18 +0300 (EEST)
To: Jia Wang <wangjia@ultrarisc.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: Use a fixed CPR value for
 UltraRISC DP1000 UART
In-Reply-To: <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
Message-ID: <979c9543-3ea0-25de-f97b-9c6d2fa3ac61@linux.intel.com>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com> <20260421-ultrarisc-serial-v3-2-3d7f09c2420e@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Apr 2026, Jia Wang wrote:

> The UltraRISC DP1000 UART does not provide the standard CPR register used
> by 8250_dw to discover port capabilities.
> 
> Provide a fixed CPR value for the DP1000-specific compatible so the
> driver can configure the port correctly.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 94beadb4024d..ca6dbdf75918 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -962,6 +962,12 @@ static const struct dw8250_platform_data dw8250_intc10ee = {
>  	.quirks = DW_UART_QUIRK_IER_KICK,
>  };
>  
> +static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
> +	.usr_reg = DW_UART_USR,
> +	.cpr_value = 0x00022022,

Hi,

Please construct the cpr_value by ORing DW_UART_CPR_* defines together.
For fields, FIELD_PREP_CONST() may be useful.

In order to be able to use the DW_UART_CPR_* defines, they need to be 
moved into 8250_dwlib.h (I'd move all DW_UART register defines in a 
preparatory patch).

I know the existing Renesas' .cpr_value doesn't follow this convention but 
that could be converted as well (in another patch, or leave the Renesas 
entry conversion to me if you don't want to do that).

> +	.quirks = DW_UART_QUIRK_CPR_VALUE,
> +};
> +
>  static const struct of_device_id dw8250_of_match[] = {
>  	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> @@ -969,6 +975,7 @@ static const struct of_device_id dw8250_of_match[] = {
>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
>  	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
>  	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
> +	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, dw8250_of_match);
> 
> 

-- 
 i.

