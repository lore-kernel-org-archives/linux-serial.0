Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801EC1F150D;
	Tue,  4 Mar 2025 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088215; cv=none; b=M2j1SWw9XBMGr0R7elSfCCZBnc68GrZeQP9eCSqnPh17aO9i/6ofCPK1w6YZEqBlnKs6tt29kJyqRk7ZnPI1dzkAgqiEbIWrlcBCgJM+ZpjRKmHIPfkSJpS1snYS1FmJWuwiHPwv8mZ9DME9/8scAHSW41n0nXiqN/Qwx6eSrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088215; c=relaxed/simple;
	bh=xP+mvKiw4c+UNteRK2v/uSFM3qyJRyAGsB5duS3yVYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViyucsWl7Pb7VqnF6DZmMjn7Wu8n+F4Fs9TwvjiV5XNPZV8ksEYhXdcq/6jF8j4hZz9HsqhVkL6r3OqROIgqEIjOyM0h91Bs4sSz5PqoqqW+03t1sZmH+pg2/G2B8PF+8u/VLLqPo01m19Ha7y62hPAUHtkPCNp/jtvTxfh6G4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrpDmPuJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrpDmPuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741088214; x=1772624214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xP+mvKiw4c+UNteRK2v/uSFM3qyJRyAGsB5duS3yVYY=;
  b=MrpDmPuJ8H4CwDXRMoS7/1y8jrVZj+i0N9HnDKWgV3as1ib5rUCvT0Mr
   LTRGaqPBOF0DxLjO006nYbn2WPZ7srEbwg4x7hme8D34pimvkqLMjbvtW
   h3mP+0M2hZWaXfah+m461OKA1TWCcLcuUgxFSHVF++U01CfSp0p/hzzh4
   woHs3+usfyINltXeWl2ZM63WHlPgEEcE4Ra926FmFxc5k9gMUw6g/hNp3
   QZzcou3SwiwPw9wKzlWDKX2mSAZ5wsSYh6wmWnB8QuRuiZ0RMgIfCJpBM
   3GMqoDbsAtunSGmqnWO1CTpT2FykkhvLeH2z9JwwD0FoheZ3rqE5QiUia
   g==;
X-CSE-ConnectionGUID: /oVU1T9aQainJ7sYgMo5wA==
X-CSE-MsgGUID: 05IS/H97Tfe/7112WYZSPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42029305"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42029305"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:36:53 -0800
X-CSE-ConnectionGUID: NtoCbTM8QKmi0uhCfWrvZQ==
X-CSE-MsgGUID: Nj2HdeT1RXSdSYAe58NRHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118865340"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:36:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpQZr-0000000H6kd-34r5;
	Tue, 04 Mar 2025 13:36:47 +0200
Date: Tue, 4 Mar 2025 13:36:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Add ACPI ID for Sophgo SG2044 UART
Message-ID: <Z8blz3pAOV9by5tB@smile.fi.intel.com>
References: <20250304070212.350155-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304070212.350155-1-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 03:02:09PM +0800, Inochi Amaoto wrote:
> The UART on Sophgo SG2044 can be enumerated via ACPI.
> Add ACPI ID for it.

This is fake ACPI ID. Please work with a vendor to issue the proper one.
Vendor ACPI ID registry has no records on Sophgo:
https://uefi.org/ACPI_ID_List?acpi_search=SophGo

NAK.

-- 
With Best Regards,
Andy Shevchenko


