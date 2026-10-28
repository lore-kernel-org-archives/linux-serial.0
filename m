Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177783;
	b=00IurpS7PZRdcjp/BPr86K9KoScWusM7jRwcm6UGTLly/ce5nnMuHTKYFy8mal3tbb9+
	 DC1lnDUBUeRGAkLjbWWVSmg6cDKin92W/EXFtJxcChjgxe8HpX29bHDu8qjAGVjXt9bgP
	 0ODRZhZ+Sf7YiWje0/1/0t1CA+RnvVSzckIjywpLvq5aKKi4ABpU5Vv8xxYFx/gz3lxsl
	 Iia0vPQQvkKxqXQIEtfJHMkukKKB4kRcbhl1ZC8tPcZ692DwmfDLLYkd0Xt7hgmohVYeW
	 ArepxEbbJTjANonru5UG6HN4OZgrfQ7J+3Q+uTLisIJtOQ1J26b69krWhuv41ATXSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177783;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Udd4b3hqYW73jXGQP/nuGmi+H6DeMLECfO5utI+4rqM=;
	b=krhUt9GbzP0ik44wQD45plc58+xSuL0ZeLnVKgPSmtkHdfoABWLjdWEXYEYC8WsPn7j1
	 BEsm0qj6f08XNb1Y3eU2SSbn9JyJ9g9LlwpAFChybU8/E4xaNm/qC91vBLNRgYDflM6/B
	 4GN/E1IaTDXsf6cqjbb4NL1ujOzczv43Ehqi6IR56k5/VWGQ2W0V+BVvma/T5L96+KVN2
	 94YgdLjNakgMMEAQzXGbf9N9S2Ehq5ogLrTNxsEXWaPfR9I/lMEuvPmlVcIaveqI9bKmE
	 +LCrbuWlg20V8fVui4/jZ51o1NTaKoil1cXq7s/34bThKamoFAwTJkVqFpoABTgiClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FW6MF8pa;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124E606A327;
	Wed, 28 Oct 2026 08:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1124E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FW6MF8pa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793177782; x=1824713782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+FW67hCHNVW/28PUiBcTZ5ylUucOB/eNbJlsjZQ+VNY=;
  b=FW6MF8pasdZ6xh19NVXN6f13ChjUl3Xrw7zbHZQrht2vSiZYic8IXhlK
   k37hms0rd78/VcF/MvbZtdAm8Anj6cKrCjVmSK36CGvVUV/mitNXJYjgs
   gVWtaUaab6EuE920fJgCeoWJnCGVUW3iGfYWUHnIA6UcMaxlH6XJ5w8Uy
   8KP/1P7N77hswqSwNsWbFYrvh7bNZnJhp8m53WDh/NBAjLoC5sxR5hQAo
   bS2lOH3e4BWLyBsBpdk49+gQHmPcB0i4kpe2+izkJXTGJUvnSK9cVyCjB
   2Ui7u/jZGlxkSek5JVukLa6k0VegCN0TC7iVZ5MsP0J4QlftA1PHrgsie
   Q==;
X-CSE-ConnectionGUID: YiXLnzqqSq2vJJEVV+vu+A==
X-CSE-MsgGUID: GMKH+kkqRBucmtqW7ay6hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1779024"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1779024"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:56:20 -0700
X-CSE-ConnectionGUID: 3iD4nZurQWyZoQy5b0BrYw==
X-CSE-MsgGUID: pCxkqi9iRbeXb6W3eJ57QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4718097"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:56:16 -0700
Date: Wed, 28 Oct 2026 10:56:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 1/5] serial: 8250_dw: select port setup through
 platform data
Message-ID: <auG4rIHPQZXKOd6j@ashevche-desk.local>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-1-d37e018fd0a6@gmail.com>
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
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-1-d37e018fd0a6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 05:05:29PM -0600, James Hilliard wrote:
> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered.
> 
> Replace skip_autocfg with the Octeon setup selection. On 64-bit builds,
> Octeon continues to skip optional-register probing while retaining its DMA
> setup; on 32-bit builds it retains the generic setup. Keep generic setup
> for devices without matched platform data as well.

...

> +static void dw8250_setup_dma(struct uart_port *p)
> +{
> +	struct dw8250_data *data = to_dw8250_data(p->private_data);
> +	struct uart_8250_port *up = up_to_u8250p(p);

> +	/* DMA setup requires a FIFO. */

The style of the single-line comment in this file is without period at the end.

> +	if (!p->fifosize)
> +		return;
> +
> +	data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
> +	data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
> +	up->dma = &data->data.dma;
> +}

...

> +static void dw8250_octeon_setup(struct uart_port *p)
> +{

> +	if (!IS_ENABLED(CONFIG_64BIT))
> +		dw8250_setup_port(p);

I believe the Cavium OCTEON  is 64-bit only platform, so you can just drop this
conditional altogether.

> +	dw8250_setup_dma(p);
> +}

With this being done, you can kill the entire helper ad use dw8250_setup_dma()
directly in dw8250_octeon_3860_data.

-- 
With Best Regards,
Andy Shevchenko


