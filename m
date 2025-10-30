Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA925A322;
	Thu, 30 Oct 2025 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820505; cv=none; b=s5sm6rlMIFfrvqnfJ/ZMUO45YbDSkV/Y0Lk0EPj+bi6n0FGl1Ic7FVO0huvXaO8i5vHJdDhyh6eyBlyeH81RDji8RWBwpkHOJA3TZVyKdWPcANhd4kPM0tLGqiIvnPl3UZUwXWHMK6hHg6w5P7yOcvA1QO5eET7XZBn20TpXMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820505; c=relaxed/simple;
	bh=47i2DEgepMAxndsUuBwAJd8fpzk8M0+QK8TfcgJt/ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id0Fymd7bv5NIyvqKa7YIfxtx0qecNDPV3YRy3z7uIrL9I+KXOHtUXH+5RVvGGrl2K29rwYNe1X44l1/6U7N77baQZX4Zmt2ytahiTxG4NagLZ9N9XQ1kYr/9CrM/Vl+/Wv8wS8P04svRm//dCZAN4uQUZ9NPgMs41sTALGvd0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLjfLTkk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLjfLTkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761820503; x=1793356503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=47i2DEgepMAxndsUuBwAJd8fpzk8M0+QK8TfcgJt/ik=;
  b=XLjfLTkkP9rZIe/d8FiZC0GRxKkEBa8XrtkbeeS2uIv+n3CPWDNeFGTm
   q1+//E892sNStBfJJyiY+SJl9HJRaNz48dhY1c/O+jJIr7N6oKzyrQPHh
   x7ckcvCgQfNGvTsyzxCWS7IL5sZuw9yNnzKqg0YpPUHbh0OAP8W/tkIsK
   rk/OSeMcmD4FUdb95JQ2qVnKGxHxVCjE68coMhQj0FzvKcpnlW5zTCUCa
   8/SySnzTew2tEl5tnLLbf4EzKZ3PLXHxi2Vacaqu5OJA6acw3zNPx0ffm
   6b+il+ap9m3w6rlipb5LPjs772JonwVFrwJ8jm9tUSi8ZS937UtR9qZKR
   w==;
X-CSE-ConnectionGUID: /IKJY4AxTSmVtumvKeI0bw==
X-CSE-MsgGUID: iDjTkxBzRnCIuSNeuWi+1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="66573484"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="66573484"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:35:03 -0700
X-CSE-ConnectionGUID: JDpFSgCpS9WDDFBUIZaGww==
X-CSE-MsgGUID: lW9BDXOcQ+SqK554JLQ4Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186662037"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 30 Oct 2025 03:35:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 00E9896; Thu, 30 Oct 2025 11:35:00 +0100 (CET)
Date: Thu, 30 Oct 2025 11:35:00 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 11/14] serial: sc16is7xx: use KBUILD_MODNAME
Message-ID: <aQM_VBg_7JwyGGLG@black.igk.intel.com>
References: <20251027142957.1032073-1-hugo@hugovil.com>
 <20251027142957.1032073-12-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027142957.1032073-12-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 27, 2025 at 10:29:53AM -0400, Hugo Villeneuve wrote:
> 
> There is no need to redefine the driver name. Use KBUILD_MODNAME and get
> rid of DRV_NAME altogether.

Actually I am slightly against this change. The modname (and hence modalias)
are parts of an ABI (visible via sysfs). Changing the module name (file name
in this case) may inadvertently break this. Yes, it most likely not critical
in this case, but should be taken into account.

-- 
With Best Regards,
Andy Shevchenko


