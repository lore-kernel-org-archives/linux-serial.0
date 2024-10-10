Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573019E7D3;
	Thu, 10 Oct 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572451; cv=none; b=d8gxx/rPvHwPn12oXTNsaeYSuYfpug8vzR42Zu1IhZjqY5xGHy/6KM81CF24BjE8MK6nMr5Igo+BIUfOwm1Q9QH2IetuESesBinUgw1sZa68WqDoR0p9yUzli4SNPgPAWGLLnX8YwVxT1Bd6kMICqFncCdjDVSOXzxZofbu95d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572451; c=relaxed/simple;
	bh=z47HeD9ahRKP+YVSP51eG5FY2Y0Loe0o9seT+rV1wSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObgfzJM2j5HFxSjiXUCc6c+fRzFnZxQT27w2QdnZA3Fu2NGOxsTUE58E16iq5Hg/Dkal5DKdYaC2m9CUnckHp5zRnL1oWq39PtzvcvcGZxpRoXwQq9uu913BHHEr9gm/5EZs9q7JkviJ5SGY75J+iw//YcSnWhlLz7nAI6E8w7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbvDQqSt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbvDQqSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728572450; x=1760108450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z47HeD9ahRKP+YVSP51eG5FY2Y0Loe0o9seT+rV1wSQ=;
  b=lbvDQqStpY0c3dlhp5UyyRSjYfc6vIwrXPrS2u8PY+Z7+VsaR27dUj/P
   m4ePowmmMq5D3QZ0RQ5DXghCMQFKbGZpZBUCBfemdh/RevRBlulLNShha
   ADkVihZmMjtvxed6F2P88VfNuh0ibjexUIIMG/ljknb3ZIs4vlKeeiCm4
   CDSMebRwuRTaDfBSvu9Ej4vTxvTvbhWqjhVwzlbOR25UylxWsPnn8zWnA
   080e4zVqZK7qWdxNKK1Ea87DNCo1VNfu8veIBtre5AYcU0TZZZ53F9xoa
   aLS8u27E7QmNauHDby5sXxfUAtP5+v3KpRBk5qyNNFEknui007DtJnDlJ
   Q==;
X-CSE-ConnectionGUID: I48N6zjyTH+ExuwMuo3mqw==
X-CSE-MsgGUID: GSluXrUsQEOX4c01pDtCXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27808478"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27808478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:00:41 -0700
X-CSE-ConnectionGUID: 7RkOvKm2SMGzGkgpdfxOEA==
X-CSE-MsgGUID: gilISOZ9Rx6UmZst3O9khg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76229673"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:00:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syueZ-00000001ZUI-0tSd;
	Thu, 10 Oct 2024 18:00:35 +0300
Date: Thu, 10 Oct 2024 18:00:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
Message-ID: <ZwfsEpqgi9zH9P_t@smile.fi.intel.com>
References: <20241009233908.153188-1-inochiama@gmail.com>
 <20241009233908.153188-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009233908.153188-3-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 07:39:06AM +0800, Inochi Amaoto wrote:
> SG2044 relys on an internal divisor when calculating bitrate, which
> means a wrong clock for the most common bitrates. So add a quirk for
> this uart device to skip the set rate call and only relys on the
> internal UART divisor.

...

> +static const struct dw8250_platform_data dw8250_sophgo_sg2044_data = {
> +	.usr_reg = DW_UART_USR,
> +	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> +};
> +
>  static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
>  	.usr_reg = DW_UART_USR,
>  	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,

For the bare minimum this should be deduplicated as to have one record for now.

static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
	.usr_reg = DW_UART_USR,
	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
};

If we need different quirks in the future, they can be split again.
Or, if you certain that new quirks will come, mention this in
the commit message.

...

>  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> +	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_sophgo_sg2044_data },
>  	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },

I think my proposal for having a common compatible for those two is a no-go
as compatible strings are for the (unique) hardware and shouldn't be abstracted
based on some Linux or other OS shortcuts / quirks.

-- 
With Best Regards,
Andy Shevchenko


