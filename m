Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76864206D
	for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554384; cv=none; b=qOst4fC/xaFSVGMd9odFPxkaO4RtWtZvZyiZaHC7WPIWCzAQTeq6spKAmxKDE1rGqZ4EDahqGepBdg+dYDx77GF99aMaBGzhSDXx01BNvBR9o8RquitvSiu16uMYw/4p489yvuWyPVygvC83u+RR59PLrSNrfBLWZoXWOSdnb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554384; c=relaxed/simple;
	bh=xH15n4IK7YHFIBZeEUOIUWBrpc5uaLpajkCnjg+UQSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcOW3mUDF254LeWMs0cj8oPeJkqfkcJCqgbaCq62K6meEaxpMWgtlDi/Kbgz5ohudXJlFpcMI1rKPRIAuRy64tmMJ6KcAOGwmmEqGaACUESuv0cLIUjdxEkl68vE7+0I6CMdDrfh89jp6BCAdeefxs1HPcXa3l5BMiFipucKAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: sRdkqvQTQjWnYVvYfASp8A==
X-CSE-MsgGUID: u8P/yiToRzifohbwxaiuNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21584577"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21584577"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:06:21 -0700
X-CSE-ConnectionGUID: bYE3AF7CRcatx5g0OeRWdg==
X-CSE-MsgGUID: QyMDLcqJTr2MQlszNYtrlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58624273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:06:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sdrE7-0000000Ejmd-0OW2;
	Tue, 13 Aug 2024 16:06:15 +0300
Date: Tue, 13 Aug 2024 16:06:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lech Perczak <lech.perczak@camlingroup.com>,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
	Pawel Lenkow <p.lenkow@camlintechnologies.com>,
	Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v2 3/3] serial: sc16is7xx: convert bitmask definitions to
 use BIT macro
Message-ID: <ZrtaRjoa3MpOeQR9@smile.fi.intel.com>
References: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
 <8cfa1c75-03f8-4071-b277-752006b576ac@camlingroup.com>
 <ZrpBcEVOM78RXQnl@smile.fi.intel.com>
 <231efd2f-e402-06f9-d193-192065c5298d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <231efd2f-e402-06f9-d193-192065c5298d@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 13, 2024 at 11:30:57AM +0300, Ilpo Järvinen wrote:
> On Mon, 12 Aug 2024, Andy Shevchenko wrote:
> > On Mon, Aug 12, 2024 at 06:56:53PM +0200, Lech Perczak wrote:

...

> > >  #define SC16IS7XX_IIR_ID_MASK		0x3e     /* Mask for the interrupt ID */
> > 
> > While at it, why not convert the MASK(s) to use GENMASK()?
> > It's logically coupled change, no need to have a separate patch.

...

> > >  #define SC16IS7XX_LSR_BRK_ERROR_MASK	0x1E     /* BI, FE, PE, OE bits */
> > 
> > Ditto.
> 
> No. This is not GENMASK() but combination of other bits. This mask define 
> should be a combination those bit defines and the comment dropped because 
> it adds no value after using the bit defines directly.

I agree with you on this. I'm pretty fine with either approach.

> > (maybe more that are not visible in the context of this patch)

-- 
With Best Regards,
Andy Shevchenko


