Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5B6D1AB
	for <linux-serial@vger.kernel.org>; Tue, 16 Apr 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279605; cv=none; b=G7oVk7cJFcKSwgN3DS+40jKKdw/0mKZmGakmYm+N9RaW9z4uSjQltvACqshvPPHqNY7iHCMeKaOlNicttXwSwoZ72P5c9GQT3hR20ROTqCvpIE8hyEuopt+5euJJVM2WW8mjS85Ceh1Buqwj4wGjZtvkm1ALENfSFfc7n48+3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279605; c=relaxed/simple;
	bh=RHki9hgswAcCwahG1be67FoSObRaPr1xKn3pRdHCffs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY/t/qBXQGnM85TmM22uurB0LexrP0NJsZjwozkaJCJRqhSVSOG+UDmqLIAwzypR5/Ydij5sBeFyjboh5h0nyrdZfy+4gOnVZE07zhvnUX05fCarPaQXZzVga+8BkBDpQhtQ6SUY/9St0douNv7rbONDz1TN0y0IPBGWTbfwDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTHdmG9k; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTHdmG9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713279604; x=1744815604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RHki9hgswAcCwahG1be67FoSObRaPr1xKn3pRdHCffs=;
  b=kTHdmG9ky6GjncvS+o/ZPLZSRUsQDeHknQtZcwcexUxXMpEYjDGWXHja
   m5rNjyT9ooYTYsQCzhF+ikIIV1tBR8Wf8/7dZBVCgRZt4c7Xt1GKYKdgb
   Bpu+hcABT2do+07GEXyDNFVpo8k+1GrO4C7cCPvLayp//Cx/6lUj/ci29
   AAlvQQwVLv+djdwDnYywIJJTFeRKo3NvgvXNMe3QQA4ayUuYSXDiv4/uo
   F4Ff1AC0lm533IycX6iCOBqvHAHBsQK9yTOcLTrupASJTWRXQaQYI7NAk
   G0RAjQ5mjCbYm8330zIvbH/bGJdFLse9HgVLLGR2WtPdUkW9g4sb3GBxy
   Q==;
X-CSE-ConnectionGUID: /f+fezoZTBK4k6S+zHnqkA==
X-CSE-MsgGUID: sjnBPG2IRTepHgEsNn+Qfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234135"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26234135"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:00:03 -0700
X-CSE-ConnectionGUID: WNZ9g414TkCFzGWQM1HHTg==
X-CSE-MsgGUID: pyCVF7oXSdK5OTMJDvkxgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26926902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:00:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwkHv-00000004jAn-2vTt;
	Tue, 16 Apr 2024 17:59:59 +0300
Date: Tue, 16 Apr 2024 17:59:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: Re: NULL pointer dereference when closing a busy UART
Message-ID: <Zh6Sb-Gk_RIdHkZi@smile.fi.intel.com>
References: <luomji4bv5c54xq442csgd2ifdacjrme7bomnwbviw6pmalpgv@5uusgu3vgybm>
 <Zh2BzD3qW1j1GR_o@smile.fi.intel.com>
 <p5eesytdhdrqo5ep2nazsm4ft6oc2dw5wb3goqo5use75f6fsg@ivsxlgyyadot>
 <nhwtgw543mkannfwvtqi3oap3xrscs66gsg56cpojxnfhjbrv3@s5fqkhvyjrfh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nhwtgw543mkannfwvtqi3oap3xrscs66gsg56cpojxnfhjbrv3@s5fqkhvyjrfh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 11:52:19AM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 15, 2024 at 10:04:39PM +0200, Uwe Kleine-König wrote:
> > On Mon, Apr 15, 2024 at 10:36:44PM +0300, Andy Shevchenko wrote:
> > > On Mon, Apr 15, 2024 at 07:15:54PM +0200, Uwe Kleine-König wrote:

...

> > > You might need this
> > > 
> > > 1aa4ad4eb695 serial: core: Fix missing shutdown and startup for serial base port
> > > 
> > > on top btw.
> > 
> > Ah, that looks exactly like my issue. Thanks, I will test that an report
> > back.
> 
> It improves my situation for sure. I have yet another problem with the
> stm32 UART that is driver specfic. I'm working on that one now ...

Please, Cc me on that when publishing, I'm curious.

-- 
With Best Regards,
Andy Shevchenko


