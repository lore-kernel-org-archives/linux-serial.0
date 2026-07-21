Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0283387347;
	Tue, 21 Jul 2026 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665932; cv=none; b=Us7jHiG9Z7cHA3iHt7yV2KSeXTZOaVAr+b7+m1cH/JnoCEtNttNFMHBbocZLiAu3JscZ1OHnJcEh+iZyHrmnvHdZtDpuqOg+KxZskGNqDua6JKu+9mglgvE3OfwWCLr664D5q7ZAodY6faVyUF8Oc5F78PMtUCBJ1lxPKjpJF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665932; c=relaxed/simple;
	bh=rHCTNMCRgkxl38Sp85YxCqNcwGMrHJH8mp759YL6Aj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF+Yglgmp+pPSxaYRcwI8elQNiqfKBDAPCtvNUYpvdsobId6x4q+TyIXCy2Ql8sX0gzWUu8zbWFPKeN6Z3WN6CGaoHhS5Phq0k/XfPAz3/HUlcMuktdeIFmakEUx5nH6rPA4OsEWMxmPrwdQeAcHqk5BPYWd4PHJ3rswgKHmBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYuX7qoy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYuX7qoy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784665931; x=1816201931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rHCTNMCRgkxl38Sp85YxCqNcwGMrHJH8mp759YL6Aj8=;
  b=OYuX7qoysrljX8krnPuu8FzBlP3u0v87jGaVh4rEXYxUvb2KsG4a7q0D
   vtLpSxY99N4q35Mr1g1InoeDPUPq5dclLa1EiDnBT46oJJfZx2pLueZsL
   knIFxN+AAs2UMI03J24NDQlK4IQDSK3Gee6yz//EEdCxz4dhRxlXUGzDy
   0yIOliraoYNZd/9oHDzm+X+f5SdykUjtDRt+FG/019CsYx++RhFOAO2Tn
   2qzTdWLP/uH0aLPTn1XOaEFc5dMJsdMbzzd2xrje7hpHAsV4zD+bxa7Ha
   9BE+/KM/j71gBS7JbSAFZBswHRMrRoYcgcf8dPSjwRJMKAkCJHaFPR9NJ
   w==;
X-CSE-ConnectionGUID: zrXvl4TkTLGvQVZwRHDueQ==
X-CSE-MsgGUID: P1al5gH/T1agNLXoq/GSwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85481943"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85481943"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:32:10 -0700
X-CSE-ConnectionGUID: TLVgeB2ySti4fB4LHKJing==
X-CSE-MsgGUID: bndiI5T7QNyQl9g/zHQGNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="257334143"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:32:07 -0700
Date: Tue, 21 Jul 2026 23:32:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: remove always included kconfig.h
Message-ID: <al_XRctN6bEVEA9A@ashevche-desk.local>
References: <20260721144420.3727708-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721144420.3727708-1-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 10:44:17AM -0400, Hugo Villeneuve wrote:

> The inclusion of <linux/kconfig.h> in commit f18643843bc6 ("serial:
> max310x: fix compile errors if CONFIG_SPI_MASTER is disabled") is
> unneeded as it's guaranteed by the build starting from the commit
> 2a11c8ea20bf ("kconfig: Introduce IS_ENABLED(), IS_BUILTIN() and
> IS_MODULE()"). Remove it here.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


