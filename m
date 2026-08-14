Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DAD44C509;
	Fri, 14 Aug 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697779; cv=none; b=as82k8+Nmy1gbhgGT9bWrqkw+oup3q2FxBpsUix7f6yunryCg9SU2DHwSNnXv8KFOOSQ1Xx+xh4p/RoyRe+VaKXZiZwsZD4sbIoLpW3M1G0Tw3irs0ycn0hNrIgwlVPaqFiaoiBX1KLztdirQLyC9rzF0VIrAL2Pp2PtY6SivAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697779; c=relaxed/simple;
	bh=PkG9RihDyJL6Bgd8XNxo+50hH755y+GwoA7TCXgVjoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8msAws7GoKh3SJTSnzXcbJFfF0vBCc4ZI4G+jeVUp2VzGSkp08pEXJLyCkB7lUss5rVOaBM9Gob9GmR0wWeBXMUTGU6bsoXXc4+CH8O5XUljKzj1J8IyHFSQVQAep9p50XLlBx2Hz/NP+aKuMUhGKfDIRNE3SuM854RWJK4IyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Umo9aBQE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Umo9aBQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786697778; x=1818233778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkG9RihDyJL6Bgd8XNxo+50hH755y+GwoA7TCXgVjoA=;
  b=Umo9aBQErT5ig8MS+yOD38miFN6gdjmmH3XCPkJUQcSTn5Fvx/np9jXc
   V97bqfEzvh7FwL7mr90Nuc50dQbR1S4+oFKg1T96zCrFLzlR/WLBa7IST
   qdVTiq6MmocVQ2jyWALwRihVkveZsdxbQU7xoGbYXeOigzN2eoZnHuOlI
   J6+EBkrDplsUGEZSOeZfwUIDMsTB3clFFE0PmfcQpyabfiNXqUoe8ddCE
   JU8sbOnnD7NjKAdEcPFryoW8lpcq9K3Zc1wlB5NclkONFdYjayO2CNP8U
   4sq9msotVFc8ESgHa6aJOLAILTXgfvz6Z9qXslC7j9Izw+VJfHW+E9tPr
   g==;
X-CSE-ConnectionGUID: dvLlqiZZQI2WE4Bg4834TQ==
X-CSE-MsgGUID: mnvGL8bOQg6DtQnv5fx7tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97868105"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97868105"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:56:17 -0700
X-CSE-ConnectionGUID: yjyzu2nTSWKI2ny5L6ysGg==
X-CSE-MsgGUID: vcFxkZMMRf+Wja1BqhvQLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267662558"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:56:13 -0700
Date: Fri, 14 Aug 2026 11:56:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: longzhao@ambarella.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 quirks
Message-ID: <an7YKyVbe1YDtyL_@ashevche-desk.local>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 06:35:13PM +0800, Long Zhao via B4 Relay wrote:

> Add CV75 platform data with an ETOI IER mask and skip-set-rate so the
> DesignWare 8250 driver can drive the Ambarella UART for console use.

...

> +	/* Keep variant-specific bits in the shadow across subsequent updates. */

This says what code is doing. Instead it must say "why?" the code is doing this.

> +	up->ier |= d->pdata->ier_mask;
> +	serial_port_out(p, UART_IER, up->ier);

...

In case there is an HW bug, where can we get the errata, please? (For a bare
minimum add a reference to the Errata document you give to the customers.)

-- 
With Best Regards,
Andy Shevchenko


