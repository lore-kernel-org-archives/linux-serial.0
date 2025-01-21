Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9F1F131A;
	Tue, 21 Jan 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466417; cv=none; b=u7zKX0X9gOuF8kA/xZBbN5jfv0J/IFh5gGXQTME6m/OBpJjGY/nyFe1eCzAMU5c/Yolvc5D2g3JyY1h2NhS8R+FjPFagL6yJA5RyZh3j1178HXsBIl9MfcsvrruMmOdhElTDarte+PoAwV7HPU5ugOZMBlNme0RFctZEECx1f0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466417; c=relaxed/simple;
	bh=C2FUf2zK1+qKzT2yzZqW2i1MUVrQfiJMV2die7mgB/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWNc80qXJMJy/GVUx+MU4dBZrzPAfxUXTCzVNQ6gh+RiCHruFpUmZhkrGwNbMlTQony/jtBi3mCAAE3ngYC2NBEKdfdQ8BYWuUPNoChGY1EZXazUFSIF7AkbRfkQnXJLTpLe+d7gB3SiZ7GpnFlwee16fX/MMgpaiktbR2z1eXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DS6Yq9O5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DS6Yq9O5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737466416; x=1769002416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C2FUf2zK1+qKzT2yzZqW2i1MUVrQfiJMV2die7mgB/k=;
  b=DS6Yq9O59LZyIPBlp2hBUaVoGridLC+fb2FEOUYz020Iq9Ax/my8Hzli
   OP5yJGimAEWr5Tk5lL2pbP7WA4r09odt2HNiy3XHcKb182dYkcb+oS+nz
   STY31vBW7gJ/XTjKIZO0Ol/XQanQ7LitZgdK/A4YGtEjQ6xnL3fiOnuPC
   TIYP7degifmWK6kVYZuuzspabh/oNSvp0m7Mw6y416RsRSVqIfk+foHP9
   65xFZVbzfgydnP/AtZEiOl5EyjmEf3l3w1ewpElMqnA+okV9Cak9j/ciZ
   bv20TbfVsvrz43Bh0WV10R/J0/4Z2NTyeHSaOPnsY9MmkT+VOXJtyTe31
   g==;
X-CSE-ConnectionGUID: P9c/vaSMRYiHSvasyr718g==
X-CSE-MsgGUID: VDOx8S5hTV+oad53VHxyQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48471799"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="48471799"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 05:33:35 -0800
X-CSE-ConnectionGUID: w9dJs8gYTcW6f14z8YMElw==
X-CSE-MsgGUID: sR4VhJHTQlGUrpQ9lS3JSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137676271"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 05:33:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1taENm-00000003m4u-1c1h;
	Tue, 21 Jan 2025 15:33:30 +0200
Date: Tue, 21 Jan 2025 15:33:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lech.perczak@camlingroup.com,
	Maarten.Brock@sttls.nl
Subject: Re: [PATCH v4] serial: sc16is7xx: Fix IRQ number check behavior
Message-ID: <Z4-iKkPHmrwD5ZBc@smile.fi.intel.com>
References: <20250121071819.1346672-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121071819.1346672-1-andre.werner@systec-electronic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 21, 2025 at 08:18:19AM +0100, Andre Werner wrote:
> The logical meaning of the previous version is wrong due to a typo.
> 
> If the IRQ equals 0, no interrupt pin is available and polling mode
> shall be used.
> 
> Additionally, this fix adds a check for IRQ < 0 to increase robustness,
> because documentation still says that negative IRQ values cannot be
> absolutely ruled-out.
> 
> Fixes: 104c1b9dde9d859dd01bd2d ("serial: sc16is7xx: Add polling mode if no IRQ pin is available")

> 

This blank line is redundant (should not exists in the tag block).
Otherwise LGTM, thanks for pursuing this!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


