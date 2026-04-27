Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D711CBA;
	Mon, 27 Apr 2026 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273332; cv=none; b=gQ80BAQxyWWdTzY9935QkkMHahHKx/1xverGA4qiKH3ZYapX0qARdC9aZ8A3xpzvo2s0CPUvPnOjakm0oPDTMhRrh9qnjdNtHLg9CrGzDm5xSAJ40m1G24yF1tqDVHzLizBl1Pcf41uPOzNTvGf8NtfaZHFepbLp2mo1+UblUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273332; c=relaxed/simple;
	bh=TB6KDcA3Cua/GXZI2HVQJ21jKqLcEDobo7pCmTp35kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApcOa+eYhGDYdmvuYN79EupbG8zv2gE6B2MFmhXpLxVP6TkcsfF6BoV0e2++6X3oOs72uVB0czCibPz3BZBch8jAyBHPxSI46hDStm643dt0Ngy9fERoRto7upznVCA906rITLzfLaGmcttifqVKh0EKNhdrDkJorfAO7NTeUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXyGSPpU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXyGSPpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777273329; x=1808809329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TB6KDcA3Cua/GXZI2HVQJ21jKqLcEDobo7pCmTp35kM=;
  b=HXyGSPpUMFfvy+5bVBma0k/IRy5nFvUrCLMylL5qu4hm3+3IZrKU+SHa
   zeDAHwx6nBcO+h9LAyY2BbCoThA8FM6pFHlNhsHPHPOHcTh8Wi1WZhziR
   dlVaJf2bTPZagwHDfBqRfwdK2kZr1Myk/DNbAfji6IXgSkZDyz2To8QfP
   EDam7vl/3sPe+AKpHYsAqZ2QkCwRVP8ktN0qWF2jeOBnzs30dmYDSAcSi
   pB4TkujvpXUZAuAjQn2lM9inawnY7Qw3ofWFSHWlMvOf7pJsBiu79UQTg
   AfXMpNcz3g2GG8KRUszFlNSh1Oaz0iCmoFCReCmi0waNwtqBss2GTMkJ9
   Q==;
X-CSE-ConnectionGUID: twIQ0J1NRh6Ejm0APsPAMw==
X-CSE-MsgGUID: QJ8jLZMeRR67ER97LC2eQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88754276"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88754276"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:02:07 -0700
X-CSE-ConnectionGUID: 5bVxd8GhTyKENgNsQ96GoQ==
X-CSE-MsgGUID: G2ve9QlbSRGyPNWSQF+dZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237519973"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:02:05 -0700
Date: Mon, 27 Apr 2026 10:02:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: sashal@kernel.org, miquel.raynal@bootlin.com, phil.edworthy@renesas.com,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Clean up register macros and error
 handling
Message-ID: <ae8J6uqgOarcduas@ashevche-desk.local>
References: <20260424210525.1574497-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424210525.1574497-1-a.shimko.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 25, 2026 at 12:05:24AM +0300, Artem Shimko wrote:
> Align register offset definitions for DW_UART_USR, DW_UART_DMASA,
> OCTEON_UART_USR, RZN1_UART_TDMACR and RZN1_UART_RDMACR to improve
> readability. Replace raw shift with FIELD_PREP() and GENMASK() for
> RZN1_UART_xDMACR burst field definitions — this documents that the
> field occupies bits [2:1] and prevents accidental overflow when new
> burst values are added.
> 
> Simplify ENXIO handling in dw8250_probe(): instead of explicitly
> zeroing 'err' and then checking it, use a single conditional that
> allows -ENXIO (no interrupt, fall back to polling) while treating
> any other error as fatal. No functional change intended.

There is real patch series in-flight which we want to apply.

This one may wait till that happen. You may also help reviewing that
in a way that this patch won't be needed at all (or be minimal).

https://lore.kernel.org/linux-serial/20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com/

-- 
With Best Regards,
Andy Shevchenko


