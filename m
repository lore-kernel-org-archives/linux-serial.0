Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB446419306;
	Mon, 29 Jun 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746177; cv=none; b=lmGjB2TNpQOARTdfbeQHkZLY57+P3b8wt9kQkf9aw+fp7+FwUZpOtlGbPJuXHKTC6RSXVl4FU725De9A3PZ/rJyBydNV4rBLLrqy0w/Zo2Lqd8VBLyT00QSrmaJQbxQWG1gVoatAvXGzuUnntNou+aDolvGgdEBclfru5q3A49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746177; c=relaxed/simple;
	bh=jToKu4JhJUOQ3mr8GPRlgakVMw5/co1TQlpirGGI+ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5E5MJJSsX3zuH7AFuTBzJWQqvKJTVIST6babjLyRqpcruQ+Uqs6BF7A7T5avfbePa9GSoj8I6kWTxGNoLMiBBbOIT74flVuW19OT2LMI2o9PMTH9xNKiSSzCSSpAWLdbpnfO4RNbepQI5/kOcv6uA25WKexZ3apU5jyIO6Sqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jykkAq/4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jykkAq/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782746175; x=1814282175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jToKu4JhJUOQ3mr8GPRlgakVMw5/co1TQlpirGGI+ps=;
  b=jykkAq/4Kenq+JdjUQjN8y6MHOCKceFTuqBp+kv6GXsbBQjuiH8ZTSCd
   8N3+9imO0dMujAbq5aDv1OeJghCGuQYdjL3LBBWOX+SqARocEIJiXtrW1
   JrnhGC85kEo6JI0MpVjqHx/CxFQIf+egJJvGgJAsYbvJgrXSlr7p0WZuM
   1Z4rvsTbUa0WcH3yiEg8aRD7G1dKGXMA/v/+9SDDhndfzpOsKfH3exwpg
   KPm35mMobZsP5ZF5L8B/9yXBZM5UCOCipgzkd5397lgyF4SjzxcQCE5pK
   kXjTfsYI2V0ZX7ZufjjYQwhewCdWt6uxOckv7GuV0EwrIWy5LaamSx/QT
   g==;
X-CSE-ConnectionGUID: qxkIFW54QKSui/6Si019WA==
X-CSE-MsgGUID: 02NUpSjvRmSO0VkLZ1WVPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83527873"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83527873"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:16:15 -0700
X-CSE-ConnectionGUID: z8kivDqPRqSTBvUkWQCmEg==
X-CSE-MsgGUID: rB4dl+gFReiCmBRnEbreXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="275212561"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:16:12 -0700
Date: Mon, 29 Jun 2026 18:16:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Yicong Yang <yang.yicong@picoheart.com>,
	linux-serial <linux-serial@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, geshijian@picoheart.com,
	yangyang.8776@picoheart.com, yanligen@picoheart.com
Subject: Re: [PATCH] serial: 8250_dw: Prefer SRBR in bogus RX timeout
 workaround if available
Message-ID: <akKMOlRjl3R-uR3b@ashevche-desk.local>
References: <20260629075510.32854-1-yang.yicong@picoheart.com>
 <akKHoQOr2Vq9CA1Z@ashevche-desk.local>
 <60c05ab5-c805-dd78-1b6b-9c78ee7d7148@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60c05ab5-c805-dd78-1b6b-9c78ee7d7148@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 06:14:02PM +0300, Ilpo Järvinen wrote:
> On Mon, 29 Jun 2026, Andy Shevchenko wrote:
> > On Mon, Jun 29, 2026 at 03:55:10PM +0800, Yicong Yang wrote:

...

> > >  /* Offsets for the DesignWare specific registers */
> > > +#define DW_UART_SRBR_0	0x0c /* Shadow Receive Buffer Register */
> > 
> > Is this a name per DesignWare databook for UART? I mean that _0 part.
> 
> They have 16 consecutive registers for it. There isn't underscore in the 
> databook but n is apparently part of the name.

Oh, okay.

-- 
With Best Regards,
Andy Shevchenko


