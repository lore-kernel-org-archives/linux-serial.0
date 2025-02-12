Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6C01F8677;
	Wed, 12 Feb 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360876; cv=none; b=ZD6HO4/Yfm2+fTYEpLDkyHCY2tg0N9NjmAV/R+U1E4hUSqzIk2s347IsJmaD/3C1Sunc+yDxvozimiZJp19A7vnOOwK2m2fv5pnJ+xgUS2ETs1JiS0mb7iRjA8qYCMifb2OQh5paPxprHAPPqWUrQe5wKJDs60E3U+qPiaY6YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360876; c=relaxed/simple;
	bh=hum2AV6g62eH6S1OhXgMsfw49FlheJUL4VYseGM6RI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZE020ubLhXke0OZi+DnBELSqjKVgTvk+w+DyXWl3V7pwHJ+q220kZA4jOj3uKPl4YE8DNBwqKehwrSt/DX/I+aK0eeaL7UlhUWsyf5TXfcPaLPzd8oF/zTd/NUt0/nLZYYpW7vSebrqntcoPnJMnRnz3rWMt9moHN7yybJFqyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG/BX3g4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG/BX3g4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739360873; x=1770896873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hum2AV6g62eH6S1OhXgMsfw49FlheJUL4VYseGM6RI0=;
  b=kG/BX3g4sCVFMpHGzGUVcv19rzQQB0uTneU2YL50r82g55lcWG1Lxw3M
   Pib9e079j5xTiluB+tmTk4H8BROXwXFnu2eOAlibUIjd2ojoggcnfg9Lv
   UqZdRtTW76TYSWRGt7Gcp2UCCwJV6ZMkFaAASwtwmzrMAzad/zojwcIUl
   ds0pIsE1bfOCge/T9c28MlR5aY02VETtlZzVdichGpUEKtmEeAP9E7oFl
   RUgWKjeJerDxM2aeQCE+n5+BYgAM907BJttrJ2sAEMGCPtaYBXjhrpcgv
   dsmD8JWQkGLabwS5Le7uiM1LbFajY5xXc95cZRvyFwQQLSENSta5/b62w
   A==;
X-CSE-ConnectionGUID: Qc+u/fRcTFGwPtF8p16vgw==
X-CSE-MsgGUID: 0ZUfh1zqRhCucFl4RZfDuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43941115"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43941115"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:47:53 -0800
X-CSE-ConnectionGUID: eSXLdIOiSeaxFRdbMzoupA==
X-CSE-MsgGUID: ikxHE1ioR3aztkLfkNI92w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112782602"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:47:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiBDZ-0000000Ap3S-3Sqp;
	Wed, 12 Feb 2025 13:47:49 +0200
Date: Wed, 12 Feb 2025 13:47:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Call dw8250_quirks()
 conditionally
Message-ID: <Z6yKZRfy8PH64I-x@smile.fi.intel.com>
References: <20250212113817.2208483-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212113817.2208483-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 01:38:17PM +0200, Andy Shevchenko wrote:
> Not all the cases provide the driver data, that is represented by
> an object instance of struct dw8250_platform_data. Id est the change
> missed the case when the driver is instantiated via board files as
> pure platform driver. Fix this by calling dw8250_quirks() conditionally.
> This will require splitting dw8250_setup_dma_filter() out of dw8250_quirks().

Scratch it, hit send too early, v2 is coming.

-- 
With Best Regards,
Andy Shevchenko


