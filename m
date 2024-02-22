Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8F14A087
	for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614712; cv=none; b=bV5r191GnksicW/PqLLgJAm88XrGxoBn9Ky6REcMsduUQ3UGBFQ7UlXyaNTNfValsG2FX6SD0xUFqECIrlaniiR0tKJNvb2PkGEj11EL0ngsaqpPOZQDlztwx9ws5YfNdUG674aiwQc9btvL/Ud7A7M6up4KQSHOqPAA86qs8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614712; c=relaxed/simple;
	bh=kEkkk9efbMuhCeuaqMpeL4Iknrf9JZ3jhulEEwAMx0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7/2w2P3xabyYgwgeWjRC2jrICJk+nE+ZALcRsZjY4pPDnUu95yDCp9LIdio/hMLAXtNn20KITkXmDxRYrL6gZQJry8yNBnG6hq7/ZwOvH/FOz9dGZJ3Wog8fwXYYrTJivA50W6XESjHNvVY9zUb+bYq0NDXEjThX33wqdPPxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Db+G5AdE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Db+G5AdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708614711; x=1740150711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kEkkk9efbMuhCeuaqMpeL4Iknrf9JZ3jhulEEwAMx0g=;
  b=Db+G5AdEPT8Iqpya25jidmT7cHcC5MjNJ5AtDWxV9GydV4vk+RDfgXPV
   PdXkrxead0Xk9PL58ouG1j4lSiL/nuxP+L26IYnIJaN5LsLQ9wnVDr6la
   +ACOP4PrRkrgW9+wtK1lQDoWF7iHxV7jOYtShr1IAG2AkulTPPqpd2lwg
   n3yS0G4BIWsLtWBShJXsGlO1zrA5++V59Ucn58Mcpgk888PdIVDORWqAQ
   iN41pLa+L1+q9pKtiXDi7uYTcvM1JmGPSVgX8t2Ay/16r+LtD1a05aEC9
   K4aDCdkLCrnqbDIEvcckG/jxwig/OzGHpIJ098vNBw73CYlmsojrAwuhh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2708097"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2708097"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:11:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913540405"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913540405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:11:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdAji-00000006eze-2VVx;
	Thu, 22 Feb 2024 17:11:46 +0200
Date: Thu, 22 Feb 2024 17:11:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: Emit an error message if getting the
 baudclk failed
Message-ID: <ZddkMsRt1D0nTnj8@smile.fi.intel.com>
References: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222111922.2016122-2-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 12:19:23PM +0100, Uwe Kleine-König wrote:
> Instead of silently giving up, at least tell what the problem is.

...

> -		return PTR_ERR(data->clk);
> +		return dev_err_probe(dev, PTR_ERR(data->clk),
> +				     "failed to get baudclk\n");

Why not on a single line? We are fine with relaxed limits.

...

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


