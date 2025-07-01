Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C32459C7;
	Tue,  1 Jul 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378036; cv=none; b=IKtVkRLL/3XnLeRxWFLiYS2ik4r4n0L2DCXpojcan0Gv9h7sEfWQRRlI22tj4AkWOnG4tPFo7Pd3l/d3BGI8mSXpCw99dPXyrAhSAvr3av12t0tNmT87SqNsE+O4vAZDQDm6chNZTzKalC4ZcbmeazUknqCngTdkBdC2KCAa/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378036; c=relaxed/simple;
	bh=w3O6JX+TFxgUQvh9AQY+xLMJfuINSkF/pchzYSsDsm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGKWZMgW+JphHRiOy0y5pW2kc0mB9MSJPUMwE83V41SU94yzgenR0hLc6BnqOjjzxJU7yRE8ZVRWfNaIM2osy8yWqfgUL8q1/z14cpfKYtVu3b06QX4xg7oYzxCLrvsPxf69hSFMyaRRm2qnBVDDaO084jQKPyZOiFQAX05UGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVnWrVc4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVnWrVc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751378035; x=1782914035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3O6JX+TFxgUQvh9AQY+xLMJfuINSkF/pchzYSsDsm4=;
  b=JVnWrVc4Sdg6EuEXewWhX66nVQBw4yf0Npr3eospz/L4pOlQmmuy9mNM
   6DViAW7/FafB4umssOy87J3xTZuBXIMAFU2vBEnC8QUZTS1xwOkXJJDZK
   zObekoEsw/LsQq/nZ6F0FdahlAlwnxdmFSfZmcMXhxPfo8psUsWrzitwR
   Mjl+HM1sNI0HTkFfam+gcAsB7/ev8/B+T/aTwJQA2+G9lHLeZYNv15hdB
   gqtCDku3fUhKfI7bEtFbbwfn96HJdMtxf60kwpZKGfOT+vReo5ZBDLsUQ
   ju6jcNTMZyn/XcaWkYLOjT4a+PGrP8JtQ5g5pZlKsOepSlc/16kFaIIJv
   A==;
X-CSE-ConnectionGUID: 9/x2d6VJQDWN/fIqY9P4WQ==
X-CSE-MsgGUID: +0/1kwUkRDaZIRnEoNcazA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57421218"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57421218"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:53:54 -0700
X-CSE-ConnectionGUID: gbz6/TwyQreIlfdtoHgxDQ==
X-CSE-MsgGUID: jcOZJOwzQwabrl2Jj/NP8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="158057304"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:53:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWbQj-0000000Bc1W-2mr5;
	Tue, 01 Jul 2025 16:53:49 +0300
Date: Tue, 1 Jul 2025 16:53:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] pch_uart: Fix dma_sync_sg_for_device() nents value
Message-ID: <aGPobZ6reAWrRtV0@smile.fi.intel.com>
References: <20250701113452.18590-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701113452.18590-2-fourier.thomas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 01, 2025 at 01:34:52PM +0200, Thomas Fourier wrote:
> The dma_sync_sg_for_device() functions should be called with the same
> nents as the dma_map_sg(), not the value the map function returned
> according to the documentation in Documentation/core-api/dma-api.rst:450:
> 	With the sync_sg API, all the parameters must be the same
> 	as those passed into the sg mapping API.

Good enough to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


