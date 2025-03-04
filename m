Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA73D561;
	Tue,  4 Mar 2025 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088944; cv=none; b=HvnuTqwPHt2IS37zMoSuXpbwpFoQktRaymYpDX3Q7JRRjIRbZVOvvamFiNMOxz7n60JhwtqJ7VxzhHREjCISp7c2up2U4aH7Xd5q/NAx9qnPlsmSW68hHDAXXIUFUVgjpNrBJmJ1BxG52COiV37NPdExvzxBM1/UkGpaw8wXAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088944; c=relaxed/simple;
	bh=I6AKIvYBVoI50+WthzWOWVzX/QNQgAy/x57wy0pi7+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uomiSiY1Ols4pcs/xP4cIi1E0yDUl9qyXBxo5cKv8l5IgGxmOZ+M38200cE/DBBRYPr3pNOTdDC7LkMdBSk4lbMQ5kg2Ds0WTHSKKNfN914I7Wt21QyNyxiY2ivcxfVZ+8lPj0MOWjcv1NXgu362jC5tqDZcCv0gnVlIkX5X8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqFiaiFZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqFiaiFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741088943; x=1772624943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I6AKIvYBVoI50+WthzWOWVzX/QNQgAy/x57wy0pi7+4=;
  b=CqFiaiFZWlwuSHKJdUZlFbTAAYxboSnJKV2/9bni2er6eAADlVfQJ3fh
   mq7/m9KsQG3XQtO7IyLlWQJyUmDPwBP/6H0zGXT1dov/Cm+ptGr+L5jXI
   HlIr1/6aM02xLKVV2vwHzJAyroR3+X7W0WN+IvhEeKUjeFHMRE1O+cstP
   3DnBq3b9HMKVfW8qUQ3dUvVGdc5i0v2LuoBHZm/zqpQdFCjyXv8xs0Au5
   8rfgbfwmXknkohPZXxnL+gsVh8NkzVZyITyIJC1HuU8GWW42cWUO4drSf
   FANtctiIPo1Ef/2eJXETe8kwQvW2c5Q5UuhsNxIiByyEPnbIhlfsXFRZp
   w==;
X-CSE-ConnectionGUID: W1Ervz8kS9WpovA6vRKHlw==
X-CSE-MsgGUID: k+P0mD6bT7e4l6idlyPayg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41713843"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41713843"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:49:02 -0800
X-CSE-ConnectionGUID: 4xB8vtM6Tf2sxARRtd+wzA==
X-CSE-MsgGUID: uC1esw9ASl+c8JYUarqujg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118076348"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:49:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpQld-0000000H71k-2rCc;
	Tue, 04 Mar 2025 13:48:57 +0200
Date: Tue, 4 Mar 2025 13:48:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Add ACPI ID for Sophgo SG2044 UART
Message-ID: <Z8boqRiECAvAqy04@smile.fi.intel.com>
References: <20250304070212.350155-1-inochiama@gmail.com>
 <Z8blz3pAOV9by5tB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8blz3pAOV9by5tB@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 01:36:47PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 04, 2025 at 03:02:09PM +0800, Inochi Amaoto wrote:
> > The UART on Sophgo SG2044 can be enumerated via ACPI.
> > Add ACPI ID for it.
> 
> This is fake ACPI ID. Please work with a vendor to issue the proper one.
> Vendor ACPI ID registry has no records on Sophgo:
> https://uefi.org/ACPI_ID_List?acpi_search=SophGo
> 
> NAK.

FWIW, the I2C thread has more insights and details:
https://lore.kernel.org/r/20250304070212.350155-3-inochiama@gmail.com

-- 
With Best Regards,
Andy Shevchenko


