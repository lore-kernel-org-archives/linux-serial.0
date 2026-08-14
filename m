Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F745C710;
	Fri, 14 Aug 2026 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699754; cv=none; b=iKp62/cFaJUZkr4RHRbs7MYdb7HCrNicWP7uwMwoTRre/adNks7Oy/u2eNN3eenLfRGw+2/JSuiiEDrs9SaxnkRxFz7uum79HTMZ1fvVOJj4gzzfwESfV6WFl2PENE+vhnrvulqoGp1CYSmoYzc9+wl5QRIPgecxtGECVr4SSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699754; c=relaxed/simple;
	bh=sJeQZ2qyZfCTNWWiUNH1haMgVysRvCuni+YeTle1ix0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKMaA2CZDuYHoWXa66PxB5QmiY0bmJfaU2fdfGMvyUCkUV9ORCEtfkN+ak9rSGQMYYYVhvVqYbofuY8ysN9KelOuprZTFKneBgSnmYesNvLzVNG3XmJPC2KwJlWT51v7gRXGIy+LvQeMou5gW8ziKpMHBVp/CNPSJfMrvJwSZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4s7n65Z; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4s7n65Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786699752; x=1818235752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJeQZ2qyZfCTNWWiUNH1haMgVysRvCuni+YeTle1ix0=;
  b=J4s7n65ZiI81L2H62LQpxgI2RMVeN+mY+Qc2TkqbDygyPbOggV3jFVD8
   m0jcQYeU9hFxrMW2ylnsjfFLgJkPwBkF/ddMkVHPqMJwb7GRXSSBrxmD3
   mrCG8+BJEAPeNmnDW2CrnbTmhAa+MySyNzAX4eHHz9JUGY11CmMMlW3nd
   li9/okAbvAAi5G30TaQaFaTGO3tjBw7NVGR5FfH9qqFGPNdDCsTLETdEu
   GYnfn0dwJMvlQIny7qomOGJ37MsVnYqw63R5JsZMkyfKyGlb8U5zr80iC
   FRfTP65mJgRWlZRw1aOpus7ZrHb6BfF/sjk9pEOlCNhtitK5mHX7lDDxf
   A==;
X-CSE-ConnectionGUID: cZtYLtOETnamdGKJiQ3Cpg==
X-CSE-MsgGUID: qLAtqi4NROOvZW9JIQG99A==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104811649"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="104811649"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:29:10 -0700
X-CSE-ConnectionGUID: CQn/jN8BTOGXHguAmGlaVQ==
X-CSE-MsgGUID: Gbl0fMm5S82Z82jKEm4UFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="294117337"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:29:08 -0700
Date: Fri, 14 Aug 2026 12:29:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH] serial: 8250_dw: Add device HID for AMDI0021 AMD UART
 controller
Message-ID: <an7f4VJbgXDiDl7f@ashevche-desk.local>
References: <20260813-b4-raven-ridge-uart-v1-1-fae442416ba1@beckhoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-b4-raven-ridge-uart-v1-1-fae442416ba1@beckhoff.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 08:37:05PM +0200, Steffen Dirkwinkel wrote:

> This ID is found on AMD V1202B.
> Like the AMDI0022 [1] this one works with the same match and the existing driver.
> Tested with a loopback cable.

> [1] commit 3c35d2a960c0 ("serial: 8250_dw: Add device HID for new AMD UART controller")

You can also make it a proper Link tag

Link: https://git.kernel.org/torvalds/c/3c35d2a960c0 [1]
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


