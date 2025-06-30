Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C628C014;
	Mon, 30 Jun 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289199; cv=none; b=rsApfvKGuyDtiSAq+LAoZWKW8wEnbM+38B8CqZ9YldKw8F/l2CU2QH0vKp4f5keGRFCjt4yqW8qF/Th9V/169fj3LeQny+auF/Reyc6B6gTL9glLUKeF214zuaSoqHSP991xH6xCp+8sWGGFOJS01NcJDNH39C2cHHM9vLCeGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289199; c=relaxed/simple;
	bh=Z2f49MRAkcAIik6EDCw58iFDWFajLQ9xjmzjWBeVoqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZH0XKwq/cf+e+hff0wDj6cZFsBLVVjhb+AwGWJVWCqYflgrfxCD1ZYTLhLVcC3A4lC3mRG+Nr91gOWwUafS+QCXEIlimB38CjPUvg6rIKFBuiAZTc1QEi4zKkH6J3h0yPgHjBoksFk2yjEUxrLlzva3kfySBKwx3lcXXLW7vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRIuQjZP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRIuQjZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751289198; x=1782825198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2f49MRAkcAIik6EDCw58iFDWFajLQ9xjmzjWBeVoqQ=;
  b=ZRIuQjZPQZdybLJd+HwOF98JZ12SgHGTzvyVBpiGwzYRobKL5RWMaL5A
   olzTMo6MBd6h+4RrMK03TxGPb/CqtN3TuGLvgoZTwaLIvGn24BLpwzX7W
   BaaiyiYtP/pMeivDEFUm35MS7OXxL5knBkSZlLhqrtPXT6IM0V3Q9EaWn
   i5eqQ7EC9SfZjL7rl3KU2XateLl8UrgQwA7134FAERmGMrvG+QXHKytmt
   wI9H2nW7Mp4jC6QJEZ6IVHpGb3N70wIjXcvQjkrGk8/c+4maWJiPPDTcy
   I8avJTCEXspVfIqnnL5ZgGULicOrsVBDRgqFuYM3hN3px0rj6KTDiwoaN
   w==;
X-CSE-ConnectionGUID: 2M081xrxSJWCmUZd74ig/g==
X-CSE-MsgGUID: O06uZWULTIWOMLrfgztsiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53475783"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53475783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:13:17 -0700
X-CSE-ConnectionGUID: E8Oiju1TSjWVo2FwFfPkLA==
X-CSE-MsgGUID: wV9Um+L9QVS/vJetc8RE2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153996838"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 06:13:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWEJt-0000000BJYV-0Nrz;
	Mon, 30 Jun 2025 16:13:13 +0300
Date: Mon, 30 Jun 2025 16:13:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] pch_uart: Fix dma_sync_sg_for_device() nents value
Message-ID: <aGKNaKvndRhQhwwE@smile.fi.intel.com>
References: <20250630121021.106643-2-fourier.thomas@gmail.com>
 <624ba0b2-afe0-4111-96b9-8b678b6472fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624ba0b2-afe0-4111-96b9-8b678b6472fe@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 30, 2025 at 03:01:01PM +0200, Jiri Slaby wrote:
> On 30. 06. 25, 14:10, Thomas Fourier wrote:
> > The dma_sync_sg_for_device() functions should be called with the same
> > nents as the dma_map_sg(), not the value the map function returned.
> 
> Care to explain why do you intend to sync more than mapped? "should be
> called" is way to vague.

It's documented as the correct use of the DMA streaming API.
Should we go deeper and understand why?

-- 
With Best Regards,
Andy Shevchenko


