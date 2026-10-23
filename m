Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741000;
	b=wqOpvh8WJVWXIYDtRZp/P6Wyo9NsI0QQ/r/4PJLIz4+MioHlb7DYTQ8Qj837fxFMclMZ
	 C9vqsl6LuYGtYHEDBW8exsZMfMuF739dxW8QZcis7XPmHoeHehlAz/YQA/Vc3ciPGOo11
	 KU/HJBxxv8NLfVYpYOJ9QEnqZ83TiB/r3CWTtsKdgDMg1/GQstmRAzrhXl+cGuJS0BsX0
	 oA30BNPOLkS1RnLsJEWadumwEkCEQpw6GlCI32wJVRaiPjk0f4sJo9cqcdtX4d2Rwjcn4
	 pE6oC1n+dNEtsr+DXNreml+NR7NqPE0LT1eSFR0oDrJolEkobI2eCzcBVl5tH5nb+Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741000;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Bh7KrdyD2HIBnpJzdRiPhKjAFpru43HRvC4UQ+HxbG8=;
	b=nhgakEQf5rJBxFnYrLacOt90Yxs8qQpjsqMoRP2yNw+97FAUr6etSD+J7DKWtwnAA9YW
	 ne1OtiubsrTfo7FpHwZGAZCdYm5zNmsfdUhvJJgabJzJD2Gsbk1HNsOSLsuwRR8wHpeCb
	 +aIxhhlOG9APetPh5LsyCO9+wbfwLtG7Ti+J2yuIdjoC2RywYXYlJqTsoRfRaRQB4CqYh
	 4DzaRDVO9fedFHynMQnkPDNFtsyEydVanxXkUVDYHrafaMPVwj/mHy/ls4OSf8/etzATC
	 8aNry9oLyKT71+tFNl2UAX8mGVOORtaVMefx4n5yb+o5H8LTI57SWfWPhAxu4TNCcfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HDvaifqh;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619B606A31A;
	Fri, 23 Oct 2026 07:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B619B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HDvaifqh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792741000; x=1824277000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmOzRAoWByHMo0IdotDX/3gU0AvHW3N8LhbmTWH9ALE=;
  b=HDvaifqhhpKhcwSsqa4Ww3Sl6N0TemJGOSIOzO9pIJ3BZFyGE5OXZNEd
   R6WX5FmQSmGF9xcfA7FKoEyI4t1Z7ZGr08gvrQdjckDlRJAJzeUZpYXJP
   H/2MwPzKspRYkGdRD1fhe1kOTm8sPO0XMXNFO203psNrwVTVUnMMld9Za
   ECJD8xr+Kq7FT+yAlMOb8yTASMwU8wFsrieZ31w5485Rxn8eU7+Sb/L0S
   4vEFYd89bvmMCMkbJnW6iu8xERopHe0dEQlJpiLjSeQEqbr6Atj5nJGzv
   alAwO7PfzA9FfaB+FkckKKcmQK+Yw8XgeHDgu48/Vg3JaIqxdDhUkvFGM
   w==;
X-CSE-ConnectionGUID: aAoPiK79QayOjaKaemefUQ==
X-CSE-MsgGUID: RRBNu+FrRKuq10oXpGMwvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1509712"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1509712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:36:38 -0700
X-CSE-ConnectionGUID: guNzMdpCQOmPxmiruS0y8A==
X-CSE-MsgGUID: 10ZL/KrvS2+rYwsIz1OaLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3952601"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 00:36:36 -0700
Date: Fri, 23 Oct 2026 10:36:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_omap: separate locked TX DMA
 completion processing
Message-ID: <atsOghPkDAfWWWzL@ashevche-desk.local>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
 <20261022-submit-serial-8250-dma-cancel-v1-v2-1-088ea51e3891@gmail.com>
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
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-1-088ea51e3891@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 06:34:02PM -0600, James Hilliard wrote:
> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.

...

> +static void omap_8250_dma_tx_complete(void *param)
> +{
> +	struct uart_8250_port *p = param;
> +	struct uart_8250_dma *dma = p->dma;
> +
> +	guard(uart_port_lock_irqsave)(&p->port);

> +	if (!dma->shutting_down)
> +		omap_8250_tx_dma_complete(p);

Taking into account the name and the purpose of the function I would refactor
this to

	if (dma->shutting_down)
		return;

	omap_8250_tx_dma_complete(p);

> +}

-- 
With Best Regards,
Andy Shevchenko


