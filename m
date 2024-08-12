Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724B1804F
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482620; cv=none; b=AFyyNHRaUA6rAA1fl+8f1ey92ccv48viDtxO037GwPiLduMF8nCvA8URgFHG/O/WiAvRx3XhJSbgWZqBhtJMp0YE81Z2LFGerbvyg9WaQqYcppnQ/DWrvV6UYZRhorjEKZWtWzZaY/QRDtLiIHL3EWBuph0kQ5/7P4uNp4zzkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482620; c=relaxed/simple;
	bh=9SOdVIArhy7z+5+TXrwTARoAXOw2glHJutebDxJBUrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLnc7U4SteQvZAMA6byVs0dzjoVnDd3kKurRN7+HiMhakUEIJc7ZZDVZd1ykAfQ1nzgm4w9SjbKraVkqxEjJyWnaztNJRdWH/CM7MSm5sCeNEj6wI5mXlWdt9bXq8ts258YxrVngw5c8hKZWj4IelNyGiM+Dh3rMgk+3Bm7d+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: F9hFydvHSTuj55VOh94OiQ==
X-CSE-MsgGUID: 8hx2w7d+TOKzNbKIUe2qbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21581205"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21581205"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:09:40 -0700
X-CSE-ConnectionGUID: d/xXgYowRs+kEXYPf8/ghA==
X-CSE-MsgGUID: iRopz5RcT92BDDdnepWMNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="57981058"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 10:09:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sdYY2-0000000EQK5-2Ebk;
	Mon, 12 Aug 2024 20:09:34 +0300
Date: Mon, 12 Aug 2024 20:09:34 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lech Perczak <lech.perczak@camlingroup.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
	Pawel Lenkow <p.lenkow@camlintechnologies.com>,
	Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v2 1/3] serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
Message-ID: <ZrpBztQpkSKEI9Kv@smile.fi.intel.com>
References: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
 <f1e730eb-1804-4a31-a4a7-1717330d3525@camlingroup.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e730eb-1804-4a31-a4a7-1717330d3525@camlingroup.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 06:54:50PM +0200, Lech Perczak wrote:
> This definition isn't used anywhere anymore, let's delete it.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


