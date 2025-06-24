Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CB2D5417;
	Tue, 24 Jun 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774305; cv=none; b=puyJ93YycxigcZpl2Naj/RJ3Wt6/MIJ6Rf2cAPImrdwl9X2sY6TQvmHW3rupctG/20Pn0TFbE2LD5kUP/1y78Jl1361dr2KRCH4DLb3XyEYhdBe9jz+DfyKeK0LFYb4y1c0OY2MWNPA8Vteo+aplUEtPGTFJzt5wGNDJhgzbcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774305; c=relaxed/simple;
	bh=tGHeHiwjoKsGIG6+wBj32sI9uH+gmJAY4d57FmjQ2Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNRMpDkLX55RXm26zrJr8Lua/6nrbc2qWOtVe1+O7VJVeyYQj9Sw01DOZUEF0EhQxzGk0HhsvIhVuKBMMJiNEiG7xUABqlZVL5/SFDyH4Hn7br6gDmTyAKRNpYXQ8lpMx4OSPcCzGCvG/WCSm91gSes5W9vq1aH3pDjRLRGqhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IopnrpKs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IopnrpKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750774304; x=1782310304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tGHeHiwjoKsGIG6+wBj32sI9uH+gmJAY4d57FmjQ2Ik=;
  b=IopnrpKsx3WbzdQQA0yz3tw9FEs0uWmPLgxGUwy2ic1iFXHN7KdTvBX/
   1VRX35WW1Rjh5YqvIqK7D6mAh4lzBed/UTqazjdnta+4cifmC/sNtGE6j
   Sm5RlPP9d+DoRWCW+ljpeMv3KxzafQ+oSVRpiBJmxZqvU4nYCZh+ctCCA
   P+90V952S039lMWPZV6BWoW1ZizB/y34vwGgAlLlkqF2ZPN9w6z19e4rq
   25EjeRYsP1e7fFIec9lyBSUzcz/WNycQ3INBmSFBlI2bDKIbvEUIj62PV
   UZ46bwKG8l7ojYdOsGGUxQYqZY4M9meVQBDOIODBqK9Nw4nlqJiHEe9Eh
   Q==;
X-CSE-ConnectionGUID: 4b8kfWP8QImCPHijUUK5mg==
X-CSE-MsgGUID: DJZGTPxrTNaCd/NU28orqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52985718"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52985718"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:11:44 -0700
X-CSE-ConnectionGUID: VLzv3fgOQ+63DWmJVWV8+w==
X-CSE-MsgGUID: 3W/ElTHBTfKag2wBWP7Ehg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151357240"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 24 Jun 2025 07:11:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1D303224; Tue, 24 Jun 2025 17:11:41 +0300 (EEST)
Date: Tue, 24 Jun 2025 17:11:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 2/5] serial: 8250: extract serial8250_iir_txen_test()
Message-ID: <aFqyHSaFqUJ6PFXo@black.fi.intel.com>
References: <20250624080641.509959-1-jirislaby@kernel.org>
 <20250624080641.509959-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624080641.509959-3-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 24, 2025 at 10:06:38AM +0200, Jiri Slaby (SUSE) wrote:
> After commit 795158691cc0 ("serial: 8250: extract
> serial8250_initialize()"), split serial8250_initialize() even more --
> the TX enable test part of this code can be separated into
> serial8250_iir_txen_test().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


