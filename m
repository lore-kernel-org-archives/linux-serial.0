Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825571;
	b=eRrLV0A3gn2x/a0IxET6SD4vZ/1RShHyujbBcaM/pAU2TP7e8ex1N421XMcfQSrRO2hX
	 E6+jJreee6pe09et/S5JAuk2LKPl3GqVC2kHUGSgyyi67bmP7hprwF39Gy3vwErcNYqDB
	 HlNTaAZIbghQnl8T4Jpw01IC3w+erUX8AIUdPU0IJHYIQqvGK0YHqVuUj32brWSEYilen
	 b7q0VX2vrydb4gypah2miHaJQ6buXUlluklo6hiIZ14i8+8KJFK9davU8wfWkhMD93EJv
	 3AyMQMdJqM7bjFfme4mOc5x0y8sOJJortWuC2l0gLA3pmJMiVlqn4FRvJOakkn4izLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=by0TTOhREx0lRbBk/oQ/Ej/jEAipb/X4kMNCqNYKWqA=;
	b=pAas5y6ZxHxHl5K4buHdmlTL/3roN66jsy1KnvqgHKLrFu7aTWFO7ve/RziPILSYzc4u
	 31XLATRNScYUvjkDbRgYLe9DrJtILNhXfJwn9K1pTPlPZ2tNHHPkjHuq6Z57HNNWAg3DK
	 nu1e7Vb+LLd55ybCYA5D1RVMc/X9urN5Gnq4S/JX+ZxUBJdc6cRqzHGhC/x4DleHJCLlR
	 d6VxGHFPQt3tS1dBEnJKrOYw1dLTf09S3ZJApCM1lhz0bij9bpu7uHaVtKl2AmuB8HYhI
	 u7eLBs5GqdjKzvw/cEYx7RCqu1Fhzj2hIk6zw6cT3+Uk3EGJGd2P5yUigmTcAE+gmyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="PBk/SYYV";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C00606C5AD;
	Wed,  4 Nov 2026 20:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C00606C5AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PBk/SYYV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793825570; x=1825361570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WzwyEroXyQLX1aiBmh1BYTANO+65G443XLW1AglKKtk=;
  b=PBk/SYYVl35WL16i/mI1gND3BVSv4pFTvJtpO+4b6lF+b0wOtbC2Dswf
   0PFkySONliuujS/dEuxFlY1icgGK+SrBEmR351EA3azzAvYUPVaWfIfKc
   THgiUP366ReZqO0YQk1U5ekMwDG53c2Vf9abWsdmakjB4ObTjQFbApke+
   n0mapslU9RU8292PfxFdCVu8V6tYU+CA+XtsErj+R+jH2JJXV20IydFpQ
   /jo3FpMwyQrhMnzlXQW8pKg2bhjGnHe0tfDvPYH3OvDHYNN8CPqXgPtir
   Eq7rBsgAZqewcV7hOO1e8+/yr8czp6McQMkOIc9Wupb6ebwDUEeSWvNUO
   Q==;
X-CSE-ConnectionGUID: Yf6Af77/RtqFnfcYviNiEQ==
X-CSE-MsgGUID: waqQ4yz7Si+VABcipHYnAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2611228"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2611228"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:52:50 -0800
X-CSE-ConnectionGUID: AZUKDBAmR520v0iNlPXQcw==
X-CSE-MsgGUID: zqFgrJkDRd6Ocq+YGh2VWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6943135"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:52:48 -0800
Date: Wed, 4 Nov 2026 22:52:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/2] tty: serial: 8250: replace chan->device->dev with
 dmaengine_get_provider_device()
Message-ID: <auubHaqIJXDKxRAC@ashevche-desk.local>
References: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
 <20261104145211.3209669-2-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104145211.3209669-2-Frank.Li@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 09:52:07AM -0500, Frank.Li@oss.nxp.com wrote:

> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.

...

> -	if (s->dma_dev != chan->device->dev || s->chan_id != chan->chan_id)
> +	if (s->dma_dev != dmaengine_get_provider_device(chan) || s->chan_id != chan->chan_id)

Now it's better to wrap (I think the file doesn't really use relaxed limit of
100 characters per line).

	if (s->dma_dev != dmaengine_get_provider_device(chan) ||
	    s->chan_id != chan->chan_id)

>  		return false;

But TBH I don't care much, so
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


