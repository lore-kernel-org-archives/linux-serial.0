Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860BB26A0DB;
	Wed, 26 Nov 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156060; cv=none; b=bBWSshyu25D9vAtgX+8MJVxRSBTDkrIP37m4S94JA2zKkbLvhJINKwD+E3z0N2b8tx/kShpOH0YCJtzvNelPTqL69phfLKEqOPnSZxoE9ybbBNWYpJugiIX5+Yjcf4sjR/CqEYrip+Jy/pWNvUyW3mz2DbokNBWOAJDm/9Z8BcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156060; c=relaxed/simple;
	bh=OAHgqHSuutAzajxjg4ZMojJbQ0FLRXY/bsAUAQ+tWtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7re5kIHFpPck0xoxtYDmnVtWbcMWoxOw1Z5lEO7sKA12//KOmZpKJ5Yq0a8ntxFb6jlstUpf3r0weu6fNdyuR4rxSBMnXW009uBsZeJdO3+wDCYBXhfprTjDQs5mpJEYJClZFkG5/4+BTKKHWxd0L/MClJ6uFCeDl5GoxNb65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFlVFFKo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFlVFFKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764156056; x=1795692056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OAHgqHSuutAzajxjg4ZMojJbQ0FLRXY/bsAUAQ+tWtE=;
  b=KFlVFFKo0Bamc9PULlVnStioNjYNj1VtTBsEEBQDGfE2JyxpU34Uvaw/
   KXth3CNL4a3hpvmsd8sard+xp9Q0jMj/nhC/WhAcJfkARkfgH4G/klXwQ
   W3cR+QFi3F3J9dATZXHX1yq7JjLFq7Eq9X4m1bTXGCWFqXhIUUaxUlqO1
   tdQfQf+BREEqfPnIOjtCze5iq3mMqXt2qODwOb+w+oNnTwTsXctAT1Gv6
   obgZOCHEWcvALFXFDyecy3IqQY0i2Cw5rXQpvFhuZRZraVRI3HKceGmyA
   8pnHoGipKqpIZWzcO85sstYPkI4C1hQ5AbwjDd+uW5t6XO9pVzckwaU6x
   Q==;
X-CSE-ConnectionGUID: VUz/LI9wRb6C/mY/reFvoA==
X-CSE-MsgGUID: g7PCQHDUSoaKVUNIjYECyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="70053007"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="70053007"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 03:20:56 -0800
X-CSE-ConnectionGUID: ccDy4/hUTmmWn0rLVaEBmg==
X-CSE-MsgGUID: WX4Ff8DeSbyupnmFSLEykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="223634775"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 03:20:53 -0800
Date: Wed, 26 Nov 2025 13:20:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kartik Rajput <kkartik@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA
 controller
Message-ID: <aSbikmpzkADKkna6@smile.fi.intel.com>
References: <20251126090759.4042709-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126090759.4042709-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 10:07:59AM +0100, Francesco Lavra wrote:
> This driver runs also on SoCs without a Tegra20 APB DMA controller (e.g.
> Tegra234).
> Remove the Kconfig dependency on TEGRA20_APB_DMA, and remove reference to
> the APB DMA controller from the Kconfig help text.

...

>  	help
>  	  Support for the on-chip UARTs on the NVIDIA Tegra series SOCs
>  	  providing /dev/ttyTHS0, 1, 2, 3 and 4 (note, some machines may not
>  	  provide all of these ports, depending on how the serial port
> -	  are enabled). This driver uses the APB DMA to achieve higher baudrate
> -	  and better performance.
> +	  are enabled).

I think this removes a good piece of information. Perhaps rephrase?

	  This driver may use the APB DMA when available to achieve
	  higher baudrate and better performance.

-- 
With Best Regards,
Andy Shevchenko


