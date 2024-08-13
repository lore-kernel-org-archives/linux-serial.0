Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2E13C691
	for <linux-serial@vger.kernel.org>; Tue, 13 Aug 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537866; cv=none; b=upCHe+gtVNeIP9CGqVtKo2wHdz4xyIHPWLLfCBdnto2dGAqDiGNjPsP+KDZPMtqUsJzlXVfh46951xtDcO4RXUgUGg9coaeoL0Tnzlw1zIXvuMrXXz/fdSLlM1xflPNSnTMLK55ORBSkhyoBH2wXPRlM/2ia+3fsT0t9nB7fDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537866; c=relaxed/simple;
	bh=gYf0CeIvlOavN+tZRFmWznpJOQmhn0zNSKxgb1nXoZQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hoI43W0joM894AoqFvS11YfZZrpRrHtQp+fo+vqSrn4LUqyPug1MittkPz+vwJjRX+pNj/XU8XokWRyZNCuA4O7y+T32p2GSeajhnCl92Mk+3TWPEf/nWqKMZxcY8m8QSCo95OBpUvqxSb4BbOivGdJb4YFzUfazAJEBuE+2/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWS52qnR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWS52qnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723537864; x=1755073864;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gYf0CeIvlOavN+tZRFmWznpJOQmhn0zNSKxgb1nXoZQ=;
  b=OWS52qnRzDcgIHE9pQMDwWDPg6Nz6W/IipDRAdCLIBm1W4vP/I+i+BMJ
   1NNMEqGLS/95pgxakZ89PJIXxbdsgIWhs/tCyUiezMwVIM2PA4oYHZTn1
   nNbL/RoIFj9xjXbMISClzCAu1iEG91ako6ipZSouRIn/OE1uNvUmDYMom
   IIUm4wXMW7rPC9nwFzQxHRfJ1rJZbJ1RpzPKO3pxSk0c1W88uHjZJGIvy
   SgcXGkrqRSxy8KhiwtrP5oubxPvPk4JXJngWLJBvKzA6Gc9gTqTaWA/A4
   NUTGZ+3+MSvrH7DAAnYj9MGiYZ2XRHewBNp+gaSa9MHTWjUwTFpDyMB+b
   A==;
X-CSE-ConnectionGUID: 6uywRtBMSwOxKhZAxnXldA==
X-CSE-MsgGUID: W2t5RCgbTPO5eY73dDFgxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21328756"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21328756"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:31:04 -0700
X-CSE-ConnectionGUID: gwRocQKHQNGew5dGz1Tl7w==
X-CSE-MsgGUID: 0Eg78YCGR+GyJDLK1HbQeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="81819131"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 01:31:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Aug 2024 11:30:57 +0300 (EEST)
To: Andy Shevchenko <andy@kernel.org>
cc: Lech Perczak <lech.perczak@camlingroup.com>, linux-serial@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    =?ISO-8859-2?Q?Krzysztof_Drobi=F1ski?= <k.drobinski@camlintechnologies.com>, 
    Pawel Lenkow <p.lenkow@camlintechnologies.com>, 
    Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v2 3/3] serial: sc16is7xx: convert bitmask definitions
 to use BIT macro
In-Reply-To: <ZrpBcEVOM78RXQnl@smile.fi.intel.com>
Message-ID: <231efd2f-e402-06f9-d193-192065c5298d@linux.intel.com>
References: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com> <8cfa1c75-03f8-4071-b277-752006b576ac@camlingroup.com> <ZrpBcEVOM78RXQnl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Andy Shevchenko wrote:

> On Mon, Aug 12, 2024 at 06:56:53PM +0200, Lech Perczak wrote:
> > Now that bit definition comments were cleaned up, convert bitmask
> > definitions to use BIT macro for clarity.
> 
> In the Subject and here: BIT()
> 
> ...
> 
> >  #define SC16IS7XX_IIR_ID_MASK		0x3e     /* Mask for the interrupt ID */
> 
> While at it, why not convert the MASK(s) to use GENMASK()?
> It's logically coupled change, no need to have a separate patch.
> 
> ...
> 
> >  #define SC16IS7XX_LSR_BRK_ERROR_MASK	0x1E     /* BI, FE, PE, OE bits */
> 
> Ditto.

No. This is not GENMASK() but combination of other bits. This mask define 
should be a combination those bit defines and the comment dropped because 
it adds no value after using the bit defines directly.

> (maybe more that are not visible in the context of this patch)


-- 
 i.

