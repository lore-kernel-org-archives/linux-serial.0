Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11747F6A;
	Mon,  6 May 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714986391; cv=none; b=ShVP7pb4IPPVuwpVStz+du8CRc+3RI9AKse62p5EX3klWh0IK/fxE71WbjTBw+DuA72qqsjn6Ymw1MWW6Mh3NiAHkhWdSTzqkYpJ2XzPggGUkc/JIXpSS5bM3IctQ8dYCPqf8OozeWg/YC8eZg9jBNl5fgh0NHMp0G6dUFldXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714986391; c=relaxed/simple;
	bh=tqLwBBsU8XUYyPZe4zlNDPBjG1jozpREhzFA84XIjlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGTXJP4/R5mWvkvjHFeys29aoJTtIOfnu0wbs2GyCC01GioMP9nWpAsAsNNRZ5gj40TBwyW3gJG47UrbjBEfFhiV7ox55IsqYJtTPgZ2ed+v5Nh39tDdJajRRDzkIk2gDIl9EwRVyyKPiWqUqk2rclmCmYD+Jh6eN7SpCmLFqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaiqW9Kt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaiqW9Kt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714986389; x=1746522389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tqLwBBsU8XUYyPZe4zlNDPBjG1jozpREhzFA84XIjlw=;
  b=PaiqW9KtLqsbB5/0R+Mcr2gKA+fApJ/tjgJwf5A42dqnqqYE/Jbd1mje
   lxZ/h994ZWh7uvEnshIavG0tXj7Jyhz+/oX+TZyv83Vmls9XUpNF8lIZy
   WlLpz0yL3NtcylkDke4QmoSi5JyGKIgBtoDRqyLH7RST6uLSBoIooQQ91
   KciMqBP0dcpgdu2P3+vHfqG88sbfj+YuuWYrJ7XdV+pnZ3kzMq7lSGJGe
   ss/vWfvRgETA1QMTXQKXE9mDgmL17pvmGCw12Px7RzPK8MD+4q0HSNvOe
   5fNBNEDYbfdC8uRaHhZqeIWgbCs8QmVPUxunN6wbLtNopaTC4exh2R/6f
   w==;
X-CSE-ConnectionGUID: YcIXLHLNRkyjkzTQ2fAkIQ==
X-CSE-MsgGUID: ooJ7V/IvT7y5tFVuUi2UBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14507898"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14507898"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:06:29 -0700
X-CSE-ConnectionGUID: 0Aohw503RB2v79zCuNVKtw==
X-CSE-MsgGUID: QBR04b7+TgGZP2UQygraXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59297196"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:06:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1s3uIj-00000004cRs-1QV6;
	Mon, 06 May 2024 12:06:25 +0300
Date: Mon, 6 May 2024 12:06:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/2] platform/surface: aggregator: Defer probing when
 serdev is not ready
Message-ID: <ZjidkdGjNzbLNxJa@smile.fi.intel.com>
References: <20240505130800.2546640-1-weifeng.liu.z@gmail.com>
 <20240505130800.2546640-2-weifeng.liu.z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505130800.2546640-2-weifeng.liu.z@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 05, 2024 at 09:07:49PM +0800, Weifeng Liu wrote:
> This is an attempt to alleviate race conditions in the SAM driver where
> essential resources like serial device and GPIO pins are not ready at
> the time ssam_serial_hub_probe() is called.  Instead of giving up
> probing, a better way would be to defer the probing by returning
> -EPROBE_DEFER, allowing the kernel try again later.
> 
> However, there is no way of identifying all such cases from other real
> errors in a few days.  So let's take a gradual approach identify and
> address these cases as they arise.  This commit marks the initial step
> in this process.

It's a bit pointless to send a new version while we haven't settled yet down on
the previous one.

Moreover, there is no added details as I asked in the previous round of review.

The decision of moving this part to serdev is up to Hans, but I think we also
can at least put TODO line here with explanations you gave in the reply to v2
that this is currently the only driver needs this and there is still a chance
that more might need it.

While writing the above paragraph I realised that this might be due to
non-standard appearance of the device in DSDT, that it gets enumerated
before the controller.

Do you have a DSDT excerpt for the controller and device parts in the order
of appearance?

-- 
With Best Regards,
Andy Shevchenko


