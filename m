Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574827;
	b=qorWoFraCd0bb29qRypmlVjMU4tkj3LLHmT578NmST9FW1ODELQmAC25JDP9kcSdETNI
	 5gc5qWB3DQjSWic7XcfyVqYHc1moSBek/hxPYGQCFhSgGu35NtcBgTYMGKwCDg1WyQB4L
	 u58/U2worRNKcLNVcSWk64E9gippSc6HGDGkGKMtG2CEnS4cPjYo9GJfSziGK6rX/MHfC
	 AxSgVYMpU88mEhG50ZrvqFYePb7gxp+vUG9dvXfKmTNT2FnsSPnaaWxxvTC8HdlZ2KOU6
	 HsuTabP1a/FgQIUkj2v/0/73cI+aUHRf3JRkkU4cP8SVLUhOWXE1awMXCzaV4HRjIJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574827;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qx9lvlJFiOXl2YcBYTYDEbTYQw5QvLIYvqfDlGOKQ8w=;
	b=dx2nVxYU7d8qw9N4vrxS0zxsikdQX9PWZIosT6Cmt6hZDCJXpmqiz7vpTIzsBXR/hSG7
	 rxdUTIEfbPmY3BkwZB6+AqD4VNGvgbVU02Flwz/NZa+kO9L81fR7q1hpZeHAzjEoKWLcE
	 FvupxHt5S1MD0Vtkj6O8nawadQ+MyUAR95BbsZdUhIhxYpIi/eoR7wnvB5wRlV1nxkka8
	 FWX51jB5SNaFNeM8Ygh3rGQ+2Bic7XFlPgONohmShccic4eXEy5RgfAdnGGS0RrmT+AXD
	 J0R5ACnkEhdDz3u/T+EbwpvOLvZdWqVVZLieLQ6X5GwZcnR+ykgO7BtYS+VbkeXQ36g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mjOnZhJn;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73243606A31A;
	Wed, 21 Oct 2026 09:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73243606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mjOnZhJn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792574827; x=1824110827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HytOmcW56eDQIDDYwdyKPW3M2fCcKHDx/VAyTZ94b5c=;
  b=mjOnZhJnnHkxsDoyojUUO1NyfqQ7E0UphnGCtlIe2STnuXWX7A5fHxhV
   /Z0X890rBbO1yThEZsj6xm+FvM+Cpno/h1Tid1UQ3yR7udw63Pv2F+lBU
   i4T8VFNCXtQlPBUbfk+pXBOKIcYfleVgnPSy5oQGJq2rJ7BwADjvM6vLC
   YhaAGmof+Wup49qysy0JAynVFSV4AEy1/kBceeeQEpWgHmVJtk/pJ3Zci
   GgHVT05N118e9LSkeI0sxfhwpLO82eJz3l7mrvTBD9jZEnAz5qNI49cCT
   lTkMdcHu5s/fvHRnXX+UhE7TXHgHflhlJlLWQwO6dJMogzMPzbKB/sKjM
   g==;
X-CSE-ConnectionGUID: w/hDhCsUSdiorWDWhmxNWg==
X-CSE-MsgGUID: pofHKWG9R4CrpowVI6686w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1167643"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1167643"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:27:07 -0700
X-CSE-ConnectionGUID: beP8jZ3hRlWqXO0REC91Nw==
X-CSE-MsgGUID: bUETF+PZRJaR8RpfkXvcxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3393920"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:27:04 -0700
Date: Wed, 21 Oct 2026 12:27:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Kiyokazu SUTO <suto@ks-and-ks.ne.jp>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] [v4] serial: 8250: remove obsolete PORT_RSA support
Message-ID: <atiFZf9dFO3rtsYr@ashevche-desk.local>
References: <20261021081746.3278002-1-arnd@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021081746.3278002-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 10:17:45AM +0200, Arnd Bergmann wrote:

> For all I can tell, the RSA support in the 8250 driver is not functional
> and has not been for a long time.
> 
> The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
> alternative to regular ISA serial ports, and it was discontinued in
> 2002. Linux support was added by Kiyokazu SUTO in 2000[2]. The company
> also made PCI versions of this device, but Linux never supported those.
> 
> It seems that a patch to setserial would be required in order to set
> PORT_RSA when not using autoconfiguration, and this was never merged.
> Autotoconfiguration in turn requires passing probe_rsa=IOPORT arguments
> at boot or module load time, which is not how any other uart drivers
> work any more since linux-2.4.
> 
> This patch removes all code related to the RSA support, with the exception
> of the user-visible PORT_RSA definition. I had originall sent this in
> 2011 [3], but did not follow up at the time.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


