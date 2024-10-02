Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B531CFECF;
	Wed,  2 Oct 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879395; cv=none; b=dt3h0QXp4tXNWTADewU7Hx0u1Dcx+b6EIamZMdxUeTL/MB5g8pvDs+qmxA8boSqB7hhsX3I1uSEFnFv+Bwc0m5g0qZu34WT3+1sdHksMsFxgVxf/j+5FcZeGPjMDK/XyMpXbJTLY84CgKVbwJ/vKK8nDNBuV5g08Juo8ZTbZJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879395; c=relaxed/simple;
	bh=5+hHbWOtiuADX8AuBi/u9ZYUQosjn4REPhRWHRUAZcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iArTEXCZc4Lb29IM1GtxqWVgWfsWi1iKh/VXLM/g9BCH+YO29KWvpgvDkZjAKflfmY/CzTEmRABeCfTMyLrLUkpkH0Zyac5rT55xxHL4pZ1GC3QTfyNgQCBEkouHSgxEfgCPAWYQ/cuqJ5PZhPmTmiSENL6X3oM5UefTOxcw/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7q014oa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7q014oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727879394; x=1759415394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+hHbWOtiuADX8AuBi/u9ZYUQosjn4REPhRWHRUAZcE=;
  b=U7q014oaNk72cSXm6TyMUVXjaov4RHUWC23vTwMBvnngH/Rx+SpM4RzM
   YSDHlfDhcUn14VRcBZ3k2xugBPfuHGYV6j7PEXpIOG3OerLGWpiz1xeCM
   nV7bnaxwnuDR/mVn1JJzHvUc5lcjxT0CDg3lkfZRnE3wgjWGzULmow/HH
   dopD9prqXu0kzxSqr23z/mZyo5tgyCKFrz2M3O0wmTT+eLT/yTPqH8KQk
   b2XfXQjY7LGL7Q0ihN3p9PhKhghuvpdso459AsgQ/937TE7NobbkKWBPj
   XJ9qmsc5Dy0AMWD7+yU+ES2iDX+WWxfMMDsxinYydPYnWES1X4Z6Ec+II
   A==;
X-CSE-ConnectionGUID: LKHiwj2vSiOx1uqU/Ib6kA==
X-CSE-MsgGUID: JwXyVbt1QAOdyCJB/nbIig==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38425941"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="38425941"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:29:53 -0700
X-CSE-ConnectionGUID: zA6QO3fEQqa/GQHtPe6FxQ==
X-CSE-MsgGUID: Ki6qR5tITJuWhFhRZ9SVxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="73609659"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:29:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sw0MO-0000000Fhb3-1aWx;
	Wed, 02 Oct 2024 17:29:48 +0300
Date: Wed, 2 Oct 2024 17:29:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 4/5] serial: 8250_exar: Remove old exar_ee_read() and
 other unneeded code
Message-ID: <Zv1Y2-KsGBQV1FX1@smile.fi.intel.com>
References: <cover.1727873292.git.pnewman@connecttech.com>
 <9d3b61f6bf003206aebe4db9f32366cc8e214201.1727873292.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3b61f6bf003206aebe4db9f32366cc8e214201.1727873292.git.pnewman@connecttech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 02, 2024 at 10:14:10AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Remove the old exar_ee_read() and associated helper functions.
> Remove defines that are no longer needed after the switch to using the
> eeprom_93cx6 driver.
> Add CTI_EE_MASK_OSC_FREQ define.

Seems like you have a rebase issues (you folded changes to the wrong patch).

...

>  drivers/tty/serial/8250/8250_exar.c | 95 +----------------------------
>  1 file changed, 2 insertions(+), 93 deletions(-)

Shouldn't be + lines here.

...

> +#define CTI_EE_MASK_OSC_FREQ		GENMASK(31, 0)

...

>  	osc_freq = le16_to_cpu(ee_words[0]) | (le16_to_cpu(ee_words[1]) << 16);
> -	if (osc_freq == GENMASK(31, 0))
> +	if (osc_freq == CTI_EE_MASK_OSC_FREQ)
>  		return -EIO;

You just introduced the - variant in the previous patch.
So, squash these two changes in the patch that adds this new conditional check.

-- 
With Best Regards,
Andy Shevchenko


