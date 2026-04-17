Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48A27B33B;
	Fri, 17 Apr 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412028; cv=none; b=CbEEfQxuzKG5qQw/VvSUWExBZWxC+M1oyelegYdQT1aJAXdlrEWy3NRkDJGOwVJKkYYs8jCGUkW2IBA2vnhB6lG+aeFivXPDixGjHoyVMcAwcysTHGfVH6vrXQFB4l78DONdnXzkiHgHtb1v3EnQKRBc1IGFk1k+nVHItvsWEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412028; c=relaxed/simple;
	bh=d0V2K7hHg944fwYwkvw6cOFWAKLw942mwZXIbway+No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHhoNwTcwgDZskdfXpYBKexkbwVEyK+wurfVEXOh4StnUJRMx8Wu4hlYCsjozxcBRBKCseysyuZK+fP0sv7YsTuUu9jFO1kL8nFSQeaKIodCae8PFbgB5gFAWr2Q96rISGnLQaQcN5cL9f/0Zbu81t5Ir1hBhsJ42bNBW9eubIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYMm6yKX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYMm6yKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776412020; x=1807948020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d0V2K7hHg944fwYwkvw6cOFWAKLw942mwZXIbway+No=;
  b=FYMm6yKX6bww98lq5Jb4PbpaWvk7W4Wb8z8Beq1dfHz2eRhwTbEk/C97
   /Bd5QcamC16xqCdZo5GXeJ0nPGRlZ2sneNXn99ooYOsoY5U/8qSBac8Wp
   +o2rDowzC8g6Xmi7WppCv8l+V+lG/ZY+UhWdEs1EJDxHaCo76ZeuVY7C6
   wPWJUlbOttkRH48HMcWVk9dNiIdUqP37cAmni6v2RhOQCm26SiUEAOlOz
   0C9HHh7zWnQ2WlqY1we2DAPfEwskgXf4TCuNjJGRqlbBv6p+zpfpfffx7
   CK/ZhvIAQN+sF5fawE6qFpX5Swm8/am6LZnqLlJzBllrLVaqqZXFyAwGZ
   w==;
X-CSE-ConnectionGUID: MAvCt3cbSEqrtdF8wZiwzQ==
X-CSE-MsgGUID: +6i2DfYSSPCX6+fJHG1MOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77295099"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77295099"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:46:55 -0700
X-CSE-ConnectionGUID: SClO325QS+K9uV0xBRh9eA==
X-CSE-MsgGUID: pMUBXXPOQ7KF7t0wTQZRzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="234959932"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:46:52 -0700
Date: Fri, 17 Apr 2026 10:46:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Zhang Xincheng <zhangxincheng@ultrarisc.com>
Subject: Re: [PATCH v2 2/2] riscv: ultrarisc: 8250_dw: support DP1000 uart
Message-ID: <aeHlaTIKm1wl0J0_@ashevche-desk.local>
References: <20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com>
 <20260316-ultrarisc-serial-v2-2-6ab3e7fa891c@ultrarisc.com>
 <abfrDBeJrValJR9a@ashevche-desk.local>
 <177641113786.3193169.8990532982066985425.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177641113786.3193169.8990532982066985425.b4-reply@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 03:32:17PM +0800, Jia Wang wrote:
> On 2026-03-16 13:35 +0200, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2026 at 02:33:23PM +0800, Jia Wang via B4 Relay wrote:

...

> > > +#define DW_UART_QUIRK_FIXED_TYPE	BIT(6)
> > 
> > Seems unrequired.
> > 
> > But to make sure, can you elaborate what's going on here?
> > What is the reads from UCV and CPR registers?
> 
> Apologies for the delayed response.
> 
> Our DW UART implementation on DP1000 does not provide the CPR/UCV capability
> registers, and reads from both registers always return 0. As a result, the
> autodetection logic in 8250_dw cannot obtain meaningful capability
> information.
> 
> To handle this, the current approach is to skip autodetection and rely on
> fixed configuration via a quirk.
> 
> If there is a preferred or more appropriate way to support DW UART instances
> without CPR/UCV, I would be happy to adjust the implementation based on your
> suggestions.

Why can't you provide a CPR value via the existing quirk?

-- 
With Best Regards,
Andy Shevchenko


