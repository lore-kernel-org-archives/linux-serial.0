Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F952D7DE8;
	Mon, 29 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011893; cv=none; b=tZf2JT42uZ1Qf26TjHu+NES51bjLJtPo9/Z+fOjKdaY8iOxRz/+WQnEttLqq3HihzU4kjdilMt98t0LeXdOcwY6IitA9f/En4USGcbr6KBCJ3HuavibaJpFw7Htq0NoSwZKj7e9ZWo4HueqWzMmTIUUwj2ZwnvzIJXXvgZpeYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011893; c=relaxed/simple;
	bh=T26GPJaQhtJCJeNBKnKOssfyFqGUFNVtzfboQi7q0B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nru/gYWg1xP0lLONLtfDU3iqIMG7A0jxwBwPXSL1ityqh/8uejS8mPxaMhl4p/G3QrHfyv071qtGMb0IQAjWVaahI+I21FFwKXz3zhOn4LfMuQj0Iludt7ZAm8gs5JlM680tMZMzbxn9qu9IlRLQGEu5D9bFPPiX581a4BscK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuO/N3DT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuO/N3DT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767011890; x=1798547890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T26GPJaQhtJCJeNBKnKOssfyFqGUFNVtzfboQi7q0B0=;
  b=kuO/N3DTN2PlL9PwAE5XzGkKWzpAQkhaJPmYgyGfJ7eCq1efbSbCTOtK
   amaS6p5/RXNE9HMF368oEtHUh+0FEGQqTD+4+z9c14W2GI4l5pfZsbrt8
   pHrDWczh/k+7CU/MkBi6RFcGFdODzj7IHts1HuYLK8raMe+HQ9aVX+Kj9
   zrd41lb8itZ5l5/xxwhjdvk0FL2jwtwzl+RR8Ua4a4gAmii1ZKKynHop5
   HadLWJfcWOthxpfZsPG79aJxYHMUbgxTLiAkY+FRA0n6Qo7vnWmpVdlkD
   qH5EZEV7Bqu2EZcpAmmrrMqZAF2T5pocVC38uqNkMSwA5VoD+rjWR667/
   w==;
X-CSE-ConnectionGUID: CH7SUEwWRPS6EwYHDeCNbA==
X-CSE-MsgGUID: VFnN9FtCTcm8rARDtaQs1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="91275543"
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="91275543"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 04:38:09 -0800
X-CSE-ConnectionGUID: 4VvR82YOTUaht7DE9UMzWA==
X-CSE-MsgGUID: EjRVyIY1Qi+L2Y/Axs+wFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="200040247"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.31])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 04:38:07 -0800
Date: Mon, 29 Dec 2025 14:38:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
Message-ID: <aVJ2LFT-ywYzJ3Jo@smile.fi.intel.com>
References: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
 <CGME20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13@eucas1p1.samsung.com>
 <265b9083-d744-4438-b539-9e001f2138ba@samsung.com>
 <713aa37f-161d-4f08-9417-d7d2abdcdfd9@sirena.org.uk>
 <361ad06d-0478-40f9-9894-6f53d7b27eff@samsung.com>
 <hwykqbo2ktw4slmmb2iodeitd5fqfvzuec5eyvgnttyh3keo3h@cibdr37t4shy>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hwykqbo2ktw4slmmb2iodeitd5fqfvzuec5eyvgnttyh3keo3h@cibdr37t4shy>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 29, 2025 at 05:18:14AM +0200, Dmitry Baryshkov wrote:
> On Mon, Dec 22, 2025 at 11:55:26AM +0100, Marek Szyprowski wrote:

...

> I can confirm that this patch fixes the breakage on Qualcomm devices.
> Please send it as a proper patch (though I'd say, the flag should only
> be set only if dev->of_node != NULL).
> 
> An alternative is to introduce dev_set_node_from_dev() which mimics both
> dev_set_node() and device_set_of_node_from_dev().

While I am on vacation, I have a brief look at the report and fix and the
discussion. There are several ongoing tasks that may collide with this:

- the desire to split device.h, so we have something like device/fwnode.h with
all related APIs listed there

- taking these, it might be good to have device_set_used_node() as a combination
of the above and also device_is_node_used() to be used in its solely user of pin
control core

- the proper understanding of this flag to begin with and how it may be related
to ACPI-based platforms (or non-DT in general)

- with that done, it might be a room to see if the flag actually should be
somewhere in fwnode structure or elsewhere

- or we can revisit the whole design and see if we can get rid of the flag

+Cc: Linus for searching for his comments, thoughts, etc.

-- 
With Best Regards,
Andy Shevchenko


