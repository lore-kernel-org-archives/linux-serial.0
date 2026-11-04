Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790678;
	b=lU7rThc0FU2Uc5yyM+bojGo8qTTXGnNePiFmGwtmW68uqKoUD8haYZvejNg6/UnVxh5w
	 J1uZZwfHWPXeq/DzLyx0PDJ1FQ0gS6M4U8Jw6E1HHmD0nP0r5HJ2b/igRAlMebd5WMB8r
	 a90MY4kSt1IqPvD7ELpXNoHkzjd9Nzth4/zdTN8Pr0oaQpEzKSVgCGFWZJmMcx6icDZEg
	 4xNwmXg7CsObHu6I1+V4Kc8BbHi2tXN8Xf8ixZmCXHRkTojViDsFLSe1SCrOoA7DGcBGP
	 3OVh6CDsuRn8HwdXZJFhAC8PbWTpHcUTfk+p5XXtboMp9y7VLfpHenQsNZ/WE02Uz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790678;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=z5IFHnqZm9zSfhGklOobB7lL8AsPY0g1xAEe6fGCMj0=;
	b=HSQmCgMIlXdhMlSL/+KIq/rwDCDiLRQNZhDno4ZYIj/0g3UPpfx2qcNHF4e0FcRJgtRL
	 myFkobUqWL3PX81E3d8G5bp7LHbrCFc3dArvubRFEJsJkJrfpshQNspryPS2i+I7V5no7
	 v5Elb3kMkmRGMXXrKA+G+1P5MqhA1TnyVAVfFJP6qmkUgacLNDpwu+NTBaTTOzkZOIQ1Z
	 2CjImaGvK2+0a4oQu3QkYq+ZevlKIJ30JKn38Hi2CUs1/KxoRSjLWIfYRw3NPwBHNJmc3
	 IuHa9TR1oeBDSnk9NjQN9vMAPruIsR0fc5Ng4n57F9+Icd70H4MHnbO+ST9HGqKebyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ly5So7Ym;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091E606A326;
	Wed,  4 Nov 2026 11:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E091E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ly5So7Ym
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793790678; x=1825326678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P0sGNjdiNu3kBFlu25tqvlWXlsMufkVWQgQpKFB1tg0=;
  b=Ly5So7Ymqw2Ccg4owdnAEv0xBK0oQSWHiyDyAxMZcIwxgGoSsWrzd5S5
   OMCaJOBzeRUmAQYnrKzGvkZ3+h4uJuEaT3Y8dFsTqnTjOk2bsDffFOnSE
   novt3GZ0afdwKtv0VJIdXXMMZKZOnofskPtOhjmBLpxFRiD8CtPJ3ynxF
   ccivO0P8z/h4oQMNUYeaGZ8NrddKH5DfFWNcV+sSkvScyg5XwAhE+V2cK
   mcPyohYp/iNmLciRJLnwBnVYJ1Vy68FO/TLxAapsn5GXZS5AbwyI/3Pmu
   TleiZwRsOErhrob2qxz2bKWzVUKfGsMWE5Iu5dw1r6ByQQjHs7/JcOHFq
   Q==;
X-CSE-ConnectionGUID: yqhTBdfcSdqGqvj77FSUmQ==
X-CSE-MsgGUID: sVEogBw5ThOfBB1qOKh88Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2440070"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2440070"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:11:17 -0800
X-CSE-ConnectionGUID: DOilswEaSPCdVlwJFrueyQ==
X-CSE-MsgGUID: SWpWVLbLRNCFkWe9KIuA5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7005982"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:11:14 -0800
Date: Wed, 4 Nov 2026 13:11:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/2] serial: core: Unify uart_get_baud_rate() success
 return paths
Message-ID: <ausSzQZOYSzTzv6Y@ashevche-desk.local>
References: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
 <alpine.DEB.2.21.2611032029130.15685@angie.orcam.me.uk>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2611032029130.15685@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 10:07:44PM +0000, Maciej W. Rozycki wrote:
> In preparation to adding extra return actions merge the two success 
> return paths in uart_get_baud_rate() into one.
> 
> Since as from commit 091ea8e5d34e ("serial: core: prevent division by 
> zero by always returning non-zero baud rate") it is now guaranteed that 
> the B0 baud rate is within [min; max], deferring to the regular return 
> path in the B0 case causes no functional change.
> 
> That is as long as max >= max(min, 9600), which I believe is always the 
> case and none of UART hardware our drivers provide support for has its 
> highest baud rate below 9600.

Same issue with the commit message — too many trailing white spaces.
After fixing that, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


