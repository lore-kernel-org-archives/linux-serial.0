Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D6256C70;
	Fri, 23 Jan 2026 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769204513; cv=none; b=mYx7lxDf6/tkRfSEjK2nvMyx46BcvmCZsYBRsvXGS+R6B4/A1sOwlkjPa1z+tMH3OkWs70onKjpXqflY3u7bkoF9scbXJ2TDenruYw9Tc12hCcG22ePn0NmK/4b5nBuecDXR5Al35D7hfpQVaGhvO/zL2zxRu1xuTshQAkf9q6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769204513; c=relaxed/simple;
	bh=OxQGoJ/PXaLE3hWGnwmc+T7rIphREYp3WfiP5c0T7F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnD3whBLfZsSjS0/bMku+KgFZnASFrrhbc5YEzVrXg1KxZQ6iTnEsFB6jsfI1T9ksEfbuHT1yoxtGYQnyBoN0C5zHX/ITaXSN6s7GVtyjxLhErptBbvN5xoL24SC4BXzLmkmkk04MT4yjajkMFZegc4kQZU3z5zZNajQsskAfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6HeCEtC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6HeCEtC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769204512; x=1800740512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OxQGoJ/PXaLE3hWGnwmc+T7rIphREYp3WfiP5c0T7F8=;
  b=L6HeCEtChG5VmdURAImc9FvNUjwPomWki3n16T9OnKcGS2EGhfjpE42R
   h3ttP3qtOOqf0O/pkd3CBzAJAdwdhLofDDhgjy4FO2FDNfrgtVRmIg2La
   svOKecZm2ttfsTU4jR3fr0qoUxqfY3/4GUWJ00RhXTJg42AQqkaSZUsw5
   wDuDi0cffupyLqS3+y6CwujJ4aTRrKoCH6Fp6GZTgkpUcdJHsJYaTxzCy
   1TuSF1TKuMd5edB1/QLuaIdSvr90LveGiCqvCvLsUJuY5x2ul2Tqzv/Sr
   JZuBvB+OLK+RKwslvZbpEabEyE8Al7Fe9P+0miXb76lA+o32qnoCjjXoE
   g==;
X-CSE-ConnectionGUID: wkVRua5qQfyw8leHvpuGfQ==
X-CSE-MsgGUID: bB1F3TwQTASClzjLO/+tNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70627804"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70627804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 13:41:51 -0800
X-CSE-ConnectionGUID: CAbTJ5zeQXWwmIIxJ4Z/Og==
X-CSE-MsgGUID: wT94QfXoQN6nP9tH07U56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207168564"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 13:41:48 -0800
Date: Fri, 23 Jan 2026 23:41:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>, linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 2/6] serial: 8250_dw: Avoid unnecessary LCR writes
Message-ID: <aXPrGqUHtCCpKbcN@smile.fi.intel.com>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123172739.13410-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 07:27:35PM +0200, Ilpo Järvinen wrote:
> When DW UART is configured with BUSY flag, LCR writes may not always
> succeed which can make any LCR write complex and very expensive.
> Performing write directly can trigger IRQ and the driver has to perform
> complex and distruptive sequence while retrying the write.
> 
> Therefore, it's better to avoid doing LCR write that would not change
> the value of the LCR register. Add LCR write avoidance code into the
> 8250_dw driver's serial_out functions.

.serial_out() ?

...

> +/*
> + * With BUSY, LCR writes can be very expensive (IRQ + complex retry logic).
> + * If the write would not change the value of the LCR register, skip write

would --> does

skip write --> skip it

> + * entirely.
> + */

-- 
With Best Regards,
Andy Shevchenko


