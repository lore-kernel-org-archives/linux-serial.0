Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F271260563;
	Sat, 18 Oct 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808769; cv=none; b=Cc7GOJd1pz9g63yhD5+VrxKqe8AjI9vBMSncJgsANAGMyBTIkXDxivEIUjzC20/oq642oIg4BFxQ78jRRmsLVrYXcrMHkiqIq49rXbyGv+VXRkDfl+0DtphY6niTj7tk+ObtPEgs34WHU2fVuaqg/r05Su0p3Mb25AoXtrrfLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808769; c=relaxed/simple;
	bh=NxIbPa2fH1pdp+reelXrlh0jLg7Vwo3mY9xsEwoBBQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttwmqYeA0IHMdOx9stXn+uuIQxCWIv8vfQQ56H0AWWHgv/KJFvSQxgKImQD69PMiSHLqBCL2KONvCJKlnOIe0aZKSpf6PHQuLlv/TM2GLpsGa8lYVEBDzUGWn4vLaEttrjMDvdhJwAV71PeUxgOLSckoPiiaT1Hk9qWBIRDlu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDM0n6Qh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDM0n6Qh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808768; x=1792344768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NxIbPa2fH1pdp+reelXrlh0jLg7Vwo3mY9xsEwoBBQ0=;
  b=RDM0n6QhbDdWUjLLu80yc28Fw2UeY5+ZW1I5a5ZaPo64/A3CNxFUj05I
   qcCLkROrd0EWAJCbFHp65/OmoKJW0ktDMJ0oO5WSTsX4tu6v/lX39BW4a
   C2oLu95p9Vz5/V8P5wc1PPvZnmR9XupgxNe7mlN2vUw9iSqVZCBdgqu2T
   MfZtct6avWUJNbj4HR4u6qVYLQ06MrtJgspdNsN5g49XHlkfmPQjzXT7S
   vK3CIgS5De1T3ZAv2xWxYaRem1q2iSfnMNex12MWO5gJqaVRCNZ+sYc/e
   2Gt5mswfC74gAA+kxOtvJwll7xkHJH6ZB6Bz47N9/cgS7zYMtPJoIcLxH
   Q==;
X-CSE-ConnectionGUID: o6PbxRWzS6OItY4elOAxwQ==
X-CSE-MsgGUID: R2aSZA21RTOmTakC6eVJCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65614217"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="65614217"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:32:46 -0700
X-CSE-ConnectionGUID: nM4SffQDTw2pkVETXRGMIA==
X-CSE-MsgGUID: puUU3YVuTWyHBZyz6vXh0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="187413443"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:32:45 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v94TZ-00000000Me0-09KN;
	Wed, 15 Oct 2025 19:35:45 +0300
Date: Wed, 15 Oct 2025 19:35:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: handle reset control deassert error
Message-ID: <aO_NYGFCKb0J2uqK@smile.fi.intel.com>
References: <20251009081309.2021600-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009081309.2021600-1-a.shimko.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 09, 2025 at 11:13:08AM +0300, Artem Shimko wrote:
> Check the return value of reset_control_deassert() in the probe
> function to prevent continuing probe when reset deassertion fails.
> 
> Previously, reset_control_deassert() was called without checking its
> return value, which could lead to probe continuing even when the
> device reset wasn't properly deasserted.
> 
> The fix checks the return value and returns an error with dev_err_probe()
> if reset deassertion fails, providing better error handling and
> diagnostics.

If it's not applied yet, it deserves the Fixes tag, I believe.

-- 
With Best Regards,
Andy Shevchenko


