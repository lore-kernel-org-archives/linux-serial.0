Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988A485CE7;
	Mon, 28 Sep 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586343; cv=none; b=MVRQGaQ+V+GB6cEpsf/dCf93qcVm6M5/fSOKKD9WiIox9M9cxApuMXNVEfZJdsN7SpMmxuavKz1JflUYYPj82v2fEheOpGDd6Bgi9fpTIlFLv/NxRB3CR/BX5uL4YpPj2TuxLM2bKmedGCtHurVvaQdUzrEfrva40vqxwouIM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586343; c=relaxed/simple;
	bh=kR3Wv1Tir4JM5KPxkQhigKEUEM12HkBEU3ytRlA1k3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnT150C58XDJpgVK9uos81PQpPAiAry6paZHMCdLFaoavt+z7DRI55mZiMOYM896R/zs7KUvjce6cdSV4qDlwIW2Ce/+nZ+TYk0Btvuxt8IUwsEKEZq6o6OTsIlNNwQIHovfhBVmFbQOho/xuKoAmb7EbfeGmm2GhPZR0x3HYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eo+qjrad; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eo+qjrad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586342; x=1822122342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kR3Wv1Tir4JM5KPxkQhigKEUEM12HkBEU3ytRlA1k3U=;
  b=Eo+qjradTh2nYLJ6o6f2G7ZokUDRwW9IMXqYXek8NBnJwSXq1nOWhAgG
   +9JAdr14Tayp3zdpSFzzD9Q9+kEB5eIyytkigssF0aRZ6fnRo7QgHIJL8
   hl/zfBgVN/aTrURNQoHvk37GMrVpQNyNiWByNp/o2UfATqxpevIDie+8B
   cE1bvXd46oY3Ls+GOA0vAZsHbYB92b7kMCS6prK6JWWKGgAF04nzof9Kh
   61UItJyV4O00+rPZ0IOM7pc5OnlR+iBbjUM2FrXvIJh+biEegQz3/OCX+
   jKKnJ7qxWNq1mknqhulf5lyrY2ndVNyxmCSopi/oH1Q2uiGSoiQnXkaaH
   w==;
X-CSE-ConnectionGUID: 4j6LdW/OTHijXUh7qz2yCA==
X-CSE-MsgGUID: Zbw/PHoCRcaoW2jPT/zX9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101804469"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="101804469"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:05:42 -0700
X-CSE-ConnectionGUID: ELvY+UF9RzeWIl6j4fsNYg==
X-CSE-MsgGUID: Gjrb7YEFRVasfH3K/wKTwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="273604206"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:05:39 -0700
Date: Mon, 28 Sep 2026 12:05:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Malathi A <malathi.a2000@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
Message-ID: <arot4SH3vbDpKC8A@ashevche-desk.local>
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
 <97e4ab26-b147-4cf4-97f9-307903f14e61@socionext.com>
 <arUvJyvChXXcasSu@ashevche-desk.local>
 <3ea1f574-ddb5-46a6-9bc1-7a8ea84c54bd@socionext.com>
 <arZ5KxIp55qA6UA7@ashevche-desk.local>
 <faa1027c-7279-462a-9c6f-f03354b9cfd3@socionext.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa1027c-7279-462a-9c6f-f03354b9cfd3@socionext.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 03:51:09PM +0900, Kunihiko Hayashi wrote:
> On 2026/09/25 22:37, Andy Shevchenko wrote:
> > On Fri, Sep 25, 2026 at 08:32:20PM +0900, Kunihiko Hayashi wrote:
> > > On 2026/09/24 23:09, Andy Shevchenko wrote:
> > > > On Thu, Sep 24, 2026 at 06:07:37PM +0900, Kunihiko Hayashi wrote:
> > > > > On 2026/09/17 13:05, Malathi A wrote:

...

> > > > > I'm a bit concerned about the error path in uniphier_uart_resume().
> > > > > The clock may have been disabled in uniphier_uart_suspend(), and
> > > > > clk_prepare_enable() can fail when trying to enable it again.
> > > > > 
> > > > > In that case, wouldn't devres try to disable an already disabled
> > > > > clock on detach?
> > > > 
> > > > Isn't there is a guarantee that the .remove() is called with PM
> > runtime on
> > 
> > After reading a code of driver core I see that this is the opposite
> > actually.
> > The PM runtime might be off.
> > 
> > > > and get, meaning it's called with the enabled clock? But if not the
> > case,
> > > > we might use PM runtime force operations (resume and suspend in the
> > > > respective cases.
> > > 
> > > My concern was just the case where clk_prepare_enable() in the system
> > > resume callback fails, leaving the clock disabled before devres cleanup.
> > > 
> > > This driver currently only uses SET_SYSTEM_SLEEP_PM_OPS(), so I wasn't
> > > considering runtime PM here.
> > 
> > So, in such a case how do you see the scenario when system is resumed
> > (Right?
> > Otherwise we can't do anything, like detaching driver from the device.)
> > and
> > clock is disabled?
> 
> Ah, I understand your point. I was assuming that the driver could later
> be detached after uniphier_uart_resume() failed, leaving the clock disabled.

I'm not sure, I don't know if I was right. Can you confirm that this scenario
is not possible? So, it might look like CPU is resumed, some of the devices
were resumed, but this particular UART failed to resume, and now we want to
detach it. If this case is possible, I believe tons of the device drivers as
of today may be affected by the same issue (it doesn't mean that the issue
is impossible to happen, one needs to investigate deeper).

> If that sequence cannot happen after a failed system resume, then my concern
> doesn't apply.

As pointed out I'm not sure. Last time I experimented with failed resume was
long time ago.

> Thanks for pointing this out.

> In that case, I have no further concerns about the use of
> devm_clk_get_enabled() here.

-- 
With Best Regards,
Andy Shevchenko


