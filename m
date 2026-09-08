Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267C3A5449;
	Tue,  8 Sep 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863129; cv=none; b=AZAgSESFzGl4jW6G9NqqsdmsnjX35gMoVeuwneB0oW14yfQhfr1hFYDsUYQkAyPe8Bo6I/FmJPPdU9Hap6AbGhkIhXmnM0Sn22lRLq8ruN6dpvWkI7SAuU6449YvK/KxUcc/bgZHyJbmRrgpgj3hTaABT/dE4OVivEn3Xg+m9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863129; c=relaxed/simple;
	bh=OZYZnFvrMSs4DhZMW5h5XoDve6m3bUA1NNbd9qEqrkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lggV0daLgwn4CrJVZ9N7INSl/RC5M6JtZui1mkT3oTpmXLSxTOg9cUksC3ExglNm/t2KHMN/yJw6hC/BMWH8oGauxvwGqz57lUYfuRmHwtQ5zEweWHEmd3LPHxgncIG1GUD8xajK02Mtd8uzYamGIv1ONZoSEgt8DzXjVSo+Z6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9GKiPR8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9GKiPR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788863128; x=1820399128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OZYZnFvrMSs4DhZMW5h5XoDve6m3bUA1NNbd9qEqrkQ=;
  b=a9GKiPR8RVGHxbC2aCuBBO0rYq032LXSOUXHP1JfdcfN/eErOgch35mY
   Y4Y82S8HUdlkvvVnHYyS0TIIvX+hiiIpFz3++QBbFJXMtWSyIjFsoSH4b
   iY0stlbLFhxm/v7b8nd5URV3/C8s4p11oFRLoFYEgYY6zTMc5ZPhQlNaQ
   YcTYt8V1jgf9somFoA1nEjJBRrGNk9jjxbeekRuCb1Xv7kRUbDSFqPAfF
   qmuuqIwq0u8Qb+B5oLPtg2Fj4I/Dg75bgxWJI1cpOj7R/b5aU53ZlxYYZ
   LedUbP5DIxeBeHovwVlGCSXeMcfFYT+mq+zVb07NgTpSzxU8Z46K1BSb4
   A==;
X-CSE-ConnectionGUID: Bui+jcBfTx2uPPLSzjdfeA==
X-CSE-MsgGUID: WRcFyaKhTgKRYObbtPg75w==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91771169"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91771169"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:25:27 -0700
X-CSE-ConnectionGUID: E/rh4UYSTIueZOxwQ2Ujog==
X-CSE-MsgGUID: 3m43gia3TbaJxxLx85KXtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="264754543"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:25:25 -0700
Date: Tue, 8 Sep 2026 13:25:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: ilpo.jarvinen@linux.intel.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, geshijian@picoheart.com,
	yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH v2] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
Message-ID: <ap_ik82SVnEGkBPU@ashevche-desk.local>
References: <20260907074035.77796-1-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907074035.77796-1-yang.yicong@picoheart.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 03:40:35PM +0800, Yicong Yang wrote:
> The DW uart could get into the cases where a bogus RX timeout
> interrupt is asserted but no available data. This could be
> workaround by doing a bogus read.
> 
> Currently the driver's using the standard RBR (receive buffer
> register) for this bogus read. However the reading of RBR
> in this case is allowed to raise a hardware error if vendor
> choose to implement in this way (our platform). It's also
> allowed to do the bogus read using SRBR (shadow RBR) for
> workaround which won't raise the hardware error. So change
> to use the SRBR to workaround the issue if it's available.

...

> struct dw8250_port_data {

>  
>  	/* RS485 variables */
>  	bool			hw_rs485_support;
>
> +	/* Shadow RBR offset, fallback to RBR if no shadow register support */

This comment is for "section", so split it to two

	/* Register offsets */
	/* Shadow RBR (if not defined RBR will be used) */

> +	unsigned int		srbr;

In APIs this defined as int, I would follow (however I agree that ideally in
all of them it should be unsigned).

	int		srbr;

>  };

-- 
With Best Regards,
Andy Shevchenko


